package com.bjpowernode.crm.settings.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_user")
@NameStyle(Style.normal)
public class User {

    @Id
    private String id;//UUID
    private String loginAct;//登录账号
    private String name;//昵称
    private String loginPwd;//登录密码
    private String email;//邮箱
    private String expireTime;//失效时间
    private String lockState;//账号是否被锁定 0：锁定 1：正常使用
    private String deptno;//部门编号
    private String allowIps;//允许登录的ip
    private String createTime;//创建时间
    private String createBy;//创建者
    private String editTime;//编辑时间
    private String editBy;//编辑者
    private String img;//用户头像
}
