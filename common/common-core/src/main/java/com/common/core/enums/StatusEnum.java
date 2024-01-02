package com.common.core.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@AllArgsConstructor
public enum StatusEnum {

    /**
     * 0:停用,1:启用
     */
    STOP(0, "停用"),
    START(1, "启用");
    @Getter
    private final Integer value;
    @Getter
    private final String name;

    public static boolean isExist(Integer value) {
        return Arrays.stream(StatusEnum.values()).anyMatch(e -> e.getValue().equals(value));
    }

    public static String getStatusName(Integer value) {
        return Arrays.stream(StatusEnum.values()).filter(e -> e.getValue().equals(value)).map(StatusEnum::getName).findFirst().orElse("");
    }
}
