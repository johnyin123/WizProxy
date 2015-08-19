local headers = ngx.req.get_headers()
local headers_host = headers["Host"]

local httpc = http.new()

httpc:set_timeout(2000)
debuglog(headers_host)
local ok, err = httpc:connect(headers_host, 443)
if not ok then
    ngxlog("Can't connect to host(" .. headers_host .. "): ", err)
    return
end

local session, err = httpc:ssl_handshake()
if not session then
    ngxlog("Can't ssl handshake: ", err)
    return
end

httpc:set_timeout(5000)
local res, err = httpc:proxy_request()
if not res then
    ngxlog("Can't proxy_request: ", err)
    return
end

httpc:proxy_response(res)
local ok, err = httpc:set_keepalive()
if not ok then
    ngxlog("Can't set keepalive: ", err)
end

