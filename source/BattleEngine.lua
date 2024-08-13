BattleEngine = {}

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    Player = require('source.BattleEngine.player')

    love.graphics.setBackgroundColor(.3, .3, .5)
end

function BattleEngine:update(dt)
    Ui:update(dt)
    Player:update(dt)
end

function BattleEngine:draw()
    Ui:draw()
    Player:draw()
end

return BattleEngine