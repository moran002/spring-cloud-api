package com.common.core.exception;


import java.io.Serial;

/**
 * 登陆失败异常
 *
 * @author moran
 * @date 2022/07/18
 */
public class NotLoginException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = 1L;

    public NotLoginException(String message) {
        super(message);
    }
}
