local LoveMachine = {
    running = false,
    locale = 'en_US',
    currentScene = nil,
    settings = {}
}

function LoveMachine._bindToLOVE()
    love.keypressed = function(...) LoveMachine.keypressed(...) end
    love.keyreleased = function(...) LoveMachine.keyreleased(...) end
    -- TODO: Does this always make sense?
    love.mouse.setVisible(false)
    -- TODO: Fill in other input handlers

    -- TODO: Not quite yet
    --love.errhand = function(...) LoveMachine.errhand(...) end
    love.visible = function(...) LoveMachine.visible(...) end
    love.resize = function(...) LoveMachine.resize(...) end
    love.draw = function(...) LoveMachine.draw(...) end
    love.update = function(...) LoveMachine.update(...) end
    love.quit = function(...) LoveMachine._quit(...) end
end

function LoveMachine.draw()
    LoveMachine.currentScene:draw()
    LoveMachine.debug.draw()
end

function LoveMachine.update(delta)
    if LoveMachine.running then
        LoveMachine.currentScene:update(delta)
    end
end

function LoveMachine.keypressed(key, scanCode, isRepeat)
    LoveMachine.currentScene:keypressed(key, scanCode, isRepeat)
end

function LoveMachine.keyreleased(key, scanCode)
    LoveMachine.currentScene:keyreleased(key, scanCode)
end

function LoveMachine.visible(isVisible)
    LoveMachine.currentScene:visible(isVisible)
end

function LoveMachine.resize(width, height)
    LoveMachine.currentScene:resize(width, height)
end

function LoveMachine.goTo(scene, ...)
    local lastState = nil
    if LoveMachine.currentScene ~= nil then
        lastState = LoveMachine.currentScene:save()
        LoveMachine.currentScene:exit()
    end
    local state = ...
    LoveMachine.currentScene = scene
    LoveMachine.currentScene:load(state)
    return lastState
end

function LoveMachine.pause()
    LoveMachine.running = false
end

function LoveMachine.unpause()
    LoveMachine.running = true
end

function LoveMachine.togglePause()
    LoveMachine.running = not LoveMachine.running
end

function LoveMachine.quit()
    love.event.quit()
end

function LoveMachine._quit()
    return false
end

return LoveMachine
