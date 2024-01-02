package com.moran.gateway.listener;

import com.alibaba.nacos.client.config.impl.ServerlistChangeEvent;
import com.alibaba.nacos.common.notify.Event;
import com.alibaba.nacos.common.notify.NotifyCenter;
import com.alibaba.nacos.common.notify.listener.Subscriber;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.event.RefreshRoutesEvent;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.stereotype.Component;

/**
 * 服务路由监听事件
 * @author : moran
 * @date : 2023/12/29 14:24
 */
@Component
@Slf4j
public class NacosServerListChangeEventListener extends Subscriber<ServerlistChangeEvent> implements ApplicationEventPublisherAware {
    private ApplicationEventPublisher applicationEventPublisher;

    @PostConstruct
    private void post() {
        NotifyCenter.registerSubscriber(this);
    }

    /**
     * 重新发布并刷新
     * @author :moran
     * @date :2023/12/29 14:34
     **/
    @Override
    public void onEvent(ServerlistChangeEvent event) {
        publishEvent();
    }
    public void publishEvent(){
        applicationEventPublisher.publishEvent(new RefreshRoutesEvent(new Object()));
    }

    @Override
    public Class<? extends Event> subscribeType() {
        return ServerlistChangeEvent.class;
    }

    @Override
    public void setApplicationEventPublisher(ApplicationEventPublisher applicationEventPublisher) {
        this.applicationEventPublisher = applicationEventPublisher;
    }
}
