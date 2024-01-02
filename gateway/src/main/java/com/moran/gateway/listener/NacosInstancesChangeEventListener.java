package com.moran.gateway.listener;

import com.alibaba.nacos.client.naming.event.InstancesChangeEvent;
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
 * 初始化实例路由监听事件
 * @author : moran
 * @date : 2023/12/29 13:17
 */
@Component
@Slf4j
public class NacosInstancesChangeEventListener extends Subscriber<InstancesChangeEvent> implements ApplicationEventPublisherAware {
    private ApplicationEventPublisher applicationEventPublisher;

    @PostConstruct
    private void post() {
        NotifyCenter.registerSubscriber(this);
    }

    /**
     * 在事件回调中调用刷新方法来实现实时上线下
     * @author :moran
     * @date :2023/12/29 14:36
     **/
    @Override
    public void onEvent(InstancesChangeEvent event) {
        publishEvent();
    }

    /**
     * 重新发布并刷新
     * @author :moran
     * @date :2023/12/29 14:34
     **/
    public void publishEvent(){
        applicationEventPublisher.publishEvent(new RefreshRoutesEvent(new Object()));
    }

    @Override
    public Class<? extends Event> subscribeType() {
        return InstancesChangeEvent.class;
    }

    @Override
    public void setApplicationEventPublisher(ApplicationEventPublisher applicationEventPublisher) {
        this.applicationEventPublisher = applicationEventPublisher;
    }
}
