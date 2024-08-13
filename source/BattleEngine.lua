BattleEngine = {}

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    Player = require('source.BattleEngine.player')
    Writer = require('source.writer')

    love.graphics.setBackgroundColor(.3, .3, .5)

    Writer:setParams('[clear]* Hello, world!', 52, 274, fonts.determination, 1 / 30, 1)
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

return BattleEngine