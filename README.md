# WizProxy

    lua_package_path "/usr/local/openresty/nginx/lua/WizProxy/?.lua;;";
    init_by_lua_file lua/WizProxy/init.lua;
    resolver 223.5.5.5;
    resolver_timeout 10s;

        location / {
            content_by_lua_file lua/WizProxy/proxy.lua;
        }
