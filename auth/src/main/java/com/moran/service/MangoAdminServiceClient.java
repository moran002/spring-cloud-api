package com.moran.service;

import com.common.core.model.UserInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author : moran
 * @date : 2023/7/12 15:06
 */
@FeignClient(name = "admin")
public interface MangoAdminServiceClient {

    /**
     * 根据账号获取总管理端用户信息
     * @author :moran
     * @date :2023/7/13 10:26
     * @param account : 用户账号
     * @return UserInfo : 用户信息
     **/
    @GetMapping("/auth/getUserInfoByAccount")
    UserInfo getUserInfoByAccount(@RequestParam String account);
}
