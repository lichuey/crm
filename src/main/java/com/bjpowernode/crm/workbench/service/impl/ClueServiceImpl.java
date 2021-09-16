package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.mapper.ClueMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private UserMapper userMapper;

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
}
