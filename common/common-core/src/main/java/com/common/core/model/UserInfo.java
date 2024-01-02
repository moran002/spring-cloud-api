package com.common.core.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * @author : moran
 * @date : 2023/7/12 8:50
 */
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserInfo {

    /**
     * 用户ID
     */
    private String userId;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 企业ID
     */
    private String corpId;
    /**
     * 门店ID
     */
    private String shopId;
    /**
     * 门店名称
     */
    private String shopName;
    /**
     * 账号
     */
    private String account;
    /**
     * 密码
     */
    private String password;
    /**
     * 密码盐
     */
    private String salt;
    /**
     * api集合
     */
    private List<String> apis;
    /**
     * 用户状态: 0: 停用,1:正常, 2:仅注册
     */
    private Integer status;
    /**
     * 角色ID集合
     */
    private List<String> roleIds;
    /**
     * openId
     */
    private String openId;
    /**
     * 会员ID
     */
    private String memberId;
    /**
     * 默认登录:1:未注册,2:个人账号,3:企业账号
     */
    private Integer loginType;
}
