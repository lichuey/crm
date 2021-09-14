package com.bjpowernode.crm.base.bean;

import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class CrmCache {

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Autowired
    private DicValueMapper dicValueMapper;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private UserMapper userMapper;

    //使用此注解需导入j2ee jar包
    @PostConstruct
    public void init() {
        //将users存入数据字典
        List<User> users = userMapper.selectAll();
        servletContext.setAttribute("userList", users);

        //使用map<String,List>来装数据
        Map<String, List<DicValue>> map = new HashMap<>();

        //查询dicTypeMapper中的所有code
        List<DicType> dicTypes = dicTypeMapper.selectAll();

        for (DicType dicType : dicTypes) {
            //获取dicType中的code
            String code = dicType.getCode();

            //通过code获取list<DicValue>
            Example example = new Example(DicValue.class);
            example.orderBy("orderNo");
            example.createCriteria().andEqualTo("typeCode", code);
            List<DicValue> dicValues = dicValueMapper.selectByExample(example);

            map.put(code, dicValues);
        }

        //存入到servletContext
        servletContext.setAttribute("map", map);

    }


}
