package com.moran.gateway.filter;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 网关白名单配置
 * urls:
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Component
@ConfigurationProperties(prefix = "url.ignore")
public class IgnoreUrlsConfig {
    /**
     * 白名单url（包含服务名）
     */
    private List<String> whites;
    /**
     * open 开放不需要token的服务
     */
    private List<String> opens;
}
