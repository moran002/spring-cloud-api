package com.common.core.feign;

import com.common.core.constant.CommonConstant;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * @author : moran
 * @date : 2023/7/24 16:56
 */
@Component
@Slf4j
public class FeignRequestInterceptor implements RequestInterceptor {

    @Value("${spring.application.name}")
    private String serviceName;

    @Override
    public void apply(RequestTemplate requestTemplate) {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (servletRequestAttributes == null) {
            requestTemplate.header(CommonConstant.SYSTEM_NAME, serviceName);
            return;
        }
        requestTemplate.header(CommonConstant.SYSTEM_NAME, serviceName);
    }
}
