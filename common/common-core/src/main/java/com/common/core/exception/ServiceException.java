package com.common.core.exception;

import java.io.Serial;

/**
 * 服务异常
 *
 * @author 刘云
 * @date 2022/07/18
 */
public class ServiceException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = 1L;

    public ServiceException(String message) {
        super(message);
    }

}
