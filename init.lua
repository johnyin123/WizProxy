local http = require "resty.http"

function ds_proxy()
    local req_host=ngx.req.get_headers()["Host"]
    local req_uri=ngx.var.request_uri
    local req_url="http://"..req_host..req_uri
    local req_method=ngx.req.get_method()
    local req_body=ngx.req.get_body_data()
    local req_headers=ngx.req.get_headers()
    req_headers["accept-encoding"]="deflate,sdch"

    local hc = http:new()
    local resp_ok, resp_code, resp_headers, resp_status, resp_body  = hc:request {
        url = req_url,
        method = req_method, 
        headers=req_headers,
        body=req_body,
    }

    if not resp_ok then
        ngx.say("Error: "..resp_code)
        ngx.exit(500)
        return
    end

    ngx.status=resp_code

    tmp_set_cookie={}
    for k,v in pairs(resp_headers) do
        if k=="set-cookie" then
            for i in string.gmatch(v, "[^,]+") do
                table.insert(tmp_set_cookie,i)
            end
        else
            ngx.header[k]=v
        end
    end
    ngx.header["Set-Cookie"]=tmp_set_cookie

    --ngx.header["Connection"]=nil
    --ngx.header["Transfer-Encoding"]=nil

    if resp_body then
        ngx.say(resp_body)
    end
end
