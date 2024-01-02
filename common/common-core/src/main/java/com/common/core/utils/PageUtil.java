package com.common.core.utils;

import com.github.pagehelper.PageHelper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.Objects;

/**
 * 分页工具类
 * @author 刘云
 * @date 2022/5/24 9:13
 */
public class PageUtil extends PageHelper {

    /**
     * reasonable : 强制分页参数合法, 如果分页<=0 查询第一页, 大于总页数 查询最后一页
     * pageSizeZero: 传入0 差全部
     * autoRuntimeDialect : 多库连接时, 使用true
     */

    /**
     * 设置分页信息
     */
    public static void startPage() {
        int pageNum = StringUtils.hasLength(Objects.requireNonNull(getRequest()).getParameter("pageNo"))? Integer.parseInt(getRequest().getParameter("pageNo")) : 1;
        int pageSize = StringUtils.hasLength(getRequest().getParameter("pageSize"))? Integer.parseInt(getRequest().getParameter("pageSize")) : 10;
        PageHelper.startPage(pageNum, pageSize).setReasonable(true);
    }

    public static void startPageZero() {
        int pageNum = StringUtils.hasLength(Objects.requireNonNull(getRequest()).getParameter("pageNo"))? Integer.parseInt(getRequest().getParameter("pageNo")) : 1;
        int pageSize = StringUtils.hasLength(getRequest().getParameter("pageSize"))? Integer.parseInt(getRequest().getParameter("pageSize")) : 0;
        PageHelper.startPage(pageNum, pageSize).setReasonable(true).setPageSizeZero(true);
    }

    /**
     * 获取request
     */
    public static HttpServletRequest getRequest()
    {
        try
        {
            return Objects.requireNonNull(getRequestAttributes()).getRequest();
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public static ServletRequestAttributes getRequestAttributes()
    {
        try
        {
            RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
            return (ServletRequestAttributes) attributes;
        }
        catch (Exception e)
        {
            return null;
        }
    }
}
