package com.common.core.constant;

/**
 * @author : yl
 * @ClassName:
 * @Description:
 * @Date: 2023/08/30  15:01
 */
public class MessageConstant {

    private MessageConstant() {
        throw new RuntimeException("can not init constant class");
    }

    public static final String ERROR_PARAMETER = "参数错误";

    public static final String ERROR_FAIL = "操作失败,请重试";

    public static final String ERROR_MACHINE_SHOP_NOT_EXIST = "无法查找到对应门店";

    public static final String ERROR_MACHINE_SECRET_KEY = "秘钥错误";

    public static final String SUCCESS = "成功";

}
