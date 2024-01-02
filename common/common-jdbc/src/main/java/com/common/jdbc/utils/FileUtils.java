package com.common.jdbc.utils;

import cn.hutool.core.util.IdUtil;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * @author : moran
 * @date : 2023/8/9 14:45
 */
public class FileUtils {

    /**
     * @param target : 文件存储目录
     * @param file   : 上传的文件
     * @return 上传完成后, 文件的地址
     */
    public static String write(String target, MultipartFile file) {
        String filename = file.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            throw new RuntimeException("文件名不能为空");
        }
        File newFile = new File(target, filename);
        if (!newFile.getParentFile().exists()) {
            boolean b = newFile.getParentFile().mkdirs();
            if (!b) {
                throw new RuntimeException("目录无法创建, 可能没有权限. 目录地址:" + newFile.getParentFile());
            }
        }
        IdUtil.getSnowflakeNextId();
        try {
            file.transferTo(newFile);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return newFile.getPath();
    }
}
