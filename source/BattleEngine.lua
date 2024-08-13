BattleEngine = {}

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
end

function BattleEngine:update(dt)
    
end

function BattleEngine:draw()
    Ui.buttons()
end

return BattleEngine