function battle_init()
    kr_time_since = 0
    movement = 2

    raw_attack_timer = 0

    arena = {
        x = 35,
        y = 253,
        width = 569,
        height = 134
    }

    if enemies.start_first then
        on_button = 0
        battle_state = "enemy turn"
    else
        on_button = 1
        battle_state = "buttons"
        set_params(enemies.encounter_text, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        render_text = true
    end

    init_player()

    inv_frame_timer = player.inv_frames
end

function battleengine_run()
    if render_text then
        update_text()
    end

    if battle_state == "enemy turn" then
        update_bullets()
        raw_attack_timer = raw_attack_timer + love.timer.getDelta() * tick.framerate
        attack_timer = math.floor(raw_attack_timer)
        enemies_attack()
    else
        raw_attack_timer = 0
    end

    update_kr()
    update_inv_frames()

    love.audio.setVolume(0.1)

    battle_mus:setLooping(true)
    battle_mus:play()
end

function battleengine_draw()
    -- love.graphics.draw(background_img)

    love.graphics.setBackgroundColor(0.05, 0.05, 0.15, 1)
    cam:attach()
    draw_hp_and_healthbar()
    draw_buttons()
    draw_box(arena.x, arena.y, arena.width, arena.height)
    draw_soul()
    draw_enemies()
    draw_ui_text()
    if battle_state == "enemy turn" then draw_bullets() end
    draw_text()
    cam:detach()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.dialogue)
    love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta()), 4, 4)

    love.graphics.setColor(1, 1, 1, 1)
end