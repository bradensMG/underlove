BattleEngine = {}

maxLeft, maxUp, maxDown, maxRight = 0, 0, 0, 0

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    Writer = require('source.writer')

    if global.battleState == 'buttons' then gotoMenu() else -- go to menu
        Ui.arenaTo = {x = 320, y = 320, width = 135, height = 135} -- go to enemyturn
    end

    Player = require('source.BattleEngine.player')

    itemManager = require('source.BattleEngine.itemManager')

    love.graphics.setBackgroundColor(0.1, 0, 0.05)
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

end

return BattleEngine