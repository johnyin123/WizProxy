nginx-lua-ds-proxy
==================

一个HTTP代理服务器，基于liseen/lua-resty-http

A http proxy which is based on liseen/lua-resty-http


将代码放在位于nginx根目录下的lua/ds_proxy/下

Put the code into the directory lua/ds_proxy which is located in the root directory of the nginx


在nginx.conf的http段中添加如下配置：

Add the config below to the http seg in nginx.conf:

    lua_package_path "/u/nginx/lua/ds_proxy/?.lua;;";
    lua_need_request_body on;
    init_by_lua_file lua/ds_proxy/init.lua;
    
    resolver 8.8.8.8;
    resolver_timeout 5s;
    
在nginx.conf的location段中添加如下配置：

Add the config below to the location seg in nginx.conf:

        location / {
            content_by_lua_file lua/ds_proxy/proxy.lua;
        }
    
