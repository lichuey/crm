package com.bjpowernode.crm.base.exception;

public enum CrmEnum {

    USER_LOGIN_CODE("001-001-001","验证码输入错误"),
    USER_LOGIN_LOGINACTANDPWD("001-001-002", "用户名或密码错误"),
    USER_LOGIN_LOGINTIMEEXPIRE("001-001-003", "登录时间失效"),
    USER_LOGIN_LOGINLOCT("001-001-004", "用户被锁定"),
    USER_LOGIN_LOGINIPNOTALLOW("001-001-005", "用户ip不被允许"),
    USER_UPDATE_OLDPOWERISFALSE("001-002-001", "原密码不正确"),
    USER_UPDATE_FILESUFFIXFALSE("001-002-002", "文件扩展名错误"),
    USER_UPDATE_FILESIZEFALSE("001-002-003", "文件大小错误"),
    USER_UPDATE_PASSWORD("001-002-004","用户更新密码失败"),
    ACTIVITY_SAVE_FALSE("002-001-001","活动保存失败"),
    ACTIVITY_UPDATE_FALSE("002-002-001", "活动更新失败"),
    ACTIVITY_DELETE_FALSE("002-003-001", "活动删除失败"),
    CUSTOMER_SAVE_FALSE("003-001-001", "客户保存失败"),
    CUSTOMER_UPDATE_FALSE("003-002-001", "客户更新失败"),
    CUSTOMER_DELETE_FALSE("003-003-001", "客户删除失败"),
    CONTACTS_SAVEF_FALSE("004-001-001", "联系人保存失败"),
    CONTACTS_UPDATE_FALSE("004-002-001", "联系人更新失败"),
    CONTACTS_DELETE_FALSE("004-003-001", "联系人删除失败");

    private String code;//业务码
    private String message;//错误消息

    CrmEnum(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
