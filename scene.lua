local class = require('middleclass')

local noFilter = {
    draw = function(_, f) f() end
}

local Scene = class('lovemachine.Scene')
function Scene:initialize(name)
    self.name = name
    self.filter = noFilter
    self.layers = {}
    self:newLayer()
end

-- TODO: Just use layer IDs
function Scene:newLayer()
    table.insert(self.layers, {
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

function Scene:removeLayer(id)
    assert(self.layers[id] ~= nil, string.format('No such layer at index [%s]', id))
    self.layers[id] = nil
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

function Scene:preUpdate(dt) end

function Scene:postUpdate(dt) end

function Scene:update(dt)
    self:preUpdate(dt)
    for _, layer in ipairs(self.layers) do
        for _, obj in pairs(layer.objects) do
            if obj.update ~= nil then
                obj:update(dt)
            end
        end
    end
    self:postUpdate(dt)
end

function Scene:__tostring()
    return 'Scene["' .. self.name .. '"]'
end

function Scene:load(state)
    error('Scene:load() not implemented!')
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
    -- TODO: This is pretty fucking stupid
    self:newLayer()
end

return {
    new = Scene
}
