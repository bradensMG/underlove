tick = require "lib.tick"
tick.framerate = 30

global = {
    gameState = 'BattleEngine'
}

BattleEngine = require 'source.BattleEngine'

fonts = {
    determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
    mnc = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23)
}

function love.load(arg)
    BattleEngine:load()
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then
        BattleEngine:update(dt)
    end
end

function love.draw()
    if global.gameState == 'BattleEngine' then
        BattleEngine:draw()
    end
end