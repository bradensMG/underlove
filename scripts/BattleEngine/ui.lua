function draw_hp_and_healthbar()
    love.graphics.setColor(255, 255, 255, 1)

    love.graphics.setFont(fonts.ui)   -- ui text stuffs (name, hp text, love)
    love.graphics.print(player.name .. "   lv " .. player.lv, 30, 400)

    love.graphics.draw(hp_name, 240, 400)

    love.graphics.setColor(192, 0, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (player.max_hp * 1.2), 21)

    love.graphics.setColor(255, 0, 255, 1)
    love.graphics.rectangle('fill', 275, 400, (player.hp * 1.2 + player.amt_of_kr * 1.2), 21)

    love.graphics.setColor(250, 255, 0, 1)
    love.graphics.rectangle('fill', 275, 400, (player.hp * 1.2), 21)

    love.graphics.setColor(255, 255, 255, 1)

    if (player.amt_of_kr > 0 and player.has_kr == true) then
        love.graphics.setColor(255, 0, 255, 1)
    else
        love.graphics.setColor(255, 255, 255, 1)
    end

    if player.has_kr == true then
        love.graphics.draw(kr, 282 + (player.max_hp * 1.2), 405)
    end

    if (player.hp > -1 and (player.hp + player.amt_of_kr) < 10) then
        if player.has_kr == true then
            love.graphics.print("0" .. (player.hp + player.amt_of_kr) .. " / " .. player.max_hp, 322 + (player.max_hp * 1.2), 400)
        else
            love.graphics.print("0" .. player.hp .. " / " .. player.max_hp, 289 + (player.max_hp * 1.2), 400)
        end
    else
        if player.has_kr == true then
            love.graphics.print((player.hp + player.amt_of_kr) .. " / " .. player.max_hp, 322 + (player.max_hp * 1.2), 400)
        else
            love.graphics.print(player.hp .. " / " .. player.max_hp, 289 + (player.max_hp * 1.2), 400)
        end
    end
end

function draw_buttons()
    love.graphics.setColor(1, 1, 1, 1)
    if on_button == 1 then
        love.graphics.draw(button.fight_selected, 32, 432)
    else
        love.graphics.draw(button.fight_unselected, 32, 432)
    end
    if on_button == 2 then
        love.graphics.draw(button.act_selected, 185, 432)
    else
        love.graphics.draw(button.act_unselected, 185, 432)
    end
    if on_button == 3 then
        love.graphics.draw(button.item_selected, 345, 432)
    else
        love.graphics.draw(button.item_unselected, 345, 432)
    end
    if on_button == 4 then
        love.graphics.draw(button.mercy_selected, 500, 432)
    else
        love.graphics.draw(button.mercy_unselected, 500, 432)
    end
end

function draw_box(x, y, width, height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', math.floor(x), math.floor(y), math.floor(width), math.floor(height), 0, 0)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', math.floor(x), math.floor(y), math.floor(width), math.floor(height), 0, 0)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', math.floor(x) - 1, math.floor(y) - 1, math.floor(width) + 2, math.floor(height) + 2, 0, 0)
end

