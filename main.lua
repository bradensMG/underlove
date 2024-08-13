tick = require "lib.tick"
tick.framerate = 30

global = {
    gameState = 'BattleEngine'
}

BattleEngine = require 'source.BattleEngine'

function love.load(arg)
    BattleEngine.load()
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then
        BattleEngine.update(dt)
    end
end

function love.draw()
    if global.gameState == 'BattleEngine' then
        BattleEngine.draw()
    end
end