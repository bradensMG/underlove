Writer = {}

local text
local progString
local startX
local startY
local timeSince
local timeInterval
local color = 'white'
local animation = 'idle'
local updateI

local colors = {
    white = {1, 1, 1},
    red = {1, 0, 0},
    green = {0, 1, 0},
    blue = {0, 0, 1},
    cyan = {0, 1, 1},
    yellow = {1, 1, 0}
}

function Writer:setParams(string, x, y, font, time)
    text = string
    progString = ""
    startX = x
    startY = y
    timeSince = 0
    timeInterval = time
    textFont = font
    i = 1
end

function Writer:update(dt)
    timeSince = timeSince + tick.dt
    local char = text:sub(i, i)
    if timeSince > timeInterval then
        if i <= #text then
            progString = text:sub(1, i)
            i = i + 1
            timeSince = 0
        end
    end
    if char == '[' then
        local codeEnd = text:find("]", i)
        local code = text:sub(i + 1, codeEnd - 1)
        i = codeEnd + 1
    end
end


function Writer:draw()
    love.graphics.setFont(textFont)
    
    local x = startX
    local y = startY
    local i = 1
    local animi = 1
    local shakeX = 0
    local shakeY = 0
    local letterShakeAmount = 0

    while i <= #text do
        local char = progString:sub(i, i)
        if char == '[' then
            local code = progString:match("%[%w+%]", i)
            if code then
                code = code:sub(2, -2)
                if code == 'break' then
                    x = startX
                    y = y + love.graphics.getFont():getHeight()
                elseif code == 'wave' then
                    animation = 'wave'
                elseif code == 'clear' then
                    animation = 'idle'
                    color = 'white'
                elseif code == 'shake' then
                    animation = 'shake'
                else
                    if colors[code] then
                        color = code
                    end
                end
                i = i + #code + 1
            end
        else
            if animation == 'wave' then
                shakeX = math.sin(love.timer.getTime() * -8 + animi) * 1
                shakeY = math.cos(love.timer.getTime() * -8 + animi) * 1
            elseif animation == 'shake' then
                letterShakeAmount = 1
                shakeX = love.math.random(-letterShakeAmount, letterShakeAmount)
                shakeY = love.math.random(-letterShakeAmount, letterShakeAmount)
            end
            local currentColor = colors[color] or colors['white']
            love.graphics.setColor(currentColor)

            love.graphics.print(char, x + shakeX, y + shakeY)
            x = x + love.graphics.getFont():getWidth(char)
        end
        i = i + 1
        if char ~= ' ' then
            animi = animi + 1
        end
    end
end

return Writer
