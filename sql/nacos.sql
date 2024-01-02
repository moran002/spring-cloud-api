/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : nacos

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 02/01/2024 16:17:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (96, 'gateway-dev.yml', 'DEFAULT_GROUP', '#default\nserver:\n  port: 9000\n# 日志级别\nlogging:\n  level:\n    root: info\nspring:\n  data:\n    redis:\n      database: 3\n      host: localhost\n      port: 6379\n      password: heihei\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost:8848\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n      # 配置的动态变更\n      config:\n        group: DEFAULT_GROUP\n        namespace: dev\n        file-extension: yml\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true\n      globalcors:\n        cors-configurations:\n          \'[/**]\':\n            # 授信地址列表: 如果后台收到跨域请求, 它会拿请求header中的origin值和list中的值做比较.如果没找到匹配的地址,则禁止跨域\n            allowed-origins: \"*\"\n            # 支持跨域请求的方法, 当前配置只允许使用GET 和 POST方法\n            allowed-methods:\n              - GET\n              - POST\n              - OPTION\n            # 跨域请求默认不带Cookie, 如果需要则设置为true\n            allow-credentials: false\n            # Request Header 通配符* 表示允许所有请求头\n            allowed-headers: \"*\"\n            # 浏览器缓存时间\n            max-age: 1000\n############## Sa-Token 配置 (文档: https://sa-token.cc) ##############\nsa-token:\n  # token名称 (同时也是cookie名称)\n  token-name: Authorization\n  # token有效期，单位s 默认30天, -1代表永不过期\n  timeout: -1\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\n  active-timeout: -1\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\n  is-concurrent: true\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\n  is-share: false\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\n  token-style: random-128\n  # 是否输出操作日志\n  is-log: false\n  is-print: false\n  auto-renew: true\nurl:\n  ignore:\n    whites:\n      - /auth/**\n    opens:\n      - /auth/*/accountLogin\n', 'a3eda6ba582a9272711703bb40d86816', '2024-01-02 07:32:45', '2024-01-02 08:02:47', 'nacos', '0:0:0:0:0:0:0:1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (97, 'common.yml', 'DEFAULT_GROUP', 'server:\n  servlet:\n    encoding:\n      force: true\n      charset: utf-8\n      enabled: true\n  tomcat:\n    uri-encoding: UTF-8\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\nspring:\n  servlet:\n    multipart:\n      max-file-size: 10MB\n      max-request-size: 20MB\n  cache:\n    type: redis\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    serialization:\n      write_dates_as_timestamps: false\n    time-zone: GMT+8\n    default-property-inclusion: non_null\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost:8848\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n        #心跳间隔 单位:毫秒\n        heart-beat-interval: 30000\n        #心跳超时 单位:毫秒\n        heart-beat-timeout: 50000\n        # 不发送心跳被nacos下掉的时间 单位:毫秒\n        ip-delete-timeout: 30000', 'b9b128581ef5876878a1b9dbd28b6638', '2024-01-02 07:33:42', '2024-01-02 08:13:30', 'nacos', '0:0:0:0:0:0:0:1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (98, 'common-jdbc.yml', 'DEFAULT_GROUP', 'logging:\r\n  level:\r\n    root: debug\r\nmybatis:\r\n  base-packages: com.moran.mapper\r\n  type-aliases-package: com.moran.model\r\n  mapper-locations: classpath:mapper/*.xml\r\nmapper:\r\n  not-empty: false\r\n  identity: MYSQL\r\n  mappers: com.common.jdbc.utils.MyMapper\r\nspring:\r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/spring-cloud-api?serverTimezone=Asia/Shanghai&zeroDateTimeBehavior=convertToNull\r\n    username: root\r\n    password: xiyang\r\n    hikari:\r\n      max-lifetime: 120000\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0', 'ef1fc2e15391044e681e5dd65a71c1cb', '2024-01-02 07:35:00', '2024-01-02 07:35:00', 'nacos', '192.168.51.6', '', 'dev', NULL, NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (99, 'auth-dev.yml', 'DEFAULT_GROUP', 'server:\r\n  port: 9001\r\nlogging:\r\n  level:\r\n    root: info\r\nspring:\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0\r\nsa-token:\r\n  # token名称 (同时也是cookie名称)\r\n  token-name: Authorization\r\n  # token有效期，单位s 默认30天, -1代表永不过期\r\n  timeout: -1\r\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\r\n  active-timeout: -1\r\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\r\n  is-concurrent: false\r\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\r\n  is-share: true\r\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\r\n  token-style: random-128\r\n  # 是否输出操作日志\r\n  is-log: false\r\n  is-print: false\r\n  auto-renew: true', '182ed7cf696f9fc76d661c6b23c70d92', '2024-01-02 07:35:40', '2024-01-02 07:35:40', 'nacos', '192.168.51.6', '', 'dev', NULL, NULL, NULL, 'yaml', NULL, '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL,
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 116 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (36, 117, 'common.yml', 'DEFAULT_GROUP', '', 'server:\n  servlet:\n    context-path:\n    encoding:\n      force: true\n      charset: utf-8\n      enabled: true\n  tomcat:\n    uri-encoding: UTF-8\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\nspring:\n  servlet:\n    multipart:\n      max-file-size: 10MB\n      max-request-size: 20MB\n  cache:\n    type: redis\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    serialization:\n      write_dates_as_timestamps: false\n    time-zone: GMT+8\n    default-property-inclusion: non_null\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n        #心跳间隔 单位:毫秒\n        heart-beat-interval: 5000\n        #心跳超时 单位:毫秒\n        heart-beat-timeout: 10000\n        # 不发送心跳被nacos下掉的时间 单位:毫秒\n        ip-delete-timeout: 15000', '2cdc7701e08bc4424203d2818a182228', '2024-01-02 15:28:14', '2024-01-02 07:28:14', 'nacos', '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (85, 118, 'common-jdbc.yml', 'DEFAULT_GROUP', '', 'logging:\r\n  level:\r\n    root: info\r\nmybatis:\r\n  base-packages: com.moran.mapper\r\n  type-aliases-package: com.moran.model\r\n  mapper-locations: classpath:mapper/*.xml\r\nmapper:\r\n  not-empty: false\r\n  identity: MYSQL\r\n  mappers: com.common.jdbc.utils.MyMapper\r\nspring:\r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://bj-cdb-8bn5o552.sql.tencentcdb.com:63858/db_retail?serverTimezone=Asia/Shanghai&zeroDateTimeBehavior=convertToNull\r\n    username: db_retail_dev\r\n    password: db_retail_devQWE123!@#\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: bj-crs-7344jgrg.sql.tencentcdb.com\r\n      port: 25201\r\n      password: mangoQWE123!@#\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0', '31bf9bf0a1be61845040d920e0efff0d', '2024-01-02 15:28:18', '2024-01-02 07:28:18', NULL, '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (87, 119, 'payment-center.yml', 'DEFAULT_GROUP', '', 'wx:\r\n  pay:\r\n    appId: wxbb0cebed38f257c1\r\n    mchId: 1285393401\r\n    mchKey: 210204000059663202198304044213ZG\r\n    subAppId: wx0823738b40d2be42\r\n    subMchId: 1357847602\r\n    keyPath: classpath:apiclient_cert.p12\r\n    apiv3-key: 9bb3742fd5fa625558a040a3df9ab833\r\n    private-cert-path: classpath:apiclient_cert.pem\r\n    private-key-path: classpath:apiclient_key.pem', '54722c28c5f52a5b360083463485dcf4', '2024-01-02 15:28:18', '2024-01-02 07:28:18', NULL, '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (88, 120, 'third.yml', 'DEFAULT_GROUP', '', 'file:\r\n  # 文件路径 示例（ Windows配置C:/logs/upload-path，Linux配置 /home/logs/upload-path）  \r\n  upload-path: C:/logs/upload\r\n  # 资源映射路径 前缀\r\n  prefix: profile\r\n  # 网关域名\r\n  domain: http://192.168.51.6:9000', 'f75bdab2af1cd91c368fea6a66f74ced', '2024-01-02 15:28:18', '2024-01-02 07:28:18', NULL, '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (90, 121, 'gateway-local.yml', 'DEFAULT_GROUP', '', '#default\nserver:\n  port: 9000\n  servlet:\n    context-path:\n# 日志级别\nlogging:\n  level:\n    root: info\nspring:\n  data:\n    redis:\n      database: 3\n      host: bj-crs-7344jgrg.sql.tencentcdb.com\n      port: 25201\n      password: mangoQWE123!@#\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n      # 配置的动态变更\n      config:\n        group: DEFAULT_GROUP\n        namespace: dev\n        file-extension: yml\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true\n      globalcors:\n        cors-configurations:\n          \'[/**]\':\n            # 授信地址列表: 如果后台收到跨域请求, 它会拿请求header中的origin值和list中的值做比较.如果没找到匹配的地址,则禁止跨域\n            allowed-origins: \"*\"\n            # 支持跨域请求的方法, 当前配置只允许使用GET 和 POST方法\n            allowed-methods:\n              - GET\n              - POST\n              - OPTION\n            # 跨域请求默认不带Cookie, 如果需要则设置为true\n            allow-credentials: false\n            # Request Header 通配符* 表示允许所有请求头\n            allowed-headers: \"*\"\n            # 浏览器缓存时间\n            max-age: 1000\n############## Sa-Token 配置 (文档: https://sa-token.cc) ##############\nsa-token:\n  # token名称 (同时也是cookie名称)\n  token-name: Authorization\n  # token有效期，单位s 默认30天, -1代表永不过期\n  timeout: -1\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\n  active-timeout: -1\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\n  is-concurrent: true\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\n  is-share: false\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\n  token-style: random-128\n  # 是否输出操作日志\n  is-log: false\n  is-print: false\n  auto-renew: true\nsecure:\n  ignore:\n    urls:\n      - /client-core/**\n      - /mini-core/**\n      - /payment-center/**\n      - /*/dictionary/**\n      - /auth/*/getUserInfo\n      - /auth/*/logout\n    openUrls:\n      - /tools-fuel/**\n      - /tools-third/**\n      - /auth/*/accountLogin\n      - /auth/mini/mobileLogin\n      - /mini-core/**\n      - /corp-admin-core/corp/admin/core/**\n      - /corp-admin-core/integral/**', '9d166c98a8f6acbc4c020c2f1931d905', '2024-01-02 15:28:18', '2024-01-02 07:28:18', NULL, '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (91, 122, 'auth-local.yml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9001\r\nlogging:\r\n  level:\r\n    root: info\r\nspring:\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: bj-crs-7344jgrg.sql.tencentcdb.com\r\n      port: 25201\r\n      password: mangoQWE123!@#\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0\r\nsa-token:\r\n  # token名称 (同时也是cookie名称)\r\n  token-name: Authorization\r\n  # token有效期，单位s 默认30天, -1代表永不过期\r\n  timeout: -1\r\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\r\n  active-timeout: -1\r\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\r\n  is-concurrent: false\r\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\r\n  is-share: true\r\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\r\n  token-style: random-128\r\n  # 是否输出操作日志\r\n  is-log: false\r\n  is-print: false\r\n  auto-renew: true', 'b4891ba31be489fcbf04a3e908b83ecd', '2024-01-02 15:28:18', '2024-01-02 07:28:18', NULL, '192.168.51.6', 'D', 'dev', '');
INSERT INTO `his_config_info` VALUES (0, 123, 'gateway-dev.yml', 'DEFAULT_GROUP', '', '#default\r\nserver:\r\n  port: 9000\r\n# 日志级别\r\nlogging:\r\n  level:\r\n    root: info\r\nspring:\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n  # cloud 相关配置\r\n  cloud:\r\n    nacos:\r\n      username: nacos\r\n      password: xiyang\r\n      # 服务的注册与发现\r\n      discovery:\r\n        server-addr: localhost\r\n        namespace: dev\r\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\r\n        group: DEFAULT_GROUP\r\n      # 配置的动态变更\r\n      config:\r\n        group: DEFAULT_GROUP\r\n        namespace: dev\r\n        file-extension: yml\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true\r\n      globalcors:\r\n        cors-configurations:\r\n          \'[/**]\':\r\n            # 授信地址列表: 如果后台收到跨域请求, 它会拿请求header中的origin值和list中的值做比较.如果没找到匹配的地址,则禁止跨域\r\n            allowed-origins: \"*\"\r\n            # 支持跨域请求的方法, 当前配置只允许使用GET 和 POST方法\r\n            allowed-methods:\r\n              - GET\r\n              - POST\r\n              - OPTION\r\n            # 跨域请求默认不带Cookie, 如果需要则设置为true\r\n            allow-credentials: false\r\n            # Request Header 通配符* 表示允许所有请求头\r\n            allowed-headers: \"*\"\r\n            # 浏览器缓存时间\r\n            max-age: 1000\r\n############## Sa-Token 配置 (文档: https://sa-token.cc) ##############\r\nsa-token:\r\n  # token名称 (同时也是cookie名称)\r\n  token-name: Authorization\r\n  # token有效期，单位s 默认30天, -1代表永不过期\r\n  timeout: -1\r\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\r\n  active-timeout: -1\r\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\r\n  is-concurrent: true\r\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\r\n  is-share: false\r\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\r\n  token-style: random-128\r\n  # 是否输出操作日志\r\n  is-log: false\r\n  is-print: false\r\n  auto-renew: true\r\nsecure:\r\n  ignore:\r\n    whites:\r\n    opens:', 'c2f3ba6e9a03ec3e24ca59b3974cc7d2', '2024-01-02 15:32:45', '2024-01-02 07:32:45', 'nacos', '192.168.51.6', 'I', 'dev', '');
INSERT INTO `his_config_info` VALUES (0, 124, 'common.yml', 'DEFAULT_GROUP', '', 'server:\r\n  servlet:\r\n    encoding:\r\n      force: true\r\n      charset: utf-8\r\n      enabled: true\r\n  tomcat:\r\n    uri-encoding: UTF-8\r\npagehelper:\r\n  helper-dialect: mysql\r\n  reasonable: true\r\n  support-methods-arguments: true\r\n  params: count=countSql\r\nspring:\r\n  servlet:\r\n    multipart:\r\n      max-file-size: 10MB\r\n      max-request-size: 20MB\r\n  cache:\r\n    type: redis\r\n  jackson:\r\n    date-format: yyyy-MM-dd HH:mm:ss\r\n    serialization:\r\n      write_dates_as_timestamps: false\r\n    time-zone: GMT+8\r\n    default-property-inclusion: non_null\r\n  # cloud 相关配置\r\n  cloud:\r\n    nacos:\r\n      username: nacos\r\n      password: xiyang\r\n      # 服务的注册与发现\r\n      discovery:\r\n        server-addr: localhost\r\n        namespace: dev\r\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\r\n        group: DEFAULT_GROUP\r\n        #心跳间隔 单位:毫秒\r\n        heart-beat-interval: 3000\r\n        #心跳超时 单位:毫秒\r\n        heart-beat-timeout: 5000\r\n        # 不发送心跳被nacos下掉的时间 单位:毫秒\r\n        ip-delete-timeout: 3000', 'c14ab8dc9b137e8fea25834e3ec36f9b', '2024-01-02 15:33:41', '2024-01-02 07:33:42', 'nacos', '192.168.51.6', 'I', 'dev', '');
INSERT INTO `his_config_info` VALUES (0, 125, 'common-jdbc.yml', 'DEFAULT_GROUP', '', 'logging:\r\n  level:\r\n    root: debug\r\nmybatis:\r\n  base-packages: com.moran.mapper\r\n  type-aliases-package: com.moran.model\r\n  mapper-locations: classpath:mapper/*.xml\r\nmapper:\r\n  not-empty: false\r\n  identity: MYSQL\r\n  mappers: com.common.jdbc.utils.MyMapper\r\nspring:\r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/spring-cloud-api?serverTimezone=Asia/Shanghai&zeroDateTimeBehavior=convertToNull\r\n    username: root\r\n    password: xiyang\r\n    hikari:\r\n      max-lifetime: 120000\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0', 'ef1fc2e15391044e681e5dd65a71c1cb', '2024-01-02 15:34:59', '2024-01-02 07:35:00', 'nacos', '192.168.51.6', 'I', 'dev', '');
INSERT INTO `his_config_info` VALUES (0, 126, 'auth-dev.yml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9001\r\nlogging:\r\n  level:\r\n    root: info\r\nspring:\r\n  cache:\r\n    type: redis\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n      jedis:\r\n        pool:\r\n          max-idle: 100\r\n          min-idle: 2\r\n      timeout: 10000\r\n      lettuce:\r\n        pool:\r\n          max-active: 200\r\n          max-wait: -1ms\r\n          max-idle: 10\r\n          min-idle: 0\r\nsa-token:\r\n  # token名称 (同时也是cookie名称)\r\n  token-name: Authorization\r\n  # token有效期，单位s 默认30天, -1代表永不过期\r\n  timeout: -1\r\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\r\n  active-timeout: -1\r\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\r\n  is-concurrent: false\r\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\r\n  is-share: true\r\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\r\n  token-style: random-128\r\n  # 是否输出操作日志\r\n  is-log: false\r\n  is-print: false\r\n  auto-renew: true', '182ed7cf696f9fc76d661c6b23c70d92', '2024-01-02 15:35:39', '2024-01-02 07:35:40', 'nacos', '192.168.51.6', 'I', 'dev', '');
INSERT INTO `his_config_info` VALUES (96, 127, 'gateway-dev.yml', 'DEFAULT_GROUP', '', '#default\r\nserver:\r\n  port: 9000\r\n# 日志级别\r\nlogging:\r\n  level:\r\n    root: info\r\nspring:\r\n  data:\r\n    redis:\r\n      database: 3\r\n      host: localhost\r\n      port: 6379\r\n      password: heihei\r\n  # cloud 相关配置\r\n  cloud:\r\n    nacos:\r\n      username: nacos\r\n      password: xiyang\r\n      # 服务的注册与发现\r\n      discovery:\r\n        server-addr: localhost\r\n        namespace: dev\r\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\r\n        group: DEFAULT_GROUP\r\n      # 配置的动态变更\r\n      config:\r\n        group: DEFAULT_GROUP\r\n        namespace: dev\r\n        file-extension: yml\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true\r\n      globalcors:\r\n        cors-configurations:\r\n          \'[/**]\':\r\n            # 授信地址列表: 如果后台收到跨域请求, 它会拿请求header中的origin值和list中的值做比较.如果没找到匹配的地址,则禁止跨域\r\n            allowed-origins: \"*\"\r\n            # 支持跨域请求的方法, 当前配置只允许使用GET 和 POST方法\r\n            allowed-methods:\r\n              - GET\r\n              - POST\r\n              - OPTION\r\n            # 跨域请求默认不带Cookie, 如果需要则设置为true\r\n            allow-credentials: false\r\n            # Request Header 通配符* 表示允许所有请求头\r\n            allowed-headers: \"*\"\r\n            # 浏览器缓存时间\r\n            max-age: 1000\r\n############## Sa-Token 配置 (文档: https://sa-token.cc) ##############\r\nsa-token:\r\n  # token名称 (同时也是cookie名称)\r\n  token-name: Authorization\r\n  # token有效期，单位s 默认30天, -1代表永不过期\r\n  timeout: -1\r\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\r\n  active-timeout: -1\r\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\r\n  is-concurrent: true\r\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\r\n  is-share: false\r\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\r\n  token-style: random-128\r\n  # 是否输出操作日志\r\n  is-log: false\r\n  is-print: false\r\n  auto-renew: true\r\nsecure:\r\n  ignore:\r\n    whites:\r\n    opens:', 'c2f3ba6e9a03ec3e24ca59b3974cc7d2', '2024-01-02 15:50:38', '2024-01-02 07:50:38', 'nacos', '192.168.51.6', 'U', 'dev', '');
INSERT INTO `his_config_info` VALUES (97, 128, 'common.yml', 'DEFAULT_GROUP', '', 'server:\r\n  servlet:\r\n    encoding:\r\n      force: true\r\n      charset: utf-8\r\n      enabled: true\r\n  tomcat:\r\n    uri-encoding: UTF-8\r\npagehelper:\r\n  helper-dialect: mysql\r\n  reasonable: true\r\n  support-methods-arguments: true\r\n  params: count=countSql\r\nspring:\r\n  servlet:\r\n    multipart:\r\n      max-file-size: 10MB\r\n      max-request-size: 20MB\r\n  cache:\r\n    type: redis\r\n  jackson:\r\n    date-format: yyyy-MM-dd HH:mm:ss\r\n    serialization:\r\n      write_dates_as_timestamps: false\r\n    time-zone: GMT+8\r\n    default-property-inclusion: non_null\r\n  # cloud 相关配置\r\n  cloud:\r\n    nacos:\r\n      username: nacos\r\n      password: xiyang\r\n      # 服务的注册与发现\r\n      discovery:\r\n        server-addr: localhost\r\n        namespace: dev\r\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\r\n        group: DEFAULT_GROUP\r\n        #心跳间隔 单位:毫秒\r\n        heart-beat-interval: 3000\r\n        #心跳超时 单位:毫秒\r\n        heart-beat-timeout: 5000\r\n        # 不发送心跳被nacos下掉的时间 单位:毫秒\r\n        ip-delete-timeout: 3000', 'c14ab8dc9b137e8fea25834e3ec36f9b', '2024-01-02 15:51:06', '2024-01-02 07:51:06', 'nacos', '192.168.51.6', 'U', 'dev', '');
INSERT INTO `his_config_info` VALUES (96, 129, 'gateway-dev.yml', 'DEFAULT_GROUP', '', '#default\nserver:\n  port: 9000\n# 日志级别\nlogging:\n  level:\n    root: info\nspring:\n  data:\n    redis:\n      database: 3\n      host: localhost\n      port: 6379\n      password: heihei\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost:8848\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n      # 配置的动态变更\n      config:\n        group: DEFAULT_GROUP\n        namespace: dev\n        file-extension: yml\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true\n      globalcors:\n        cors-configurations:\n          \'[/**]\':\n            # 授信地址列表: 如果后台收到跨域请求, 它会拿请求header中的origin值和list中的值做比较.如果没找到匹配的地址,则禁止跨域\n            allowed-origins: \"*\"\n            # 支持跨域请求的方法, 当前配置只允许使用GET 和 POST方法\n            allowed-methods:\n              - GET\n              - POST\n              - OPTION\n            # 跨域请求默认不带Cookie, 如果需要则设置为true\n            allow-credentials: false\n            # Request Header 通配符* 表示允许所有请求头\n            allowed-headers: \"*\"\n            # 浏览器缓存时间\n            max-age: 1000\n############## Sa-Token 配置 (文档: https://sa-token.cc) ##############\nsa-token:\n  # token名称 (同时也是cookie名称)\n  token-name: Authorization\n  # token有效期，单位s 默认30天, -1代表永不过期\n  timeout: -1\n  # token临时有效期 (指定时间内无操作就视为token过期) 单位 秒\n  active-timeout: -1\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\n  is-concurrent: true\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\n  is-share: false\n  # token风格: uuid, simple-uuid, random-32, random-64, random-128, tik\n  token-style: random-128\n  # 是否输出操作日志\n  is-log: false\n  is-print: false\n  auto-renew: true\nsecure:\n  ignore:\n    whites:\n    opens:', 'e442ddf46c78ad9f41786cdf7f8e00a0', '2024-01-02 16:02:47', '2024-01-02 08:02:47', 'nacos', '0:0:0:0:0:0:0:1', 'U', 'dev', '');
INSERT INTO `his_config_info` VALUES (97, 130, 'common.yml', 'DEFAULT_GROUP', '', 'server:\n  servlet:\n    encoding:\n      force: true\n      charset: utf-8\n      enabled: true\n  tomcat:\n    uri-encoding: UTF-8\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\nspring:\n  servlet:\n    multipart:\n      max-file-size: 10MB\n      max-request-size: 20MB\n  cache:\n    type: redis\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    serialization:\n      write_dates_as_timestamps: false\n    time-zone: GMT+8\n    default-property-inclusion: non_null\n  # cloud 相关配置\n  cloud:\n    nacos:\n      username: nacos\n      password: xiyang\n      # 服务的注册与发现\n      discovery:\n        server-addr: localhost:8848\n        namespace: dev\n        # 如果没有配置Group，则默认值为DEFAULT_GROUP\n        group: DEFAULT_GROUP\n        #心跳间隔 单位:毫秒\n        heart-beat-interval: 3000\n        #心跳超时 单位:毫秒\n        heart-beat-timeout: 5000\n        # 不发送心跳被nacos下掉的时间 单位:毫秒\n        ip-delete-timeout: 3000', 'e3c51ff49d89b35f208eda21599b3e71', '2024-01-02 16:13:29', '2024-01-02 08:13:30', 'nacos', '0:0:0:0:0:0:0:1', 'U', 'dev', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (3, '1', 'dev', '开发', '开发版本', 'nacos', 1704180521196, 1704180521196);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$Ziuo93go3A1C3wA13P7BxeX8HAa5.0S.2IyGsDP5EIr9XoYr3dWRm', 1);

SET FOREIGN_KEY_CHECKS = 1;
