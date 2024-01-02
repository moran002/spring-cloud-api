package com.common.jdbc.filter;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.common.core.bean.RestResult;
import com.common.core.constant.CommonConstant;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author : moran
 * @date : 2023/7/24 15:37
 */
@Slf4j
public class GlobalInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String header = request.getHeader(CommonConstant.FROM);
        if (StrUtil.isBlank(header)) {
            errorResponse(response, "请通过网关访问资源");
            return false;
        }
        if (System.currentTimeMillis() - Long.parseLong(header) >  CommonConstant.ONE_MIN) {
            errorResponse(response, "请求超时");
            return false;
        }
        return true;
    }

    private void errorResponse(HttpServletResponse response, String msg) throws IOException {
        PrintWriter writer = response.getWriter();
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        writer.append(JSONUtil.toJsonStr(RestResult.error(msg)));
    }
}
