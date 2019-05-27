require("src/Dependencies")

function love.load()
    gDefaultFont = love.graphics.newFont(20)
    gScore = 0

    love.graphics.setFont(gDefaultFont)

    board = Board()
    board._matrix = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12},
        {13, 14, 0, 15}
    }
    board._emptyRow, board._emptyColumn = 4, 3
end

function love.draw()
    love.graphics.setBackgroundColor(0, 1, 0)
    board:render()

    love.graphics.rectangle("line", 250, 350, 130, 30)
    love.graphics.printf("New Puzzle", 250, 352, 130, "center")
    love.graphics.print("Score: " .. gScore, 310, 10)
end

function love.update(dt)
    board:update(dt)

    if (love.keyboard.wasPressed("escape")) then
        love.event.quit()
    end

    if (love.mouse.wasPressed(1) and checkCollision(love.mouse.getX(), love.mouse.getY(), 1, 1, 250, 350, 130, 20)) then
        board:reset()
    end

    if (board:checkCompletion()) then
        gScore = gScore + 1
        board:reset()
    end

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end
