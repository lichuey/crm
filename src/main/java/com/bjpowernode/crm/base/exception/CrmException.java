package com.bjpowernode.crm.base.exception;

/**
 * 自定义异常
 */
public class CrmException extends RuntimeException{

    private CrmEnum crmEnum;

    public CrmException(CrmEnum crmEnum) {
        //调用父类构造把枚举的信息放入到堆栈中
        super(crmEnum.getMessage());
        this.crmEnum = crmEnum;
    }
}
