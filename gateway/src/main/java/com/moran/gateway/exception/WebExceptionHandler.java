package com.moran.gateway.exception;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.common.core.bean.RestResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.cloud.gateway.support.NotFoundException;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

/**
 * 网关统一异常处理
 */
@Slf4j
@Order(-1)
@Configuration
public class WebExceptionHandler implements ErrorWebExceptionHandler {

    @Override
    public Mono<Void> handle(ServerWebExchange exchange, Throwable ex) {
        if (exchange.getResponse().isCommitted()) {
            return Mono.error(ex);
        }

        String message = null;
        HttpStatusCode httpStatus;
        if (ex instanceof NotFoundException) {
            httpStatus = HttpStatus.NOT_FOUND;
            message = "服务未找到";
        } else if (ex instanceof ResponseStatusException) {
            httpStatus = ((ResponseStatusException) ex).getStatusCode();
        } else {
            httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
        }

        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);

        RestResult result = RestResult.error(httpStatus.value(), StrUtil.isNotEmpty(message) ? message : httpStatus.toString());
        DataBuffer dataBuffer = response.bufferFactory().wrap(JSONUtil.toJsonStr(result).getBytes());

        log.error("[网关异常处理]请求路径:{},异常信息:{}", exchange.getRequest().getPath(), ex.getMessage());
        return response.writeWith(Mono.just(dataBuffer));
    }
}