package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_clue_activity_relation")
@NameStyle(Style.normal)
public class ClueActivityRelation {

    @Id
    private String id;
    private String clueId;
    private String activityId;

}
