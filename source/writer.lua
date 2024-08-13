Writer = {}

local text
local progstring
local startx
local starty
local letterShakeAmount

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
                elseif code == '[shaky]' then
                    animation = 'shaky'
                    letterShakeAmoumt = 1
                elseif code == '[clear]' then
                    animation = 'shaky'
                    letterShakeAmoumt = .05
                end
                i = i + #code - 1
            end
        else
            if animation == 'wave' then
                shakeX = math.sin(love.timer.getTime() * -8 + i) * 1
                shakeY = math.cos(love.timer.getTime() * -8 + i) * 1
            elseif animation == 'shaky' then
                shakeX = love.math.random(-letterShakeAmount, letterShakeAmount)
                shakeY = love.math.random(-letterShakeAmount, letterShakeAmount)
            end
            love.graphics.print(char, x + shakeX, y + shakeY)
            x = x + love.graphics.getFont():getWidth(char)
        end
        
        i = i + 1
    end
end


return Writer