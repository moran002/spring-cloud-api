package com.moran.model;

import java.util.Date;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * 表名：sys_user
 * 表注释：系统用户
*/
@Getter
@Setter
@Table(name = "sys_user")
public class SysUser {
    /**
     * 系统用户ID
     */
    @Id
    @Column(name = "`id`")
    private Long id;

    /**
     * 用户名称
     */
    @Column(name = "`name`")
    private String name;

    /**
     * 微信openid
     */
    @Column(name = "`open_id`")
    private Integer openId;

    /**
     * 账号
     */
    @Column(name = "`account`")
    private String account;

    /**
     * 密码
     */
    @Column(name = "`password`")
    private String password;

    /**
     * 密码盐
     */
    @Column(name = "`salt`")
    private String salt;

    /**
     * 手机号
     */
    @Column(name = "`mobile`")
    private String mobile;

    /**
     * 创建时间
     */
    @Column(name = "`create_time`")
    private Date createTime;

    /**
     * 更新时间
     */
    @Column(name = "`update_time`")
    private Date updateTime;

    /**
     * 状态:0:停用,1:正常
     */
    @Column(name = "`status`")
    private Integer status;

    /**
     * 角色集合
     */
    @Column(name = "`role_ids`")
    private String roleIds;
}