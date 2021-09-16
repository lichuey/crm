package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;

@Data
@Table(name = "tbl_clue")
@NameStyle(Style.normal)
public class Clue {

    @Id
    private String id;
    private String fullname;
    private String appellation;
    private String owner;
    private String company;
    private String job;
    private String email;
    private String phone;
    private String website;
    private String mphone;
    private String state;
    private String source;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;
    private String contactSummary;
    private String nextContactTime;
    private String address;

    private List<Activity> activityList;

}
