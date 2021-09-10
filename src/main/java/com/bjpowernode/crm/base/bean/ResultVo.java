package com.bjpowernode.crm.base.bean;

import java.util.List;

/**
 * 返回给前端的结果
 */
public class ResultVo<T>{
    private boolean resOK;//判断用户操作是否成功
    private String message;//给客户端返回的数据
    private T t;
    private List<T> list;

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public T getT() {
        return t;
    }

    public void setT(T t) {
        this.t = t;
    }

    public boolean isResOK() {
        return resOK;
    }

    public void setResOK(boolean resOK) {
        this.resOK = resOK;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "ResultVo{" +
                "resOK=" + resOK +
                ", message='" + message + '\'' +
                '}';
    }
}
