package com.moran.model.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * @author : moran
 * @date : 2023/7/12 8:43
 */
@Setter
@Getter
public class AccountDTO {

    @NotBlank(message = "请输入账号")
    private String account;
    @NotBlank(message = "请输入密码")
    @Size(min = 6, max = 20, message = "密码长度必须在{min} - {max} 之间")
    private String password;
}
