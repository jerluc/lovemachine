local class = require('middleclass')
local Settings = class('lovemachine.Settings')
function Settings:initialize(...)
    self.settings = ... or {}
end

function Settings:get(key, ...)
    local default = ...
    return self.settings[key] or default
end

function Settings:set(key, value)
    self.settings[key] = value
    return self
end
