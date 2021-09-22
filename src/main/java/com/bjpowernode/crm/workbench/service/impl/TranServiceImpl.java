package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.StageVo;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.bean.TranHistory;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.TranHistoryMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    //查询所有满足条件的客户名
    @Override
    public List<String> selectCustomerName(String customerName) {
        //查询所有客户
        Example example = new Example(Customer.class);
        example.createCriteria().andLike("name", "%" + customerName + "%");
        List<Customer> customerList = customerMapper.selectByExample(example);

        //将客户名存入list集合中
        List<String> list = new ArrayList<>();
        for (Customer customer : customerList) {
            list.add(customer.getName());
        }
        return list;
    }

    //查询交易的阶段图标
    @Override
    public Map<String,Object> queryStages(Integer location, String id, Map<String, String> stage2Possibility, User user) {
        //通过id查询交易
        Tran tran = tranMapper.selectByPrimaryKey(id);

        //1、将map转化为list
        ArrayList<Map.Entry<String, String>> list = new ArrayList<>(stage2Possibility.entrySet());

        //定义map
        Map<String, Object> map = new HashMap<>();

        String currentStage = null;
        String currentPossibility = null;
        if (location == null) {
            //获取此交易的阶段和可能性
            currentStage = tran.getStage();
            currentPossibility = tran.getPossibility();
        } else {
            //有索引
            currentStage = list.get(location).getKey();
            currentPossibility = list.get(location).getValue();

            //创建一个交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.uuid());
            tranHistory.setStage(currentStage);
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setCreateTime(DateTimeUtil.getSysTime());
            tranHistory.setCreateBy(user.getName());
            tranHistory.setTranId(tran.getId());
            tranHistory.setPossibility(currentPossibility);

            tranHistoryMapper.insertSelective(tranHistory);

            map.put("tranHistory", tranHistory);
        }

        map.put("index", location);

        //确定锚点和交易失败临界点
        int index = -1;//锚点
        int point = -1;//交易失败临界点

        //确定锚点和交易失败临界点的位置
        //2、遍历所有list,找到两个点的位置
        for (int i = 0; i < list.size(); i++) {
            String stage = list.get(i).getKey();
            String possibility = list.get(i).getValue();
            if (stage.equals(currentStage)) {
                index = i;
            }
            if ("0".equals(possibility)) {
                point = i;
                break;
            }
        }

        //存储StageVo集合
        List<StageVo> stageVos = new ArrayList<>();

        //确定各个图标
        if ("0".equals(currentPossibility)) {
            //交易失败 前七个都是黑圈
            for (int i = 0; i < list.size(); i++) {
                //定义StageVo
                StageVo stageVo = new StageVo();
                String stage = list.get(i).getKey();
                String possibility = list.get(i).getValue();
                if (i < point) {
                    stageVo.setType("黑圈");
                } else {
                    if (stage.equals(currentStage)) {
                        stageVo.setType("红叉");
                    } else {
                        stageVo.setType("黑叉");
                    }
                }
                stageVo.setStage(stage);
                stageVo.setPossibility(possibility);
                stageVos.add(stageVo);
            }
        } else {
            //交易成功 最后两个为黑叉
            for (int i = 0; i < list.size(); i++) {
                //定义StageVo
                StageVo stageVo = new StageVo();
                String stage = list.get(i).getKey();
                String possibility = list.get(i).getValue();
                if (i < index) {
                    stageVo.setType("绿圈");
                } else if (i == index) {
                    stageVo.setType("锚点");
                } else if (i < point) {
                    stageVo.setType("黑圈");
                } else {
                    stageVo.setType("黑叉");
                }
                stageVo.setStage(stage);
                stageVo.setPossibility(possibility);
                stageVos.add(stageVo);
            }
        }

        map.put("stageVos", stageVos);

        return map;
    }
}
