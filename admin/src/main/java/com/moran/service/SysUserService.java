package com.moran.service;

import com.common.core.enums.StatusEnum;
import com.moran.mapper.SysUserMapper;
import com.moran.model.SysUser;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.weekend.Weekend;

/**
 * @author : moran
 * @date : 2024/1/2 15:40
 */
@Service
public class SysUserService {
    @Resource
    private SysUserMapper sysUserMapper;

    public SysUser selectByAccount(String account) {
        Weekend<SysUser> weekend = Weekend.of(SysUser.class);
        weekend.weekendCriteria()
                .andEqualTo(SysUser::getAccount, account)
                .andEqualTo(SysUser::getStatus, StatusEnum.START.getValue());
        return sysUserMapper.selectOneByExample(weekend);
    }
}
