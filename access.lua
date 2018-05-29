local _M = {}
-- load the http module
require("socket")
local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require 'ltn12'
--local req_get_headers = ngx.req_header["Authorization"]
--local cjson = require "cjson"
 
function _M.execute(conf)
 
local data = {request={}, response={}}
 
 
local req = data["request"]
local resp = data["response"]
req["host"] = ngx.var.host
req["uri"] = ngx.var.uri
--req["headers"] = ngx.req.raw_header()
 
req["time"] = ngx.req.start_time()
req["method"] = ngx.req.get_method()
--req["get_args"] = ngx.req.get_uri_args()
 
--local h = ngx.req.get_headers()
 
--ngx.log("helooooooo")
--local head=mg.request_info.http_headers['Authorization'] 
--ngx.log("header",head)
--ngx.log(ngx.ERR,req["uri"])
ngx.log(ngx.ERR, "============ Helloooooooooooo World! RAJ============")
local beaheader=ngx.req.get_headers()["Authorization"]
ngx.log(ngx.ERR, "Authorization header",beaheader)
  if conf.oauth_token then
 
    ngx.log(ngx.ERR, "============ Hello World! ============")
ngx.log(ngx.ERR, "Authorization header",ngx.req.read_body()) 
local res = {}
local body, code, headers, status = http.request{
  --url = "https://apigw-test.vmware.com/qa/v1/m0/api/token/application",
  --url="https://apigw-test.vmware.com/ci/v1/m0/api/token/application", 
 url="http://ms-dev11-c8-5.vmware.com:8080/oauth/token/application",
	method = "GET",
-- headers = {Authorization="Basic MWEwM2M0YWQ4ZTlmNDE0Mjg5ODg2OWQwZGY5ZGQwYWM6N2RGMDk4NzllRjU0NDkyZTlkYzc2QkE3RUFlMENkYUY="},
headers = {Authorization=beaheader},
   sink = ltn12.sink.table(res)
   }
res = table.concat(res)
--local data = cjson.decode(body)
ngx.log(ngx.ERR, "After the http call code",code)
ngx.log(ngx.ERR, "After the http call body",body)
local errmsg='{ "error": "Policy 293703: JWT token is not valid or expired"}'
if code == 403 then
ngx.status = 403
ngx.header.content_type = "application/json; charset=utf-8"  
ngx.say(errmsg)
ngx.exit(403)
else
ngx.log(ngx.ERR, "After the http call")
end	
--ngx.log(ngx.ERR,req_get_headers)
    ngx.header["Hello-World"] = "Hello World!!!"
 
  else
 
    ngx.log(ngx.ERR, "============ Bye World! ============")
 
    ngx.header["Hello-World"] = "Bye World!!!"
 
 
 
  end
 
end
 
 
 
return _M
