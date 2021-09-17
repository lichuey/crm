package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_tran_history")
@NameStyle(Style.normal)
public class TranHistory {

    @Id
    private String id;
    private String stage;
    private String money;
    private String expectedDate;
    private String createTime;
    private String createBy;
    private String tranId;
    private String possibility;

}
