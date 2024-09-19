enemies = {}

one = {
    name = 'Poseur',
    x = 200,
    y = 138,
    image = love.graphics.newImage('assets/enemies/images/poseur.png')
}

two = {
    name = 'Posette',
    x = 440,
    y = 90,
    image = love.graphics.newImage('assets/enemies/images/posette.png')
}

stats = {amount = 2}

function enemies:update(dt)

end

function enemies:draw()
    if stats.amount > 0 then
        love.graphics.draw(one.image, one.x - one.image:getWidth()/2, one.y - one.image:getHeight()/2)
    end
    if stats.amount > 1 then
        love.graphics.draw(two.image, two.x - two.image:getWidth()/2, two.y - two.image:getWidth()/2)
    end
    if stats.amount > 2 then
        love.graphics.draw(three.image, three.x, three.y)
    end
end

return enemies