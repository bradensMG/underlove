bullets = {}

mask_shader = love.graphics.newShader[[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]

function check_collision(x1,y1,w1,h1, x2,y2,w2,h2)
   return x1 < x2+w2 and
          x2 < x1+w1 and
          y1 < y2+h2 and
          y2 < y1+h1
end

function create_bullet(x, y, xspeed, yspeed)
   local bullet = {
      x = x,
      y = y,
      xspeed = xspeed,
      yspeed = yspeed
   }
   table.insert(bullets, bullet)
end

function update_bullets()
   for i, bullet in ipairs(bullets) do
      bullet.x = bullet.x + bullet.xspeed
      bullet.y = bullet.y + bullet.yspeed

      if check_collision(player.x + player.hitbox_leniency, player.y + player.hitbox_leniency, player.img:getWidth() - (player.hitbox_leniency * 2), player.img:getHeight() - (player.hitbox_leniency * 2), bullet.x, bullet.y, 10, 100) then
         if inv_frame_timer == player.inv_frames then
            screen:setShake(4)
            if not player.has_kr then
               table.remove(bullets, i)
            end
            inv_frame_timer = 0
            hurt_player()
         end
      end
   end
end

function my_stencil_function()
   for i, bullet in ipairs(bullets) do
      love.graphics.setShader(mask_shader)
      -- blue -- love.graphics.setColor(0, .75, 1, 1)
      -- orange -- love.graphics.setColor(1, .5, .2, 1)
      love.graphics.draw(bone, bullet.x, bullet.y)
      
      love.graphics.setShader()
   end

end

function draw_bullets()
   for i, bullet in ipairs(bullets) do
      love.graphics.stencil(my_stencil_function, "replace", 1)
      love.graphics.setStencilTest("greater", 0)
      love.graphics.rectangle("fill", arena.x + 2, arena.y + 2, arena.width - 4, arena.height - 4)
      love.graphics.setStencilTest()
   end
end

return {
   create_bullet = create_bullet,
   update_bullets = update_bullets,
   draw_bullets = draw_bullets
}