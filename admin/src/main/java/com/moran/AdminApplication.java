package com.moran;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import tk.mybatis.spring.annotation.MapperScan;

/**
 * 总管理端
 * @author :moran
 * @date :2023/7/12 9:22
 **/
@EnableDiscoveryClient
@SpringBootApplication
@MapperScan("com.moran.mapper")
public class AdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(AdminApplication.class, args);
    }

}
