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

local function buttons()
    love.graphics.setColor(1, 1, 1)
    
    local positions = {
        fight = 32,
        act = 185,
        item = 345,
        mercy = 500
    }
    
    for i, name in ipairs(buttonNames) do
        love.graphics.draw(buttonImages[name .. 'bt'], buttonQuads[name .. 'Quads'][(global.choice == (i-1)) and 2 or 1], positions[name], 432)
    end
end

local function stats()
    if Player.stats.hp > Player.stats.maxhp then
        Player.stats.hp = Player.stats.maxhp
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.mnc)
    love.graphics.print(Player.stats.name .. '   LV ' .. Player.stats.love, 30, 400)
    love.graphics.draw(hpname, 240, 400)

    love.graphics.setColor(0.75, 0, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (Player.stats.maxhp * 1.2), 21)
    love.graphics.setColor(0.98, 1, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (Player.stats.hp * 1.2), 21)

    love.graphics.setColor(1, 1, 1)
    if (Player.stats.hp > -1 and Player.stats.hp < 10) then
        love.graphics.print("0" .. Player.stats.hp .. " / " .. Player.stats.maxhp, 289 + (Player.stats.maxhp * 1.2), 400)
    else
        love.graphics.print(Player.stats.hp .. " / " .. Player.stats.maxhp, 289 + (Player.stats.maxhp * 1.2), 400)
    end
end

local function arena()
    love.graphics.setColor(0, 0, 0, .5)
    love.graphics.rectangle('fill', arenaCur.x - (arenaCur.width / 2), arenaCur.y - (arenaCur.height / 2), arenaCur.width, arenaCur.height)

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

local function doItemText()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.determination)

    local offset = math.sin(love.timer.getTime()*4)
    
    love.graphics.print('* ' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') or 'None') .. ' (' .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') or 'None') .. ')', 52, 274)

    love.graphics.print("* " .. (itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'description') or 'None'), 52, 302)

    if global.subChoice == 0 then love.graphics.setColor(1, 1, 1, .5) else love.graphics.setColor(1, 1, 1, 1) end
    love.graphics.print("<", 448 - offset, 342)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(global.subChoice + 1 .. '/' .. #Player.inventory, 502, 342)

    if global.subChoice == #Player.inventory - 1 then love.graphics.setColor(1, 1, 1, .5) else love.graphics.setColor(1, 1, 1, 1) end
    love.graphics.print(">", 556 + offset, 342)
end

function Ui:load()
    
end

function Ui:draw()
    buttons()
    stats()
    arena()
    -- love.graphics.setColor(1, 1, 1, .5)
    -- love.graphics.draw(ref)
    if global.battleState == 'item' then
        doItemText()
    end
end

function Ui:update(dt)
    updateArena()
end

return Ui