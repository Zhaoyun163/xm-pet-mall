package org.exam.common;

//统一返回的包装类

public class Result {

    private String code;
    private String msg;
    private Object data;



//     成功的构造方法，不带参数
    public static Result success() {
        Result result = new Result();
        result.setCode("200");
        result.setMsg("执行成功");
        return result;
    }

//     成功的构造方法，带参数
    public static Result success(Object data) {
        Result result =  success();
        result.setData(data);
        return result;
    }

    //     失败的构造方法，不带参数
    public static Result error() {
        Result result = new Result();
        result.setCode("500");
        result.setMsg("发生了错误");
        return result;
    }

//自定义异常的构造方法
    public static Result error(String code, String msg) {
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }


    //     失败的构造方法，带参数
    public static Result error(String msg) {
        Result result = error();
        result.setMsg(msg);
        return result;

    }



    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
