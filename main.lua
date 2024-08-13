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

    -- fonts
    fonts = {
        main = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32),
        ui = love.graphics.newFont("assets/fonts/Mars_Needs_Cunnilingus.ttf", 23),
        dialogue = love.graphics.newFont("assets/fonts/undertale-dotumche.ttf", 12),
        damage = love.graphics.newFont("assets/fonts/attack.ttf", 24)
    }

    -- images
    refs = {
        main = love.graphics.newImage("assets/images/refs/main.png"),
        items = love.graphics.newImage("assets/images/refs/items.png")
    }

    background_img = love.graphics.newImage("assets/images/spr_battlebg_0.png")

    button = {
        fight_unselected = love.graphics.newImage("/assets/images/ui/bt/fight0.png"),
        fight_selected = love.graphics.newImage("/assets/images/ui/bt/fight1.png"),
        act_unselected = love.graphics.newImage("/assets/images/ui/bt/act0.png"),
        act_selected = love.graphics.newImage("/assets/images/ui/bt/act1.png"),
        item_unselected = love.graphics.newImage("/assets/images/ui/bt/item0.png"),
        item_selected = love.graphics.newImage("/assets/images/ui/bt/item1.png"),
        mercy_unselected = love.graphics.newImage("/assets/images/ui/bt/mercy0.png"),
        mercy_selected = love.graphics.newImage("/assets/images/ui/bt/mercy1.png")
    }

    hp_name = love.graphics.newImage("/assets/images/ui/spr_hpname_0.png")
    kr = love.graphics.newImage("/assets/images/ui/spr_krmeter_0.png")

    bone = love.graphics.newImage("assets/enemies/images/attacks/sprite.png")

    -- audio
    ui_font = love.audio.newSource("assets/sound/sfx/Voices/uifont.wav", "static")

    battle_mus = love.audio.newSource("assets/sound/mus/mus_battle2.ogg", "stream")

    menu_move = love.audio.newSource("assets/sound/sfx/menumove.wav", "static")
    menu_confirm = love.audio.newSource("assets/sound/sfx/menuconfirm.wav", "static")

    heal = love.audio.newSource("assets/sound/sfx/snd_heal_c.wav", "static")
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