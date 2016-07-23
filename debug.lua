local Debug = {
    enabled = false,
    backgroundColor = {20, 20, 20, 200},
    color = {255, 255, 255, 255},
    padding = 8,
    text = love.graphics.newText(love.graphics.newFont(24), text)
}

function Debug.enable()
    Debug.enabled = true
end

function Debug.disable()
    Debug.enabled = false
end

function Debug.toggle()
    Debug.enabled = not Debug.enabled
end

function Debug.set(text)
    Debug.text:set(text)
end

function Debug.draw()
    if Debug.enabled then
        local fps = love.timer.getFPS()
        local delta = love.timer.getDelta()
        local avgDelta = love.timer.getAverageDelta()
        Debug.set(string.format('FPS: %d, delta: %.4f, avg. delta: %.4f', fps, delta, avgDelta))
        local textWidth, textHeight = Debug.text:getDimensions()

        local width = textWidth + (Debug.padding * 2)
        local height = textHeight + (Debug.padding * 2)

        local x = love.graphics.getWidth() - width
        local y = love.graphics.getHeight() - height
        love.graphics.setColor(Debug.backgroundColor)
        love.graphics.rectangle('fill', x, y, width, height)

        love.graphics.setColor(Debug.color)
        love.graphics.draw(Debug.text, x + Debug.padding, y + Debug.padding)
    end
end

return Debug
