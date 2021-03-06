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
    ACTIVITY_SAVE_FALSE("002-001-001","市场活动保存失败"),
    ACTIVITY_UPDATE_FALSE("002-002-001", "市场活动更新失败"),
    ACTIVITY_DELETE_FALSE("002-003-001", "市场活动删除失败"),
    ACTIVITY_REMARK_SAVE_FALSE("001-001-001-001", "市场活动备注保存失败"),
    ACTIVITY_REMARK_UPDATE_FALSE("001-001-002-001", "市场活动备注更新失败"),
    ACTIVITY_REMARK_DELETE_FALSE("001-001-003-001", "市场活动备注删除失败"),
    CUSTOMER_SAVE_FALSE("003-001-001", "客户保存失败"),
    CUSTOMER_UPDATE_FALSE("003-002-001", "客户更新失败"),
    CUSTOMER_DELETE_FALSE("003-003-001", "客户删除失败"),
    CUSTOMER_REMARK_SAVE_FALSE("002-001-001-001", "客户备注保存失败"),
    CUSTOMER_REMARK_UPDATE_FALSE("002-001-002-001", "客户备注更新失败"),
    CUSTOMER_REMARK_DELETE_FALSE("002-001-003-001", "客户备注删除失败"),
    CONTACTS_SAVE_FALSE("004-001-001", "联系人保存失败"),
    CONTACTS_UPDATE_FALSE("004-002-001", "联系人更新失败"),
    CONTACTS_DELETE_FALSE("004-003-001", "联系人删除失败"),
    CONTACTS_REMARK_SAVE_FALSE("003-001-001-001", "联系人备注保存失败"),
    CONTACTS_REMARK_UPDATE_FALSE("003-001-002-001", "联系人备注更新失败"),
    CONTACTS_REMARK_DELETE_FALSE("003-001-003-001", "联系人备注删除失败"),
    CLUE_SAVE_FALSE("004-001-001", "线索保存失败"),
    CLUE_UPDATE_FALSE("004-002-001", "线索更新失败"),
    CLUE_DELETE_FALSE("004-003-001", "线索删除失败"),
    BIND_ACTIVITY_FALSE("005-001-001", "关联市场活动失败"),
    CONVERT_CLUE_FALSE("006-001-001", "线索转换失败");


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