function draw_ui_text()
    if battle_state == "choose enemy" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if enemies.amount > 0 then
            if enemy1_setup.can_spare then love.graphics.setColor(1, 1, 0, 1) else love.graphics.setColor(1, 1, 1, 1) end
            love.graphics.print("  * " .. enemy1_setup.name, 52, 274)
        end
        if enemies.amount > 1 then
            if enemy2_setup.can_spare then love.graphics.setColor(1, 1, 0, 1) else love.graphics.setColor(1, 1, 1, 1) end
            love.graphics.print("  * " .. enemy2_setup.name, 52, 306)
        end
        if enemies.amount > 2 then
            if enemy3_setup.can_spare then love.graphics.setColor(1, 1, 0, 1) else love.graphics.setColor(1, 1, 1, 1) end
            love.graphics.print("  * " .. enemy3_setup.name, 52, 338)
        end

    elseif battle_state == "act" then
        love.graphics.setFont(fonts.main)
        if chosen_enemy == 1 then
            if #enemy1_acts > 0 then love.graphics.print("  * " .. enemy1_acts[1], 52, 274) end
            if #enemy1_acts > 1 then love.graphics.print("  * " .. enemy1_acts[2], 288, 274) end
            if #enemy1_acts > 2 then love.graphics.print("  * " .. enemy1_acts[3], 52, 306) end
            if #enemy1_acts > 3 then love.graphics.print("  * " .. enemy1_acts[4], 288, 306) end
            if #enemy1_acts > 4 then love.graphics.print("  * " .. enemy1_acts[5], 52, 338) end
            if #enemy1_acts > 5 then love.graphics.print("  * " .. enemy1_acts[6], 288, 338) end
        elseif chosen_enemy == 2 then
            if #enemy2_acts > 0 then love.graphics.print("  * " .. enemy2_acts[1], 52, 274) end
            if #enemy2_acts > 1 then love.graphics.print("  * " .. enemy2_acts[2], 288, 274) end
            if #enemy2_acts > 2 then love.graphics.print("  * " .. enemy2_acts[3], 52, 306) end
            if #enemy2_acts > 3 then love.graphics.print("  * " .. enemy2_acts[4], 288, 306) end
            if #enemy2_acts > 4 then love.graphics.print("  * " .. enemy2_acts[5], 52, 338) end
            if #enemy2_acts > 5 then love.graphics.print("  * " .. enemy2_acts[6], 288, 338) end
        elseif chosen_enemy == 3 then
            if #enemy3_acts > 0 then love.graphics.print("  * " .. enemy3_acts[1], 52, 274) end
            if #enemy3_acts > 1 then love.graphics.print("  * " .. enemy3_acts[2], 288, 274) end
            if #enemy3_acts > 2 then love.graphics.print("  * " .. enemy3_acts[3], 52, 306) end
            if #enemy3_acts > 3 then love.graphics.print("  * " .. enemy3_acts[4], 288, 306) end
            if #enemy3_acts > 4 then love.graphics.print("  * " .. enemy3_acts[5], 52, 338) end
            if #enemy3_acts > 5 then love.graphics.print("  * " .. enemy3_acts[6], 288, 338) end
        end

    elseif battle_state == "items" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if items_page == 1 then
            if #inventory > 0 then love.graphics.print("* " .. inventory[1], 100, 274) end
            if #inventory > 1 then love.graphics.print("* " .. inventory[2], 340, 274) end
            if #inventory > 2 then love.graphics.print("* " .. inventory[3], 100, 306) end
            if #inventory > 3 then love.graphics.print("* " .. inventory[4], 340, 306) end
            love.graphics.print("PAGE 1", 388, 338)
        elseif items_page == 2 then
            if #inventory > 4 then love.graphics.print("* " .. inventory[5], 100, 274) end
            if #inventory > 5 then love.graphics.print("* " .. inventory[6], 340, 274) end
            if #inventory > 6 then love.graphics.print("* " .. inventory[7], 100, 306) end
            if #inventory > 7 then love.graphics.print("* " .. inventory[8], 340, 306) end
            love.graphics.print("PAGE 2", 388, 338)
        else
            love.graphics.print("what", 52, 274)
        end

    elseif battle_state == "mercy" then
        render_text = false
        instance.prog_string = ""
        love.graphics.setFont(fonts.main)
        if enemy1_setup.can_spare or enemy2_setup.can_spare or enemy3_setup.can_spare then
            love.graphics.setColor(1, 1, 0, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.print("  * Spare", 52, 274)
        love.graphics.setColor(1, 1, 1, 1)
        if enemies.can_flee then
            love.graphics.print("  * Flee", 52, 306)
        end
    end
end