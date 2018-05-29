local BasePlugin = require "kong.plugins.base_plugin"

local access = require "kong.plugins.onprem_oauth.access"



local HelloWorldHandler = BasePlugin:extend()



function HelloWorldHandler:new()

  HelloWorldHandler.super.new(self, "onprem_oauth")

end



function HelloWorldHandler:access(conf)

  HelloWorldHandler.super.access(self)

  access.execute(conf)

end



return HelloWorldHandler
