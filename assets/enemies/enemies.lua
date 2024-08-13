-- setup
enemy1_setup = {
    x = 175,
    y = 30,
    image = love.graphics.newImage('assets/enemies/images/test1.png'),
    name = 'Monster 1',
    def = 1,
    atk = 1,
    check_msg = "/f/w* A big heart and a lanky build./s/s/s/s/s/n* Please be gentle with it.",
    can_spare = true,
    status = "alive"
}

enemy2_setup = {
    x = 350,
    y = 196,
    image = love.graphics.newImage('assets/enemies/images/test2.png'),
    name = 'Monster 2',
    def = 5,
    atk = 2,
    check_msg = "/f/w* He's as heavy as a rock./s/s/s/s/s/n* Just as strong as one, too.",
    can_spare = false,
    status = "alive"
}

enemy1_acts = {
    "Threaten"
}

enemy2_acts = {
    "Challenge"
}

enemies = {
    amount = 2,
    encounter_text = "/f/w* /cTest Monster /wand its /ycohort/n  /wdraw near!",
    start_first = true,
    can_flee = true
}

function draw_enemies()
    if enemy1_setup.status == "alive" then
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, .5)
    end

    if enemy1_setup.status ~= "dead" then
        love.graphics.draw(enemy1_setup.image, enemy1_setup.x, enemy1_setup.y)
    end

    if enemy2_setup.status == "alive" then
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, .5)
    end

    if enemy2_setup.status ~= "dead" then
        love.graphics.draw(enemy2_setup.image, enemy2_setup.x, enemy2_setup.y)
    end
end

function enemies_attack()
    --[[
    on_button = 1
    battle_state = "buttons"
    set_params(enemies.encounter_text, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
    render_text = true
    ]]
end

function do_act()
    if chosen_enemy == 1 then
        for i, instance in ipairs(writer) do
            instance.text = ""
        end
        if player.sub_choice == 1 then
            set_params("/w* " .. enemy1_setup.name .. " - ATK " .. enemy1_setup.atk .. " DEF " .. enemy1_setup.def .. "./s/s/s/s/s/n" .. enemy1_setup.check_msg, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        elseif player.sub_choice == 2 then
            set_params("/w* You try to intimidate Monster 1,/s/n  but it's too dense to be/n  intimidated.", 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        end
    elseif chosen_enemy == 2 then
        for i, instance in ipairs(writer) do
            instance.text = ""
        end
        if player.sub_choice == 1 then
            set_params("/w* " .. enemy2_setup.name .. " - ATK " .. enemy2_setup.atk .. " DEF " .. enemy2_setup.def .. "./s/s/s/s/s/n" .. enemy2_setup.check_msg, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        elseif player.sub_choice == 2 then
            enemy2_acts.twoinc = enemy2_acts.twoinc + 1
            enemy2_setup.atk = 5
            if enemy2_acts.twoinc == 1 then
                set_params("/w* You challenge Monster 2./s/s/s/s/n* Monster 2 gets stronger!/s/s/s/s/n* Monster 2's ATK is now 5.", 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
            else
                set_params("/w* you exhausted the increment", 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
            end
        end
    elseif chosen_enemy == 3 then
        for i, instance in ipairs(writer) do
            instance.text = ""
        end
        if player.sub_choice == 1 then
            set_params("/w* " .. enemy3_setup.name .. " - ATK " .. enemy3_setup.atk .. " DEF " .. enemy3_setup.def .. "./s/s/s/s/s/n" .. enemy3_setup.check_msg, 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        elseif player.sub_choice == 2 then
            set_params("/w* if you're reading this i/nfucked up", 52, 274, 2, fonts.main, 1 / 60, false, 'wave', ui_font, "")
        end
    end
    render_text = true
end

-- acts

enemy1_acts = {
    "Check",
    "Threaten"
}

enemy2_acts = {
    "Check",
    twoinc = 0,
    "Challenge"
}