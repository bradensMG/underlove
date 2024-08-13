tick = require "lib.tick"
tick.framerate = 30

global = {
    gameState = 'BattleEngine',
    choice = 0,
    subChoice = 0
}

BattleEngine = require 'source.BattleEngine'

fonts = {
    determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
    mnc = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23)
}

input = {
    up = false,
    down = false,
    left = false,
    right = false,
    primary = false,
    secondary = false,
}

function love.keypressed(key)
    if key == 'up' then
        input.up = true
    elseif key == 'down' then
        input.down = true
    elseif key == 'left' then
        input.left = true
    elseif key == 'right' then
        input.right = true
    elseif key == 'z' or key == 'enter' then
        input.left = true
    elseif key == 'x' or key == 'rshift' or key == 'lshift' then
        input.right = true
    end
end

function love.load(arg)
    BattleEngine:load()
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then
        BattleEngine:update(dt)
        input = {
            up = false,
            down = false,
            left = false,
            right = false,
            primary = false,
            secondary = false,
        }
    end
end

function love.draw()
    if global.gameState == 'BattleEngine' then
        love.graphics.setShader(shader)
        BattleEngine:draw()
        love.graphics.setShader()
    end
end