package com.common.core.controller;

import com.common.core.constant.CommonConstant;
import com.common.core.utils.PageUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Objects;

/**
 * @author : moran
 * @date : 2023/7/4 15:18
 */
public class Controller {

    /**
     * 获取请求头tokenKey
     * @author 刘云
     * @date 2022/5/9 11:20
     **/
    public String getHeader(String headerKey) {
        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
        return request.getHeader(headerKey);
    }

    /**
     * 开启分页
     */
    public void startPage() {
        PageUtil.startPage();
    }

    /**
     * request
     */
    public HttpServletRequest getRequest() {
        return  ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
    }

    /**
     * response
     */
    public HttpServletResponse getResponse() {
        return ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getResponse();
    }

    /**
     * 获取用户ID
     * @author :moran
     * @date :2023/7/7 9:49
     **/
    public String getUserId() {
        return getHeader(CommonConstant.USER_ID);
    }

    /**
     * 获取用户名称
     * @author :moran
     * @date :2023/8/3 10:25
     **/
    public String getUserName() {
        return URLDecoder.decode(getHeader(CommonConstant.USER_NAME), StandardCharsets.UTF_8);
    }
}
