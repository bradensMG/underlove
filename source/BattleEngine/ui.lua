Ui = {}

local buttonNames = { 'fight', 'act', 'item', 'mercy' }
local buttonImages = {}
local buttonQuads = {}

for _, name in ipairs(buttonNames) do
    buttonImages[name .. 'bt'] = love.graphics.newImage('assets/images/ui/bt/' .. name .. '.png')
    buttonQuads[name .. 'Quads'] = {
        love.graphics.newQuad(0, 0, 110, 42, buttonImages[name .. 'bt']),
        love.graphics.newQuad(110, 0, 110, 42, buttonImages[name .. 'bt'])
    }
end

local ref = love.graphics.newImage('assets/images/refs/main.png')

local hpname = love.graphics.newImage("assets/images/ui/spr_hpname_0.png")

local arenaCur = {
    x = 320,
    y = 320,
    width = 570,
    height = 135
}

local function setHeartParams()
    maxLeft = math.floor(arenaCur.x - (arenaCur.width / 2) + 3)
    maxUp = math.floor(arenaCur.y - (arenaCur.height / 2) + 3)
    maxDown = math.floor(arenaCur.y + (arenaCur.height / 2) - 18)
    maxRight = math.floor(arenaCur.x + (arenaCur.width / 2) - 18)
end

local function drawText(text, x, y, color, outlineColor)
    for i = -outlineWidth, outlineWidth do
        love.graphics.setColor(outlineColor)
        for j = -outlineWidth, outlineWidth do
            if i ~= 0 then
                love.graphics.print(text, x + i, y + j)
            end
        end
    end
    love.graphics.setColor(color)
    love.graphics.print(text, x, y)
end

local function drawGraphic(image, x, y, color, outlineColor)
    for i = -outlineWidth, outlineWidth do
        love.graphics.setColor(outlineColor)
        for j = -outlineWidth, outlineWidth do
            if i ~= 0 then
                love.graphics.draw(image, x + i, y + j)
            end
        end
    end
    love.graphics.setColor(color)
    love.graphics.draw(image, x, y)
end

local function drawQuad(image, quad, x, y, color, outlineColor)
    for i = -outlineWidth, outlineWidth do
        love.graphics.setColor(outlineColor)
        for j = -outlineWidth, outlineWidth do
            if i ~= 0 then
                love.graphics.draw(image, quad, x + i, y + j)
            end
        end
    end
    love.graphics.setColor(color)
    love.graphics.draw(image, quad, x, y)
end

local function buttons()
    local positions = {
        fight = 32,
        act = 185,
        item = 345,
        mercy = 500
    }
    
    for i, name in ipairs(buttonNames) do
        drawQuad(buttonImages[name .. 'bt'], buttonQuads[name .. 'Quads'][(global.choice == (i-1)) and 2 or 1], positions[name], 432, {1, 1, 1}, {0, 0, 0})
    end
end

local function stats()
    if Player.stats.hp > Player.stats.maxhp then
        Player.stats.hp = Player.stats.maxhp
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.mnc)
    drawText(Player.stats.name .. '   LV ' .. Player.stats.love, 30, 400, {1, 1, 1}, {0, 0, 0})

    drawGraphic(hpname, 240, 400, {1, 1, 1}, {0, 0, 0})

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 275 - outlineWidth, 400 - outlineWidth, (Player.stats.maxhp * 1.2) + outlineWidth*2, 21 + outlineWidth*2)
    love.graphics.setColor(0.75, 0, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (Player.stats.maxhp * 1.2), 21)
    love.graphics.setColor(0.98, 1, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (Player.stats.hp * 1.2), 21)

    love.graphics.setColor(1, 1, 1)
    if (Player.stats.hp > -1 and Player.stats.hp < 10) then
        drawText("0" .. Player.stats.hp .. " / " .. Player.stats.maxhp, 289 + (Player.stats.maxhp * 1.2), 400, {1, 1, 1}, {0, 0, 0})
    else
        drawText(Player.stats.hp .. " / " .. Player.stats.maxhp, 289 + (Player.stats.maxhp * 1.2), 400, {1, 1, 1}, {0, 0, 0})
    end
