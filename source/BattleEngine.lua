BattleEngine = {}

maxLeft, maxUp, maxDown, maxRight = 0, 0, 0, 0

playMusic = true

local particles = {dust = {}}
particles.dust[1] = love.graphics.newImage('assets/images/particles/spr_dustcloud_0.png')
particles.dust[2] = love.graphics.newImage('assets/images/particles/spr_dustcloud_1.png')
particles.dust[3] = love.graphics.newImage('assets/images/particles/spr_dustcloud_2.png')

function BattleEngine:load()
    Enemies:load()

    if enemies.encounter.startFirst then
        global.battleState = 'enemyTurn'
        global.choice = -1
    else
        global.battleState = 'buttons'
    end

    Ui = require('source.BattleEngine.ui')
    Writer = require('source.writer')

    if global.battleState == 'buttons' then gotoMenu() else -- go to menu
        startEnemyTurn()
    end

    Player = require('source.BattleEngine.player')
    Player:load()

    itemManager = require('source.BattleEngine.itemManager')
end

function BattleEngine:update(dt)
    Ui:update(dt)
    Player:update(dt)
    Writer:update(dt)
    Enemies:update(dt)

    if playMusic then
        Enemies.bgm:setVolume(0.4)
        Enemies.bgm:setLooping(true)
        Enemies.bgm:play()
    end
end

function BattleEngine:draw()
    Enemies:background()
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

function doFight()
    targetChoiceFrame = 0
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

function startEnemyTurn()
    global.battleState = 'enemyTurn'
    Ui.arenaTo = {x = 320, y = 320, width = 135, height = 135, rotation = 0}
    placeSoul()
end

return BattleEngine