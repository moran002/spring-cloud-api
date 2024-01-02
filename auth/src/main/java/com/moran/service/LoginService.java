package com.moran.service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.common.core.exception.ServiceException;
import com.common.core.model.UserInfo;
import com.common.core.utils.MD5Util;
import org.springframework.stereotype.Service;

/**
 * @author : moran
 * @date : 2023/7/13 10:16
 */
@Service
public class LoginService {


    /**
     * 检查用户信息
     *
     * @author :moran
     * @date :2023/7/13 10:19
     **/
    public void checkUserInfo(UserInfo userInfo) {
        if (userInfo == null) {
            throw new ServiceException("账号不存在");
        }
        if (userInfo.getStatus() == 0) {
            throw new ServiceException("当前账号已停用");
        }
    }

    /**
     * 检查权限
     *
     * @author :moran
     * @date :2023/8/3 9:13
     **/
    public void checkApi(UserInfo userInfo) {
        if (CollUtil.isEmpty(userInfo.getApis()) || CollUtil.isEmpty(userInfo.getRoleIds())) {
            throw new ServiceException("用户暂未分配权限, 无法登陆");
        }
    }

    /**
     * 检查密码
     *
     * @author :moran
     * @date :2023/7/13 10:20
     **/
    public void checkPassword(String inputPassword, String password, String salt) {
        if (!password.equals(MD5Util.encrypt(inputPassword, salt))) {
            throw new ServiceException("密码错误");
        }
    }

    /**
     * 密码相关信息只用于验证不存储到redis中
     * @author :moran
     * @date :2023/8/3 10:22
     **/
    public void clearSensitiveInformation(UserInfo userInfo) {
        //移除密码相关 防止解密密码
        userInfo.setPassword(null);
        userInfo.setSalt(null);
    }

    /**
     * 清空隐私信息
     * @author :moran
     * @date :2023/8/3 10:23
     **/
    public void clearHiddenInformation(UserInfo userInfo) {
        userInfo.setCorpId(null);
        userInfo.setAccount(null);
        userInfo.setStatus(null);
    }

    public void checkShopId(UserInfo userInfo) {
        if (StrUtil.isBlank(userInfo.getShopId())) {
            throw new ServiceException("用户需要绑定指定门店");
        }
    }
}
