package com.bjpowernode.crm.base.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 数据字典类型
 */
@Data
@Table(name = "tbl_dic_type")
@NameStyle(Style.normal)
public class DicType {

    @Id
    private String code;
    private String name;
    private String description;

}
