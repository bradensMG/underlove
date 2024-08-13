TestTextRoom = {}
writer = require('source.writer')

function TestTextRoom:load()
    writer:setParams('[clear]* Hello, world![break]I [wave]love[clear] you all!', 20, 300, fonts.determination)
end

function TestTextRoom:update(dt)

end

function TestTextRoom:draw()
    writer.draw()
end

return TestTextRoom