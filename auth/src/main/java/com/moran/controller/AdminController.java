package com.moran.controller;

import com.common.core.bean.RestResult;
import com.common.core.constant.CommonConstant;
import com.common.core.model.UserInfo;
import com.common.satoken.StpAdminUtil;
import com.moran.model.dto.AccountDTO;
import com.moran.service.LoginService;
import com.moran.service.MangoAdminServiceClient;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 管理后台登录
 * @author : moran
 * @date : 2023/7/12 8:42
 */
@RestController
@RequestMapping("/admin")
@AllArgsConstructor
public class AdminController {
    private final MangoAdminServiceClient mangoAdminServiceClient;
    private final LoginService loginService;

    /**
     * 账号登录
     * @author :moran
     * @date :2023/7/12 15:12
     **/
    @PostMapping("/accountLogin")
    public RestResult login(@RequestBody @Validated AccountDTO dto) {
        UserInfo userInfo = mangoAdminServiceClient.getUserInfoByAccount(dto.getAccount());

        loginService.checkUserInfo(userInfo);

        loginService.checkPassword(dto.getPassword(), userInfo.getPassword(), userInfo.getSalt());

        loginService.clearSensitiveInformation(userInfo);

        StpAdminUtil.login(userInfo.getUserId());
        StpAdminUtil.getSession().set(CommonConstant.SESSION_KEY, userInfo);
        return RestResult.success(StpAdminUtil.getTokenValue());
    }

    /**
     * 获取个人信息
     * @author :moran
     * @date :2023/7/12 15:13
     **/
    @GetMapping("/getUserInfo")
    public RestResult getUserInfo() {
        if (!StpAdminUtil.isLogin()) {
            return RestResult.error("请登录");
        }
        return RestResult.success(StpAdminUtil.getSession().get(CommonConstant.SESSION_KEY));
    }

    /**
     * 退出登录
     * @author :moran
     * @date :2023/7/12 15:14
     **/
    @GetMapping("/logout")
    public RestResult logout() {
        StpAdminUtil.logout();
        return RestResult.success();
    }
}
