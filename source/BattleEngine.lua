BattleEngine = {}

maxLeft, maxUp, maxDown, maxRight = 0, 0, 0, 0

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    Writer = require('source.writer')

    if global.battleState == 'buttons' then gotoMenu() else -- go to menu
        Ui.arenaTo = {x = 320, y = 320, width = 135, height = 135} -- go to enemyturn
    end

    Player = require('source.BattleEngine.player')

    love.graphics.setBackgroundColor(.3, .3, .5)
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
    Ui.arenaTo = {
        x = 320,
        y = 320,
        width = 569,
        height = 135
    }
    Writer:setParams('* Hello, world!', 52, 274, fonts.determination, 0.02, 1)
end

return BattleEngine