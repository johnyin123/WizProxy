# WizProxy

基于openresty的全新设计的代理系统

## 依赖

- openresty or nginx with openresty/lua-nginx-module
- pintsized/lua-resty-http

## 安装

将代码放在位于nginx根目录下的lua/WizProxy/下

在nginx.conf的http段中添加如下配置：

```
    lua_package_path "/usr/local/openresty/nginx/lua/WizProxy/?.lua;;";
    init_by_lua_file lua/WizProxy/init.lua;
    resolver 223.5.5.5;
    resolver_timeout 10s;

```

> lua_package_path "/usr/local/openresty/nginx/lua/WizProxy/?.lua;;";
>
> init_by_lua_file lua/WizProxy/init.lua;
>
> resolver 223.5.5.5;
>
> resolver_timeout 10s;


在nginx.conf的location段中添加如下配置：

```
        location / {
            content_by_lua_file lua/WizProxy/proxy.lua;
        }

```


> location / {
> 
> content_by_lua_file lua/WizProxy/proxy.lua;
>
> }


