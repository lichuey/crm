package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_contacts_activity_relation")
@NameStyle(Style.normal)
public class ContactsActivityRelation {

    @Id
    private String id;
    private String contactsId;
    private String activityId;

}
