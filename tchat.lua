local chat = peripheral.find("chatBox")
if not chat then error("ChatBox introuvable") end

local messages = {}

local function draw()
    term.clear()
    term.setCursorPos(1, 1)

    for _, msg in ipairs(messages) do
        print(msg)
    end

    local _, h = term.getSize()
    term.setCursorPos(1, h)
    write("> ")
end

local function receive()
    while true do
        local event, uuid, username, message, isHidden = os.pullEvent("chat")

        table.insert(messages, "<" .. username .. "> " .. message)

        if #messages > 15 then
            table.remove(messages, 1)
        end

        draw()
    end
end

local function writeMessage()
    local options = {
        prefix = "test"
    }
    while true do
        draw()

        local msg = read()

        if msg ~= "" then
            chat.sendMessage(msg,options)
            table.insert(messages, "<MOI> " .. msg)
        end
    end
end

parallel.waitForAll(receive, writeMessage)
