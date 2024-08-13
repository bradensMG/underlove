Writer = {}

local text
local progstring
local startx
local starty

function Writer:setParams(string, x, y, font)
    text = string
    progstring = ""
    startx = x
    starty = y

    love.graphics.setFont(font)
end

function Writer:update(dt)

end

function Writer:draw()
    local x = startx
    local y = starty
    local i = 1
    local animi = 1
    
    while i <= #text do
        local char = text:sub(i, i)
        if char == '[' then
            local code = text:match("%[%w+%]", i)
            if code then
                if code == '[break]' then
                    x = startx
                    y = y + love.graphics.getFont():getHeight()
                elseif code == '[wave]' then
                    animation = 'wave'
                elseif code == '[clear]' then
                    animation = 'idle'
                elseif code == '[shake]' then
                    animation = 'shake'
                end
                i = i + #code - 1
            end
        else
            if animation == 'wave' then
                shakeX = math.sin(love.timer.getTime() * -8 + animi) * 1
                shakeY = math.cos(love.timer.getTime() * -8 + animi) * 1
            elseif animation == 'shake' then
                letterShakeAmount = 1
                shakeX = love.math.random(-letterShakeAmount, letterShakeAmount)
                shakeY = love.math.random(-letterShakeAmount, letterShakeAmount)
            elseif animation == 'idle' then
                letterShakeAmount = 0
                shakeX = love.math.random(-letterShakeAmount, letterShakeAmount)
                shakeY = love.math.random(-letterShakeAmount, letterShakeAmount)
            end

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