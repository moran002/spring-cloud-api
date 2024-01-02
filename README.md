### 版本说明
1. springboot3.0以上
2. java SDK 17
3. springCloud 2022.0.3
4. cloud Alibaba  2022.*
5. nacos2.2.3
6. mysql8.0.20(mysql5.7及以上版本需要支持json格式)
### 模块说明
  模块名称 | 解释 | 介绍
 ----------- | ---------- | -----
 common | 公共模块 | 总模块
 common-core | 公共核心包 | 主要用于网关.登录以及jdbc模块
 common-jdbc | 基础开发包 | 开发逻辑项目需要继承的模块
 common-satoken | satoken工具类 | 用途同common-core
 auth | 登录模块 | 用于登录登出和获取个人信息
 gateway | 网关 | 基本固定一般不会进行修改
 admin | 内部管理后台模块 | 用途类似 corp-admin-core

### nacos 使用说明
1.找到nacos的config/application.properties
2.去掉db.num与spring.sql.init.platform注释
3.修改数据库连接
4.进入bin 双击startup.cmd 启动nacos   

### 使用说明
1. docker文件夹下存放了 jar包 redis 与mysql 部署方式 
2. sql中存放nacos数据与测试使用的数据
3. api统一返回类型存放在common-core/bean包下的RestResult
4. 登录后的api可以选择继承common-core/controller包下的Controller方法,其中存放了分页与请求头信息
5. redis可以使用common-core/redis中的RedisService其中封装了常用的一些方法,可自己扩展
6. 同样common-core/utils中存放了常用的分页工具/ip获取与MD5密码盐加密工具
    
