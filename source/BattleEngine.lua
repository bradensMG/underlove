BattleEngine = {}

maxLeft, maxUp, maxDown, maxRight = 0, 0, 0, 0

local bg = {}
playMusic = false

function BattleEngine:load()
    bg[0] = love.graphics.newImage('assets/images/spr_battlebg_0.png')
    bg[1] = love.graphics.newImage('assets/images/spr_battlebg_1.png')

    Enemies = require('assets.enemies.enemies')
    Ui = require('source.BattleEngine.ui')
    Writer = require('source.writer')

    if global.battleState == 'buttons' then gotoMenu() else -- go to menu
        Ui.arenaTo = {x = 320, y = 320, width = 135, height = 135, rotation = 0} -- go to enemyturn
    end

    Player = require('source.BattleEngine.player')

    itemManager = require('source.BattleEngine.itemManager')
end

function BattleEngine:update(dt)
    Ui:update(dt)
    Player:update(dt)
    Writer:update(dt)
    Enemies:update(dt)

    if playMusic then
        Enemies.bgm:setVolume(0.5)
        Enemies.bgm:setLooping(true)
        Enemies.bgm:play()
    end
end

function BattleEngine:draw()
    local color = {40, 110, 70}
    love.graphics.setColor(color[1]/255, color[2]/255, color[3]/255)
    love.graphics.rectangle('fill', 0, 0, 640, 480)
    love.graphics.setColor(1, 1, 1)

    -- love.graphics.draw(bg[0], 0, -1)
    
    Enemies:draw()
    Ui:draw()
    Player:draw()
    Writer:draw()
end

function gotoMenu()
    global.battleState = 'buttons'
    Ui.arenaTo = {
        x = 320,
        y = 320,
        width = 570,
        height = 135,
        rotation = 0
    }
    Writer:setParams(Enemies.encounter.text, 52, 274, fonts.determination, 0.02, 1)
end

function doFlee()
    Writer:setParams("[clear]* Don't waste my time.", 85, 306, fonts.determination, 0.02, 1)
end

function useItem()

    Writer:setParams("[clear]* You equipped the " .. itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') .. '.', 52, 274, fonts.determination, 0.02, 1)

    if itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'consumable' then
        if type(itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat')) == 'number' then
            Player.stats.hp = Player.stats.hp + itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat')
        elseif itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') == 'All' then
            Player.stats.hp = Player.stats.maxhp
        end
        if Player.stats.hp >= Player.stats.maxhp then
            Writer:setParams("[clear]* You ate the " .. itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') .. '.     [break]* Your HP was maxed out!', 52, 274, fonts.determination, 0.02, 1)
        else
            Writer:setParams("[clear]* You ate the " .. itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'name') .. '.     [break]* You recovered ' .. itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'stat') .. ' HP.', 52, 274, fonts.determination, 0.02, 1)
        end
        table.remove(Player.inventory, global.subChoice + 1)
    end

    if itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'weapon' then
        local lastWeapon = Player.stats.weapon
        Player.stats.weapon = Player.inventory[global.subChoice + 1]
        Player.inventory[global.subChoice + 1] = lastWeapon
    end

    if itemManager:getPropertyfromID(Player.inventory[global.subChoice + 1], 'type') == 'armor' then
        local lastArmor = Player.stats.armor
        Player.stats.armor = Player.inventory[global.subChoice + 1]
        Player.inventory[global.subChoice + 1] = lastArmor
    end

end

return BattleEngine