local class = require('middleclass')
local Animation = class('lovemachine.Animation')
function Animation:intiailize(props)
    self.timeElapsed = 0
    self.anims = {}
    self.currentFrame = 0
end

-- TODO: Hmmmm
function Animation:add(name, anim)
    self.anims[name] = anim
end

function Animation:update(dt)
    error('Not implemented')
end

return {
    new = Animation
}
