-- LOG

cjson = require "cjson"
function debuglog(...)
    local log_table = {}
    for i = 1, select("#", ...) do
        log_table[i] = select(i, ...)
    end
    ngx.log(ngx.ERR, "[WIZPROXY-DEBUG] ", cjson.encode(log_table))
end

function ngxlog(...)
    ngx.log(ngx.ERR, "[WIZPROXY] ", ...)
end

-- LOG END

http = require "resty.http"

