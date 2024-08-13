writer = {}

function set_params(my_str, my_x, my_y, my_rad, my_font, my_timing, my_mode, my_effect, my_sound)
    instance = {
    text = my_str,
    prog_string = "",
    srt_x = my_x,
    srt_y = my_y,
    letter_shake_amount = my_rad,
    font = my_font,
    interv_speed = my_timing,
    is_instant = my_mode,
    text_animation = my_effect,
    text_sound = my_sound,

    txt_can_prog = false,

    time_since = 0,
    progress = 0
    }
    table.insert(writer, instance)
end

function draw_text()
    for i, instance in ipairs(writer) do
        love.graphics.setFont(instance.font)
        
        local x = instance.srt_x
        local y = instance.srt_y

        for i = 1, #instance.text do
            local char = instance.prog_string:sub(i, i)
            local char_next = instance.text:sub((i + 1), (i + 1))
            local char_prev = instance.prog_string:sub((i - 1), (i - 1))

            if txt_color == 'w' then
                love.graphics.setColor(1, 1, 1, 1)
            elseif txt_color == 'r' then
                love.graphics.setColor(1, 0, 0, 1)
            elseif txt_color == 'g' then
                love.graphics.setColor(0, 1, 0, 1)
            elseif txt_color == 'b' then
                love.graphics.setColor(0, 0, 1, 1)
            elseif txt_color == 'y' then
                love.graphics.setColor(1, 1, 0, 1)
            elseif txt_color == 'p' then
                local colorOffset = i * 0.1
                local r = 0.5 + math.sin(love.timer.getTime() * instance.letter_shake_amount * 2 + i) * 0.5 + 0.2
                local g = 0.5 + math.sin(love.timer.getTime() * instance.letter_shake_amount * 2 + i + math.pi / 2) * 0.5 + 0.2
                local b = 0.5 + math.sin(love.timer.getTime() * instance.letter_shake_amount * 2 + i + math.pi) * 0.5 + 0.2
                love.graphics.setColor(r, g, b, 1)
            elseif txt_color == 'c' then
                love.graphics.setColor(0, 1, 1, 1)
            elseif txt_color == 'k' then
                love.graphics.setColor(0, 0, 0, 1)
            end
            
            if char == '/' then
                love.graphics.setColor(0, 0, 0, 0)
                if char_next == 'n' then
                    y = y + instance.font:getHeight(char) + 4
                else
                    x = x - (instance.font:getWidth(char))
                end
            elseif char_prev == '/' then
                love.graphics.setColor(0, 0, 0, 0)
                if char == 'n' then
                    x = instance.srt_x - (instance.font:getWidth(char))
                elseif char == 'p' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 's' then
                    x = x - (instance.font:getWidth(char))
                elseif char == 'w' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'r' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'g' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'b' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'y' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'a' then
                    x = x - (instance.font:getWidth(char))
                    text_animates = true
                elseif char == 'f' then
                    x = x - (instance.font:getWidth(char))
                    text_animates = false
                elseif char == 'c' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                elseif char == 'k' then
                    x = x - (instance.font:getWidth(char))
                    txt_color = char
                end
            end

            if text_animates == true then
                if instance.text_animation == 'shake' then
                    shakeX = love.math.random(-instance.letter_shake_amount, instance.letter_shake_amount)
                    shakeY = love.math.random(-instance.letter_shake_amount, instance.letter_shake_amount)
                elseif instance.text_animation == 'wave' then
                    shakeX = math.cos((love.timer.getTime() * 8) + (i *.5)) * instance.letter_shake_amount
                    shakeY = math.sin((love.timer.getTime() * 8) + (i *.5)) * instance.letter_shake_amount
                end
            else
                shakeX = 0
                shakeY = 0
            end

            love.graphics.print(char, x + math.floor(shakeX), math.floor(y + shakeY))

            x = x + instance.font:getWidth(char)
        end
    end
end

function update_text()
    for i, instance in ipairs(writer) do
        instance.time_since = instance.time_since + tick.dt

        if (love.keyboard.isDown('x') or love.keyboard.isDown('rshift')) or instance.is_instant then
            instance.txt_can_prog = true
            instance.progress = #instance.text + 1
            instance.prog_string = instance.text
        end

        while (instance.time_since >= instance.interv_speed and instance.progress <= #instance.text) do
            instance.txt_can_prog = false
            local current_char = instance.text:sub(instance.progress, instance.progress)
            local next_char = instance.text:sub(instance.progress + 1, instance.progress + 1)

            if current_char == '/' and next_char ~= 's' then
                instance.progress = instance.progress + 2
            else
                if current_char ~= '/' then
                    instance.text_sound:stop()
                    if not (instance.text:sub(instance.progress - 1, instance.progress - 1) == '/') then
                        instance.text_sound:play(instance.text_sound)
                    end
                end
                instance.time_since = 0
                instance.prog_string = instance.text:sub(1, instance.progress)
                instance.progress = instance.progress + 1
            end
        end

        if instance.progress > #instance.text then
            instance.txt_can_prog = true
        end
    end
end

return {
    set_params = set_params,
    draw = draw,
    upd = upd
}