end

local function arena()
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle('fill', arenaCur.x - (arenaCur.width / 2), arenaCur.y - (arenaCur.height / 2), arenaCur.width, arenaCur.height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.setLineStyle('rough')
    love.graphics.setLineWidth(5 + outlineWidth*2)
    love.graphics.rectangle('line', arenaCur.x - (arenaCur.width / 2), arenaCur.y - (arenaCur.height / 2), arenaCur.width, arenaCur.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineStyle('rough')
    love.graphics.setLineWidth(5)
    love.graphics.rectangle('line', arenaCur.x - (arenaCur.width / 2), arenaCur.y - (arenaCur.height / 2), arenaCur.width, arenaCur.height)
end

local function updateArena()
    arenaCur.x = arenaCur.x + ((Ui.arenaTo.x - arenaCur.x) / 6) * love.timer.getDelta() * 30
    arenaCur.y = arenaCur.y + ((Ui.arenaTo.y - arenaCur.y) / 6) * love.timer.getDelta() * 30
    arenaCur.width = arenaCur.width + ((Ui.arenaTo.width - arenaCur.width) / 6) * love.timer.getDelta() * 30
    arenaCur.height = arenaCur.height + ((Ui.arenaTo.height - arenaCur.height) / 6) * love.timer.getDelta() * 30
    setHeartParams()
end

local function doChooseText()
    love.graphics.setFont(fonts.determination)
    if enemies.stats.amount > 0 then
        drawText('* ' .. enemies.one.name, 85, 274, {1, 1, 1}, {0, 0, 0})
    end
    if enemies.stats.amount > 1 then
        drawText('* ' .. enemies.two.name, 85, 306, {1, 1, 1}, {0, 0, 0})
    end
    if enemies.stats.amount > 2 then
        drawText('* ' .. enemies.three.name, 85, 341, {1, 1, 1}, {0, 0, 0})
    end
end

local function doMercyText()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.determination)
    drawText('* Spare', 85, 274, {1, 1, 1}, {0, 0, 0})
    if enemies.stats.canFlee then
        drawText('* Flee', 85, 306, {1, 1, 1}, {0, 0, 0})
    end
end

local function doItemText()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.determination)

    local offset = math.sin(love.timer.getTime()*4)
    
    if itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'consumable' then
        drawText('* ' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') or 'None') .. ' (' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') or 'None') .. ' HP)', 52, 274, {1, 1, 1}, {0, 0, 0})
    elseif itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'weapon' then
        drawText('* ' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') or 'None') .. ' (' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') or 'None') .. ' ATT)', 52, 274, {1, 1, 1}, {0, 0, 0})
    elseif itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'armor' then
        drawText('* ' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') or 'None') .. ' (' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') or 'None') .. ' DEF)', 52, 274, {1, 1, 1}, {0, 0, 0})
    end

    drawText("* " .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'description') or 'None'), 52, 302, {1, 1, 1}, {0, 0, 0})

    if global.subChoice == 0 then
        drawText('<', 448, 342, {1, 1, 1, .5}, {0, 0, 0, .5})
    else
        drawText('<', 448 - offset, 342, {1, 1, 1}, {0, 0, 0})
    end

    drawText(global.subChoice + 1 .. '/' .. #Player.inventory, 502, 342, {1, 1, 1}, {0, 0, 0})

    if global.subChoice == #Player.inventory - 1 then
        drawText('>', 556, 342, {1, 1, 1, .5}, {0, 0, 0, .5})
    else
        drawText('>', 556 + offset, 342, {1, 1, 1}, {0, 0, 0})
    end
end

function Ui:load()
    
end

function Ui:draw()
    buttons()
    stats()
    arena()
    -- love.graphics.setColor(1, 1, 1, .5)
    -- love.graphics.draw(ref)
    if global.battleState == 'chooseEnemy' then
        doChooseText()
    end
    if global.battleState == 'item' then
        doItemText()
    end
    if global.battleState == 'mercy' then
        doMercyText()
    end
end

function Ui:update(dt)
    updateArena()
end

return Ui