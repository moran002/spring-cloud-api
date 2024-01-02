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
 auth | 登录模块 | 用于登录登出和获取个人信息
 common | 公共模块 | 总模块
 common-core | 公共核心包 | 主要用于网关.登录以及jdbc模块
 common-jdbc | 基础开发包 | 开发逻辑项目需要继承的模块
 common-satoken | satoken工具类 | 用途同common-core
 common-tools | 工具模块对外请求参数bean | 用于需要feign调用tools模块的请求参数类
 corp | 企业相关应用模块 | 企业总模块所有企业相关api在其下创建
 corp-admin-core | 管理后台核心模块 | 管理后台基础api
 corp-admin-mp | 管理后台公众号模块 | feign调用tools-mp 基本不需要写sql
 gateway | 网关 | 基本固定一般不会进行修改
 mango | 公司内部相应应用模块 | 内部相关api再次下创建
 mango-admin | 内部管理后台模块 | 用途类似 corp-admin-core
 tools | 工具模块 | 一般只对注册到网关中的应用开放
 tools-mp | 公众号模块 | 封装所有公众号相关操作
 tools-fuel | 前庭机器接收 | 用户接收由前庭服务发送过来的信息

### nacos 使用说明
1.找到nacos的config/application.properties
2.去掉db.num与spring.sql.init.platform注释
3.修改数据库连接
4.进入bin 双击startup.cmd 启动nacos   
    
