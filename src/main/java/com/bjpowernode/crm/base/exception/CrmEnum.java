package com.bjpowernode.crm.base.exception;

public enum CrmEnum {

    USER_LOGIN_CODE("001-001-001","验证码输入错误"),
    USER_LOGIN_LOGINACTANDPWD("001-001-002", "用户名或密码错误"),
    USER_LOGIN_LOGINTIMEEXPIRE("001-001-003", "登录时间失效"),
    USER_LOGIN_LOGINLOCT("001-001-004", "用户被锁定"),
    USER_LOGIN_LOGINIPNOTALLOW("001-001-005", "用户ip不被允许"),
    USER_UPDATE_OLDPOWERISFALSE("001-002-001", "原密码不正确");

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
