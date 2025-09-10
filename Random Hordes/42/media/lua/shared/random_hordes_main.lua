RandomHordeCompatibility = true;
RandomHordeName = "RandomHorde";
RandomHordeIsSinglePlayer = false;

if not isClient() and not isServer() then
    RandomHordeIsSinglePlayer = true;
end

function DebugPrintRandomHorde(log)
    if RandomHordeIsSinglePlayer then
        print("[" .. RandomHordeName .. "] " .. log);
    else
        if isClient() then
            print("[" .. RandomHordeName .. "-Client] " .. log);
        else
            if isServer() then
                print("[" .. RandomHordeName .. "-Server] " .. log);
            else
                print("[" .. RandomHordeName .. "-Unkown] " .. log);
            end
        end
    end
end