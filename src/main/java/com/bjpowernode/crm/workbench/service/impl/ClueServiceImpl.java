package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Autowired
    private TranRemarkMapper tranRemarkMapper;

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    //查询线索
    @Override
    public List<Clue> list(int page, int pageSize, Clue clue) {
        Example example = new Example(Clue.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(clue.getFullname())) {
            criteria.andLike("fullname", "%" + clue.getFullname() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getCompany())) {
            criteria.andLike("company", "%" + clue.getCompany() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getPhone())) {
            criteria.andLike("phone", "%" + clue.getPhone() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getSource())) {
            criteria.andEqualTo("source", clue.getSource());
        }

        if (StrUtil.isNotEmpty(clue.getOwner())) {
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + clue.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);

            //2、把查询出来的用户的主键放入到集合中
            List<String> ids = new ArrayList<>();
            for(User user : users){
                ids.add(user.getId());
            }

            //3、查询用户的id在联系人表中的满足的owner
            criteria.andIn("owner", ids);
        }

        if (StrUtil.isNotEmpty(clue.getMphone())) {
            criteria.andLike("mphone", clue.getMphone());
        }

        if (StrUtil.isNotEmpty(clue.getState())) {
            criteria.andEqualTo("state", clue.getState());
        }

        //参数1:当前页码 参数2:每页记录数 改行代码等同于limit a,b
        PageHelper.startPage(page, pageSize);

        List<Clue> clueList = clueMapper.selectByExample(example);

        for (Clue clue1 : clueList) {
            User user = userMapper.selectByPrimaryKey(clue1.getOwner());
            clue1.setOwner(user.getName());
        }

        return clueList;
    }

    //保存或更新线索
    @Override
    public ResultVo saveOrUpdate(Clue clue, User user) {
        ResultVo resultVo = new ResultVo();
        //保存活动
        if (clue.getId() == null) {
            clue.setId(UUIDUtil.uuid());
            clue.setCreateTime(DateTimeUtil.getSysTime());
            clue.setCreateBy(user.getName());
            int count = clueMapper.insertSelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.CLUE_SAVE_FALSE);
            }
            resultVo.setMessage("添加线索成功");
        } else {
            clue.setEditTime(DateTimeUtil.getSysTime());
            clue.setEditBy(user.getName());
            int count = clueMapper.updateByPrimaryKeySelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.CLUE_UPDATE_FALSE);
            }
            resultVo.setMessage("更新线索成功");
        }
        resultVo.setResOK(true);
        return resultVo;
    }

    //通过id查询线索
    @Override
    public Clue queryById(String id) {
        return clueMapper.selectByPrimaryKey(id);
    }

    //批量删除线索
    //批量删除
    @Override
    public void deleteBatch(String ids) {
        //分割ids json串
        String[] arr = ids.split(",");
        //将arr数组转化给集合
        List<String> id = Arrays.asList(arr);
        Example example = new Example(Clue.class);
        example.createCriteria().andIn("id", id);
        int count = clueMapper.deleteByExample(example);
        if (count == 0) {
            throw new CrmException(CrmEnum.CLUE_DELETE_FALSE);
        }
    }

    //查询线索
    @Override
    public Clue queryClue(String id) {
        //根据主键查询线索
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //查询所有满足clueId为id的ClueActivityRelation
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);

        //通过clueActivityRelations中的activityId查找所有市场活动
        List<Activity> activityList = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            Activity activity = activityMapper.selectByPrimaryKey(clueActivityRelation.getActivityId());

            //处理活动中的owner
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());

            activityList.add(activity);
        }

        clue.setActivityList(activityList);

        return clue;
    }

    //查询其他市场活动
    @Override
    public List<Activity> selectOtherActivity(String name, String id) {
        //通过线索id查询市场活动id
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);

        //将市场活动id存入数组中
        List<String> list = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            list.add(clueActivityRelation.getActivityId());
        }

        //根据条件查询市场活动
        Example example1 = new Example(Activity.class);
        Example.Criteria criteria = example1.createCriteria();
        if (StrUtil.isNotEmpty(name)) {
            criteria.andLike("name", "%" + name + "%");
        }

        criteria.andNotIn("id", list);

        List<Activity> activityList = activityMapper.selectByExample(example1);

        for (Activity activity : activityList) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }

        return activityList;
    }

    //关联市场活动
    @Override
    public void bind(String id, String ids) {
        String[] activityIds = ids.split(",");
        ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
        for (String activityId : activityIds) {
            clueActivityRelation.setId(UUIDUtil.uuid());
            clueActivityRelation.setClueId(id);
            clueActivityRelation.setActivityId(activityId);

            int count = clueActivityRelationMapper.insertSelective(clueActivityRelation);
            if (count == 0) {
                throw new CrmException(CrmEnum.BIND_ACTIVITY_FALSE);
            }
        }
    }

    //取消关联市场活动
    @Override
    public void unbind(ClueActivityRelation clueActivityRelation) {
        clueActivityRelationMapper.delete(clueActivityRelation);
    }

    //通过id查询clue
    @Override
    public Clue selectClueById(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //处理owner
        User user = userMapper.selectByPrimaryKey(clue.getOwner());
        clue.setOwner(user.getName());
        return clue;
    }

    //线索转化
    @Override
    public void convert(String id, User user, String isCreateTransaction, Tran tran) {

        int count = 0;

        //1、查询线索
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //2、备份客户
        //判断客户是否存在
        Customer customer = new Customer();
        customer.setName(clue.getCompany());
        List<Customer> customerList = customerMapper.select(customer);
        if (customerList.size() == 0) {
            //没有客户，创建客户
            customer.setId(UUIDUtil.uuid());
            customer.setOwner(clue.getOwner());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());

            count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
            }
        } else {
            //客户存在，获取客户
            customer = customerList.get(0);
        }

        //3、备份联系人
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.uuid());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullname(clue.getFullname());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(user.getName());
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        contacts.setDescription(clue.getDescription());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());

        count = contactsMapper.insertSelective(contacts);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //4、保存客户备注
        CustomerRemark customerRemark = new CustomerRemark();
        customerRemark.setId(UUIDUtil.uuid());
        customerRemark.setCreateBy(user.getName());
        customerRemark.setEditTime(DateTimeUtil.getSysTime());
        customerRemark.setCustomerId(customer.getId());

        count = customerRemarkMapper.insertSelective(customerRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //5、保存联系人备注
        ContactsRemark contactsRemark = new ContactsRemark();
        contactsRemark.setId(UUIDUtil.uuid());
        contactsRemark.setCreateBy(user.getName());
        contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
        contactsRemark.setContactsId(contacts.getId());

        count = contactsRemarkMapper.insertSelective(contactsRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //6、将线索和市场活动的关系转换为联系人和市场活动的关系
        ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
        clueActivityRelation.setClueId(id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.select(clueActivityRelation);

        ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
        for (ClueActivityRelation activityRelation : clueActivityRelations) {
            contactsActivityRelation.setId(UUIDUtil.uuid());
            contactsActivityRelation.setContactsId(contacts.getId());
            contactsActivityRelation.setActivityId(activityRelation.getActivityId());
            count = contactsActivityRelationMapper.insertSelective(contactsActivityRelation);
            if (count == 0) {
                throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
            }
        }

        //7、判断是否有交易，如果有交易，创建交易，备份交易
        if ("1".equals(isCreateTransaction)) {
            //发生了交易
            tran.setId(UUIDUtil.uuid());
            tran.setCreateBy(user.getName());
            tran.setCreateTime(DateTimeUtil.getSysTime());
            tran.setCustomerId(customer.getId());
            count = tranMapper.insertSelective(tran);
            if (count == 0) {
                throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
            }
        }

        //8、备份交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.uuid());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setTranId(tran.getId());
        count = tranHistoryMapper.insertSelective(tranHistory);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //8、备份交易细节
        TranRemark tranRemark = new TranRemark();
        tranRemark.setId(UUIDUtil.uuid());
        tranRemark.setCreateBy(tran.getCreateBy());
        tranRemark.setCreateTime(DateTimeUtil.getSysTime());
        tranRemark.setTranId(tran.getId());
        count = tranRemarkMapper.insertSelective(tranRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //9、删除线索备注
        ClueRemark clueRemark = new ClueRemark();
        clueRemark.setClueId(id);
        count = clueRemarkMapper.delete(clueRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //10、删除线索和市场活动之间的关系
        ClueActivityRelation clueActivityRelation1 = new ClueActivityRelation();
        clueActivityRelation1.setClueId(id);
        count = clueActivityRelationMapper.delete(clueActivityRelation1);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

        //11、删除线索
        count = clueMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmEnum.CONVERT_CLUE_FALSE);
        }

    }

    //查询绑定的市场活动
    @Override
    public List<Activity> selectBindActivity(String id, String name) {
        //查询所有满足线索的市场活动
        ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
        clueActivityRelation.setClueId(id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.select(clueActivityRelation);

        //创建数组，管理市场活动id
        List<String> activityId = new ArrayList<>();
        for (ClueActivityRelation activityRelation : clueActivityRelations) {
            activityId.add(activityRelation.getActivityId());
        }

        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(name)) {
            criteria.andLike("name", "%" + name + "%");
        }

        criteria.andIn("id", activityId);

        List<Activity> activityList = activityMapper.selectByExample(example);

        for (Activity activity : activityList) {
            //处理owner
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activityList;
    }
}
