BattleEngine = {}

maxLeft, maxUp, maxDown, maxRight = 0, 0, 0, 0

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    Writer = require('source.writer')

    if global.battleState == 'buttons' then gotoMenu() else -- go to menu
        Ui.arenaTo = {x = 320, y = 320, width = 135, height = 135} -- go to enemyturn
    end

    Player = require('source.BattleEngine.player')

    love.graphics.setBackgroundColor(.1, 0, .2)
end

function BattleEngine:update(dt)
    Ui:update(dt)
    Player:update(dt)
    Writer:update(dt)
end

function BattleEngine:draw()
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
        height = 135
    }
    Writer:setParams('* Hello, world!', 52, 274, fonts.determination, 0.02, 1)
end

function useItem()
    if Player.inventory[global.subChoice + 1].type == 'consumable' then
        if Player.inventory[global.subChoice + 1].change ~= 'All' then
            Player.stats.hp = Player.stats.hp + Player.inventory[global.subChoice + 1].change
        else
            Player.stats.hp = Player.stats.maxhp
        end
        if Player.stats.hp >= Player.stats.maxhp then
            Writer:setParams('* You ate the ' .. Player.inventory[global.subChoice + 1].name .. '.     [break]* Your HP was maxed out!', 52, 274, fonts.determination, 0.02, 1)
        else
            Writer:setParams('* You ate the ' .. Player.inventory[global.subChoice + 1].name .. '.     [break]* You recovered ' .. Player.inventory[global.subChoice + 1].change .. ' HP.', 52, 274, fonts.determination, 0.02, 1)
        end
        table.remove(Player.inventory, global.subChoice + 1)
    end
    if Player.inventory[global.subChoice + 1].type == 'weapon' then
        Player.stats.weapon = Player.inventory[global.subChoice + 1].name
        Player.vars.atk = Player.inventory[global.subChoice + 1].change

        Writer:setParams('* You eqipped the ' .. Player.inventory[global.subChoice + 1].name .. '.     [break]* Your ATT is now ' .. Player.inventory[global.subChoice + 1].change .. '.', 52, 274, fonts.determination, 0.02, 1)
    end
    if Player.inventory[global.subChoice + 1].type == 'armor' then
        Player.stats.armor = Player.inventory[global.subChoice + 1].name
        Player.vars.def = Player.inventory[global.subChoice + 1].change

        Writer:setParams('* You eqipped the ' .. Player.inventory[global.subChoice + 1].name .. '.     [break]* Your DEF is now ' .. Player.inventory[global.subChoice + 1].change .. '.', 52, 274, fonts.determination, 0.02, 1)
    end
end

return BattleEngine