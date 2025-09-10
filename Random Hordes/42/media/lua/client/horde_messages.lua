if RandomHordeIsSinglePlayer then return end

-- Add the text to the player
local function addLineToChat(message, color, username, options)
    if type(options) ~= "table" then
        options = {
            showTime = false,
            serverAlert = false,
            showAuthor = false,
        };
    end

    if type(color) ~= "string" then
        color = "<RGB:1,1,1>";
    end

    if options.showTime then
        local dateStamp = Calendar.getInstance():getTime();
        local dateFormat = SimpleDateFormat.new("H:mm");
        if dateStamp and dateFormat then
            message = color .. "[" .. tostring(dateFormat:format(dateStamp) or "N/A") .. "]  " .. message;
        end
    else
        message = color .. message;
    end

    local msg = {
        getText = function(_)
            return message;
        end,
        getTextWithPrefix = function(_)
            return message;
        end,
        isServerAlert = function(_)
            return options.serverAlert;
        end,
        isShowAuthor = function(_)
            return options.showAuthor;
        end,
        getAuthor = function(_)
            return tostring(username);
        end,
        setShouldAttractZombies = function(_)
            return false
        end,
        setOverHeadSpeech = function(_)
            return false
        end,
    };

    if not ISChat.instance then return; end;
    if not ISChat.instance.chatText then return; end;
    ISChat.addLineInChat(msg, 0);
end

-- Called everytime the server send something to us
local function OnServerCommand(module, command, arguments)
    if module == "RandomHordes" and command == "hordeIncoming" then
        -- Adding a message to it
        addLineToChat(getText("IGUI_Horde_Incoming"), "<RGB:" .. "255,0,0" .. ">");

        -- Alert sound
        local alarmSound = "zombierand" .. tostring(ZombRand(10));
        local sound = getSoundManager():PlaySound(alarmSound, false, 0);
        getSoundManager():PlayAsMusic(alarmSound, sound, false, 0);

        -- You should awake the player if a horde is coming right?
        getPlayer():forceAwake();
    end
end
Events.OnServerCommand.Add(OnServerCommand)
