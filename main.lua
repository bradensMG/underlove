tick = require "lib/tick"
screen = require "lib/shack"
attacks = require "scripts/battleengine/attacks"

function preload()

    require("lib/writer")

    require("assets/enemies/enemies")
    
    require("/scripts/BattleEngine/ui")
    require("/scripts/BattleEngine/player")

    require("scripts/BattleEngine")

    camera = require 'lib/camera'
    cam = camera()
end

function love.load(arg)
    preload()

    screen:setDimensions(640, 480)

    for _, font in pairs(fonts) do
        font:setFilter("nearest", "nearest")
    end

    love.graphics.setDefaultFilter("nearest", "nearest")

    tick.framerate = 30

    game_state = "encounter"
    battle_init()
end

function love.draw()
    screen:apply()

    if game_state == 'encounter' then
        battleengine_draw()
    end

    if game_state == 'game over' then
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print("you died but i havent coded a game over screen in yet\n\npress z to retry\npress x to exit", 20, 20)
    end

end

function love.update(dt)
    screen:update(dt)

    if game_state == 'encounter' then
        battleengine_run()
    end

    if game_state == 'game over' then
        battle_mus:stop()
        if love.keyboard.isDown('z') then
            battle_init()
            game_state = 'encounter'
        elseif love.keyboard.isDown('x') then
            love.event.quit()
        end
    end

end