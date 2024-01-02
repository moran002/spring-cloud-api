package com.common.core.redis;

import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @author : 刘云
 * @date : 2022/3/10 17:11
 * 过期时间: 不指定时间时过期时间为-1 永不过期, 传入过期时间则时间单位为秒
 * 基础类型值加入泛型返回值, 用户需明确知道返回类型
 */
@Component
@Slf4j
public final class RedisService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 指定缓存失效时间
     * @param time 时间单位为分钟
     * @author moran
     * @date 2022/3/10 17:13
     **/
    public void expire(String key, long time) {
        try {
            if (time > 0) {
                redisTemplate.expire(key, time, TimeUnit.SECONDS);
            }
        } catch (Exception e) {
            log.error("<!---- 指定缓存失效时间失败:{} ----!>", e.getMessage());
        }
    }

    /**
     * 根据key获取过期时间
     * @author moran
     * @date 2022/3/10 17:21
     * @return 当返回值为-2时代表当前key不存在, -1 代表永不过期, 其他: x分钟后失效
     **/
    public long getExpire(String key) {
        Long expire = redisTemplate.getExpire(key, TimeUnit.SECONDS);
        return ObjectUtils.isEmpty(expire)? -2: expire;
    }

    /**
     * 判断key是否存在
     * @author moran
     * @date 2022/3/10 17:26
     **/
    public boolean hasKey(String key) {
        try {
            Boolean aBoolean = redisTemplate.hasKey(key);
            return aBoolean != null && aBoolean;
        }catch (Exception e) {
            log.error("<!---- 判断key是否存在:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 移除缓存
     * @param key 可传入单个或多个key
     * @author moran
     * @date 2022/3/10 17:44
     **/
    @SuppressWarnings("unchecked")
    public void delete(String... key) {
        if (!ObjectUtils.isEmpty(key)) {
            if (key.length == 1) {
                redisTemplate.delete(key[0]);
            }else {
                redisTemplate.delete((Collection<String>) CollectionUtils.arrayToList(key));
            }
        }
    }

    /**
     * 模糊移除缓存, 通配右侧例: 移除带有token_的全部可以 只需要传入token_即可
     * @author moran
     * @date 2022/3/11 10:42
     **/
    public void  deleteByLikeKey(String key) {
        if (key== null || "".equals(key.trim())) {
            return;
        }
        Set<String> keys = redisTemplate.keys(key + "*");
        if (keys != null) {
            redisTemplate.delete(keys);
        }
    }
    /**
     * 清空缓存
     * @author moran
     * @date 2022/3/11 10:47
     **/
    public void deleteAll() {
        Set<String> keys = redisTemplate.keys("*");
        if (keys != null) {
            redisTemplate.delete(keys);
        }
    }

    /**
     * 获取值
     * @author moran
     * @date 2022/3/10 17:55
     * 返回泛型, 可选择返回Object 也可选择指定类型<>String,int,double等</> 需明确知道具体类型
     **/
    @SuppressWarnings("unchecked")
    public <T> T get(String key) {
        return key == null? null : (T) redisTemplate.opsForValue().get(key);
    }

    /**
     * 获取redis中模糊的key值集合
     * @author :moran
     * @date :2023/8/4 18:17
     **/
    public Set<String> getKeys(String key) {
        return redisTemplate.keys(key.concat("*"));
    }

    /**
     * 设置键值
     * @author moran
     * @date 2022/3/10 17:56
     **/
    public boolean set(String key, Object value) {
        try {
            redisTemplate.opsForValue().set(key, value);
            return true;
        }catch (Exception e) {
            log.error("<!---- 设置键值:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置键值并指定过期时间, 当指定时间小于等于0时调用设置键值方法
     * @author moran
     * @date 2022/3/11 8:53
     *
     **/
    public boolean set(String key, Object value, long time) {
        try {
            if (time > 0) {
                redisTemplate.opsForValue().set(key, value, time, TimeUnit.SECONDS);
            }else {
                return set(key, value);
            }
            return true;
        }catch (Exception e) {
            log.error("<!---- 设置键值并指定过期时间:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 键值递增
     * @author moran
     * @date 2022/3/11 8:57
     **/
    public long decr(String key, long delta) {
        if (delta < 0) {
            throw new RuntimeException("递增指令必须大于0");
        }
        Long count = redisTemplate.opsForValue().increment(key, -delta);
        return count!= null? count:0;
    }

    /**
     * 获取hashGet
     * @author moran
     * @date 2022/3/11 8:59
     **/
    public Map<Object, Object> getHashMap(String key) {
        return redisTemplate.opsForHash().entries(key);
    }

    /**
     * 设置hashSet
     * @author moran
     * @date 2022/3/11 9:00
     **/
    public boolean setHashMap(String key, Map<String, Object> map) {
        try {
            redisTemplate.opsForHash().putAll(key, map);
            return true;
        }catch (Exception e) {
            log.error("<!---- 设置hashSet:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置多个hashGet并指定过期时间, 当过期小于等于0时不设置
     * @author moran
     * @date 2022/3/11 9:02
     **/
    public boolean getHashMap(String key, Map<String, Object> map, long time) {
        try {
            redisTemplate.opsForHash().putAll(key, map);
            if (time > 0) {
                expire(key, time);
            }
            return true;
        }catch (Exception e) {
            log.error("<!---- 设置多个hashGet并指定过期时间:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 向hash中插入数据, 存在则更新, 不存在则创建
     * @author moran
     * @date 2022/3/11 9:05
     **/
    public boolean setHash(String key, String item, Object value) {
        try {
            redisTemplate.opsForHash().put(key, item, value);
            return true;
        }catch (Exception e) {
            log.error("<!---- 向hash中插入数据, 存在则更新, 不存在则创建:{} ----!>", e.getMessage());
            return false;
        }
    }
    
    /**
     * 获取hash中指定的hashkey的值
     * @author moran
     * @date 2022/3/11 14:11
     **/
    @SuppressWarnings("unchecked")
    public <T> T getHash(String key, String item) {
        return (T) redisTemplate.opsForHash().get(key, item);
    }

    /**
     * 删除hash表中的值
     * @author moran
     * @date 2022/3/11 9:08
     **/
    public void deleteHash(String key, Object... item) {
        redisTemplate.opsForHash().delete(key, item);
    }

    /**
     * 判断hash表中是否存在值
     * @author moran
     * @date 2022/3/11 9:10
     **/
    public boolean hasHashKey(String key, String item) {
        return redisTemplate.opsForHash().hasKey(key, item);
    }

    /**
     * hash递增, 如果不存在,创建一个,并返回递增后的值
     * @author moran
     * @date 2022/3/11 9:12
     **/
    public double hashIncrement(String key, String item, double delta) {
        return redisTemplate.opsForHash().increment(key, item, delta);
    }

    /**
     * 获取set中全部成员内容
     * @author moran
     * @date 2022/3/11 9:17
     **/
    public Set<Object> getSet(String key) {
        try {
            return redisTemplate.opsForSet().members(key);
        }catch (Exception e) {
            log.error("<!---- 获取set中内容:{} ----!>", e.getMessage());
            return null;
        }
    }

    /**
     * 判断set中是否有值
     * @author moran
     * @date 2022/3/11 9:19
     **/
    public boolean hasSetKey(String key, Object value) {
        try {
            return Boolean.TRUE.equals(redisTemplate.opsForSet().isMember(key, value));
        }catch (Exception e) {
            log.error("<!---- 判断set中是否有值:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置set
     * @author moran
     * @date 2022/3/11 9:23
     **/
    public long setSet(String key, Object... values) {
        try {
            Long count = redisTemplate.opsForSet().add(key, values);
            return count == null? 0: count;
        }catch (Exception e) {
            log.error("<!---- 设置set:{} ----!>", e.getMessage());
            return 0;
        }
    }

    /**
     * 设置set并指定过期时间
     * @author moran
     * @date 2022/3/11 9:26
     **/
    public long setSet(String key, long time, Object... values) {
        try {
            Long count = redisTemplate.opsForSet().add(key, values);
            if (time > 0 && count != null) {
                expire(key, time);
            }
            return count == null? 0: count;
        }catch (Exception e) {
            log.error("<!---- 设置set并指定过期时间:{} ----!>", e.getMessage());
            return 0;
        }
    }

    /**
     * 获取set长度
     * @author moran
     * @date 2022/3/11 9:29
     **/
    public long getSetSize(String key) {
        try {
            Long size = redisTemplate.opsForSet().size(key);
            return size == null? 0: size;
        }catch (Exception e) {
            log.error("<!---- 获取set长度:{} ----!>", e.getMessage());
            return 0;
        }
    }

    /**
     * 从set中移除元素
     * @author moran
     * @date 2022/3/11 9:31
     **/
    public long deleteSet(String key, Object... values) {
        try {
            Long remove = redisTemplate.opsForSet().remove(key, values);
            return remove == null? 0: remove;
        }catch (Exception e) {
            log.error("<!---- 从set中移除元素:{} ----!>", e.getMessage());
            return 0;
        }
    }

    /**
     * 获取list中数据
     * 需指定开始索引位置和结束索引位置, 0, -1 代表获取全部
     * @author moran
     * @date 2022/3/11 9:36
     **/
    @SuppressWarnings("unchecked")
    public <T> List<T> getList(String key, long start, long end) {
        try {
            List<Object> list = redisTemplate.opsForList().range(key, start, end);
            return list != null && list.size() > 0? (List<T>) list : null;
        }catch (Exception e) {
            log.error("<!---- 获取list中数据:{} ----!>", e.getMessage());
            return null;
        }
    }

    /**
     * 获取list长度
     * @author moran
     * @date 2022/3/11 9:39
     **/
    public long getListSize(String key) {
        try {
            Long size = redisTemplate.opsForList().size(key);
            return size == null? 0: size;
        }catch (Exception e) {
            log.error("<!---- 获取list长度:{} ----!>", e.getMessage());
            return 0;
        }
    }

    /**
     * 通过索引获取list中的值
     * @author moran
     * @date 2022/3/11 9:41
     **/
    public Object getListIndex(String key, long index) {
        try {
            return redisTemplate.opsForList().index(key, index);
        }catch (Exception e) {
            log.error("<!---- 通过索引获取list中的值:{} ----!>", e.getMessage());
            return null;
        }
    }

    /**
     * 设置list, 插入在list的末尾
     * @author moran
     * @date 2022/3/11 9:42
     **/
    public boolean setList(String key, Object value) {
        try {
            Long count = redisTemplate.opsForList().rightPush(key, value);
            return count != null && count != 0;
        }catch (Exception e) {
            log.error("<!---- 设置list, 插入在list的末尾:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置list带过期时间
     * @author moran
     * @date 2022/3/11 9:48
     **/
    public boolean setList(String key, Object value, long time) {
        try {
            Long count = redisTemplate.opsForList().rightPush(key, value);
            if (time > 0) {
                expire(key, time);
            }
            return count!= null && count != 0;
        }catch (Exception e) {
            log.error("<!---- 设置list带过期时间:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置list, 插入全部数据
     * @author moran
     * @date 2022/3/11 9:54
     **/
    public boolean setListAll(String key, List<Object> values) {
        try {
            Long count = redisTemplate.opsForList().rightPushAll(key, values);
            return count != null && count > 0;
        }catch (Exception e) {
            log.error("<!---- 设置list, 插入全部数据:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 设置list带过期时间, 插入整个list
     * @author moran
     * @date 2022/3/11 9:50
     **/
    public boolean setListAll(String key, List<Object> values, long time) {
        try {
            boolean b = setList(key, values);
            if (time > 0 && b) {
                expire(key, time);
            }
            return b;
        }catch (Exception e) {
            log.error("<!---- 置list带过期时间, 插入整个list:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 根据索引修改list中的指定数据
     * @author moran
     * @date 2022/3/11 9:56
     **/
    public boolean updateListByIndex(String key, long index, Object value) {
        try {
            redisTemplate.opsForList().set(key, index, value);
            return true;
        }catch (Exception e) {
            log.error("<!---- 根据索引修改list中的指定数据:{} ----!>", e.getMessage());
            return false;
        }
    }

    /**
     * 删除N个值为value的数据
     * @author moran
     * @date 2022/3/11 9:59
     **/
    public long deleteList(String key, long count, Object value) {
        try {
            Long remove = redisTemplate.opsForList().remove(key, count, value);
            return remove == null? 0 : remove;
        }catch (Exception e) {
            log.error("<!---- 删除N个值为value的数据:{} ----!>", e.getMessage());
            return 0;
        }
    }
}
