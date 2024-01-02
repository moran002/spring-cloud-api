package com.moran.gateway.filter;

import cn.dev33.satoken.reactor.context.SaReactorSyncHolder;
import cn.hutool.core.util.StrUtil;
import com.common.core.constant.CommonConstant;
import com.common.core.model.UserInfo;
import com.common.satoken.StpAdminUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.annotation.Order;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 重新写入新请求头
 *
 * @author : moran
 * @date : 2023/7/6 13:55
 */
@Component
@Slf4j
@Order(-200)
public class HeaderFilter implements GlobalFilter {

    /**
     * 重置请求头信息把日常常用信息放入请求头传递给到公共controller中,
     * 使用时只需要继承controller从请求头中获取信息即可
     * 如果想从sa-token 中获取信息需要 写入上下文 在完成操作后需要手动清除上下文对象
     *
     * @author :moran
     * @date :2023/7/7 8:45
     **/
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest.Builder mutate = exchange.getRequest().mutate();
        String path = exchange.getRequest().getURI().getPath();
        addHeader(mutate, CommonConstant.FROM, System.currentTimeMillis());
        //当api为登录接口时, 不需要重新设置请求头信息所以选择跳过
        if (path.endsWith(CommonConstant.LOGIN_PATH)) {
            return chain.filter(exchange);
        }
        try {
            SaReactorSyncHolder.setContext(exchange);
            encapsulationHeader(mutate);
        } finally {
            SaReactorSyncHolder.clearContext();
        }
        return chain.filter(exchange);
    }


    /**
     * 添加请求头
     *
     * @author :moran
     * @date :2023/7/13 13:29
     **/
    private void addHeader(ServerHttpRequest.Builder mutate, String key, Object value) {
        if (value == null) {
            mutate.header(key, "");
            return;
        }
        mutate.header(key, value.toString());
    }

    /**
     * 获取用户信息并重新封装请求头
     *
     * @author :moran
     * @date :2023/7/13 13:28
     **/
    private void encapsulationHeader(ServerHttpRequest.Builder mutate) {
        UserInfo userInfo = null;
        if (StpAdminUtil.isLogin()) {
            userInfo = (UserInfo) StpAdminUtil.getSession().get(CommonConstant.SESSION_KEY);
            addHeader(mutate, CommonConstant.USER_ID, userInfo.getUserId());
            addHeader(mutate, CommonConstant.SYSTEM_NAME, StpAdminUtil.getLoginType());
        }
    }

    private void addGeneratorHeader(ServerHttpRequest.Builder mutate, UserInfo userInfo) {
        addHeader(mutate, CommonConstant.USER_ID, userInfo.getUserId());
        if (StrUtil.isNotBlank(userInfo.getUserName())) {
            addHeader(mutate, CommonConstant.USER_NAME, URLEncoder.encode(userInfo.getUserName(), StandardCharsets.UTF_8));
        }
        addHeader(mutate, CommonConstant.CORP_ID, userInfo.getCorpId());

    }
}
