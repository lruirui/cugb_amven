package com.lsy.utils;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 17:46
 */
public class Result {
    private Object data;
    private String result;
    private String message;

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Result() {
    }

    public Result(String result, String message) {
        this.result = result;
        this.message = message;
    }
    public static Result success() {
        Result result = new Result();
        result.setResult("success");
        return result;
    }
    public static Result success(String message) {
        Result result = new Result();
        result.setResult("success");
        result.setMessage(message);
        return result;
    }
    public static Result success(String message,Object data) {
        Result result = new Result();
        result.setData(data);
        result.setResult("success");
        result.setMessage(message);
        return result;
    }
    public static Result success(Object data) {
        Result result = new Result();
        result.setData(data);
        result.setResult("success");
        return result;
    }
    public static Result fail() {
        Result result = new Result();
        result.setResult("fail");
        return result;
    }
    public static Result fail(String message) {
        Result result = new Result();
        result.setResult("fail");
        result.setMessage(message);
        return result;
    }
}
