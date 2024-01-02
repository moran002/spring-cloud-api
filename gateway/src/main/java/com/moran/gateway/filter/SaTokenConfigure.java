package com.moran.gateway.filter;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.reactor.filter.SaReactorFilter;
import cn.dev33.satoken.router.SaHttpMethod;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.util.SaResult;
import com.common.core.exception.NotLoginException;
import com.common.satoken.StpAdminUtil;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class SaTokenConfigure {
    @Resource
    private IgnoreUrlsConfig ignoreUrlsConfig;

    @Bean
    public SaReactorFilter getSaReactorFilter() {
        return new SaReactorFilter()
                // 拦截地址
                .addInclude("/**")
                // 开放地址
                .addExclude("/favicon.ico")
                // 鉴权方法：每次访问进入
                .setAuth(obj -> {
                    SaRouter.match(ignoreUrlsConfig.getOpens()).stop();
                    //白名单只需要登录即可
                    SaRouter.match(ignoreUrlsConfig.getWhites()).check(r -> {
                        StpAdminUtil.checkLogin();
                    }).stop();

                    //非白名单需要进行权限校验
                    String path = SaHolder.getRequest().getRequestPath();
                    if (StpAdminUtil.isLogin()) {
                        SaRouter.match("/**").check(r -> StpAdminUtil.checkPermission(path));
                    } else {
                        throw new NotLoginException("非法请求");
                    }
                })
                // 异常处理方法：每次setAuth函数出现异常时进入
                .setError(e -> SaResult.error(e.getMessage()))
                // 前置函数：在每次认证函数之前执行
                .setBeforeAuth(obj -> {
                    // ---------- 设置跨域响应头 ----------
                    SaHolder.getResponse()
                            // 允许指定域访问跨域资源
                            .setHeader("Access-Control-Allow-Origin", "*")
                            // 允许所有请求方式
                            .setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE")
                            // 有效时间
                            .setHeader("Access-Control-Max-Age", "3600")
                            // 允许的header参数
                            .setHeader("Access-Control-Allow-Headers", "*");
                    // 如果是预检请求，则立即返回到前端
                    SaRouter.match(SaHttpMethod.OPTIONS)
                            // 执行back函数后将停止匹配，也不会进入Controller，而是直接将 back参数 作为返回值输出到前端
                            .back();
                });
    }
}
