---------------------------------------
--- Keyboard input
love.keyboard.keysPressed = {}

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end
---------------------------------------
--- Mouse input
love.mouse.buttonsPressed = {}

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.mousepressed(x, y, button, istouch)
    love.mouse.buttonsPressed[button] = true
end
---------------------------------------
--- 2D AABB Collision
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
