package com.moran.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.common.core.controller.Controller;
import com.common.core.model.UserInfo;
import com.moran.model.SysUser;
import com.moran.service.SysUserService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

/**
 * client
 * @author : moran
 * @date : 2023/7/12 14:13
 */
@RestController
@RequestMapping("/auth")
@AllArgsConstructor
public class AuthController extends Controller {
    private final SysUserService sysUserService;

    /**
     * 获取用户登陆信息
     * @author :moran
     * @date :2023/7/12 14:13
     **/
    @GetMapping("/getUserInfoByAccount")
    public UserInfo getUserInfoByAccount(String account) {
        SysUser sysUser = sysUserService.selectByAccount(account);
        if (sysUser == null) {
            return null;
        }
        return UserInfo.builder()
                .userId(sysUser.getId().toString())
                .userName(sysUser.getName())
                .account(sysUser.getAccount())
                .password(sysUser.getPassword())
                .salt(sysUser.getSalt())
                .status(sysUser.getStatus())
                .roleIds(StrUtil.isBlank(sysUser.getRoleIds())? new ArrayList<>(): JSONUtil.toList(sysUser.getRoleIds(), String.class))
                .build();
    }

}
