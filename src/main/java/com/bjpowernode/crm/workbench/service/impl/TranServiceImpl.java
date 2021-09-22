package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.StageVo;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private CustomerMapper customerMapper;

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
    public List<StageVo> queryStages(String id, Map<String, String> stage2Possibility) {
        //通过id查询交易
        Tran tran = tranMapper.selectByPrimaryKey(id);

        //获取此交易的阶段和可能性
        String currentStage = tran.getStage();
        String currentPossibility = tran.getPossibility();

        //确定锚点和交易失败临界点
        int index = -1;//锚点
        int point = -1;//交易失败临界点

        //确定锚点和交易失败临界点的位置
        //1、将map转化为list
        ArrayList<Map.Entry<String, String>> list = new ArrayList<>(stage2Possibility.entrySet());
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

        //确定各个图标
        if ("0".equals(currentPossibility)) {
            //交易失败 前七个都是黑圈
            for (int i = 0; i < list.size(); i++) {
                String stage = list.get(i).getKey();
                String possibility = list.get(i).getValue();
                if (i < point) {
                    System.out.println("黑圈");
                } else {
                    if (stage.equals(currentStage)) {
                        System.out.println("红叉");
                    } else {
                        System.out.println("黑叉");
                    }
                }
            }
        } else {
            //交易成功 最后两个为黑叉
            for (int i = 0; i < list.size(); i++) {
                if (i < index) {
                    System.out.println("绿圈");
                } else if (i == index) {
                    System.out.println("锚点");
                } else if (i > index && i < point) {
                    System.out.println("黑圈");
                } else {
                    System.out.println("黑叉");
                }
            }
        }



        return null;
    }
}
