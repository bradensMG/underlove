BattleEngine = {}

function BattleEngine:load()
    Ui = require('source.BattleEngine.ui')
    -- love.graphics.setBackgroundColor(.3, .3, .5)

    playerStats = {name = 'Chara', love = 1, hp = 20, maxhp = 20}
end

function BattleEngine:update(dt)
    
end

function BattleEngine:draw()
    Ui.draw()
end

return BattleEngine