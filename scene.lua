local class = require('middleclass')

local noFilter = {
    draw = function(_, f) f() end
}

local Scene = class('lovemachine.Scene')
function Scene:initialize(name)
    self.name = name
    self.filter = noFilter
    self.layers = {}
    self:newLayer('default')
end

function Scene:newLayer(name)
    table.insert(self.layers, {
        name = name,
        objects = {}
    })
    return #self.layers
end

function Scene:add(id, ...)
    local layer, obj = 1, nil
    local params = {...}
    if #params == 1 then
        obj = params[1]
    else
        layer = params[1]
        obj = params[2]
    end
    self.layers[layer].objects[id] = obj
    return obj
end

function Scene:getLayer(layer)
    for _, layer in ipairs(self.layers) do
        if layer.name == layer then
            return layer
        end
    end

    error(string.format('No such layer [%s]!', layer))
end

function Scene:removeLayer(layer)
    local layer = self:getLayer(layer)
    layer.objects = nil
    self.layers[layer] = nil
end

function Scene:get(id)
    for _, layer in ipairs(self.layers) do
        local obj = layer.objects[id]
        if obj ~= nil then
            return obj
        end
    end

    error(string.format('No such object [%s]!', id))
end

function Scene:remove(id)
    for _, layer in ipairs(self.layers) do
        local obj = layer.objects[id]
        if obj ~= nil then
            layer[id] = nil
        end
    end

    error(string.format('No such object [%s]!', id))
end

function Scene:draw()
    self.filter:draw(function()
        for _, layer in ipairs(self.layers) do
            for _, obj in pairs(layer.objects) do
                if obj.draw ~= nil then
                    obj:draw()
                end
            end
        end
    end)
end

function Scene:update(dt)
    for _, layer in ipairs(self.layers) do
        for _, obj in pairs(layer.objects) do
            if obj.update ~= nil then
                obj:update(dt)
            end
        end
    end
end

function Scene:__tostring()
    return 'Scene["' .. self.name .. '"]'
end

function Scene:load(state)
end

function Scene:save()
    return nil
end

function Scene:keypressed(key, scanCode, isRepeat)
end

function Scene:keyreleased(key, scanCode)
end

function Scene:resize(width, height)
end

function Scene:visible(isVisible)
end

function Scene:exit()
    for i, v in ipairs(self.layers) do
        for _, obj in pairs(self.layers) do
            if obj.exit ~= nil then
                obj:exit()
            end
        end
        self.layers[i] = nil
    end
end

return {
    new = Scene
}
