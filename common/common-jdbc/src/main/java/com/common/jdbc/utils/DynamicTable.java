package com.common.jdbc.utils;

import cn.hutool.core.util.StrUtil;
import tk.mybatis.mapper.entity.IDynamicTableName;

import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 动态表名: 需要动态改变表名的类可以继承此类,
 * 并用set方法将变更的表名放入到类中之后再调用mapper方法时会自动将表名变更为tableName的值
 * public class Demo extends DynamicTable{}
 * Demo.setTableName("企业ID", 年份);
 * demoMapper.insert(demo);
 *
 * @author : moran
 * @date : 2023/12/22 8:54
 */
@Table(name = "table_name")
public class DynamicTable implements IDynamicTableName {

    @Transient
    private String tableName;
    @Override
    public String getDynamicTableName() {
        return tableName;
    }

    public String getTableName() {
        return tableName;
    }

    /**
     * 动态表名拼接
     * @author :moran
     * @date :2023/12/29 14:55
     **/
    public void setTableName(Object... params) {
        String tableName = StrUtil.toUnderlineCase(this.getClass().getSimpleName());
        StringBuilder sb = new StringBuilder();
        for (Object param : params) {
            sb.append("_").append(param);
        }
        this.tableName = tableName + sb;
    }
}
