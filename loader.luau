-- [[ XORFHOOK V2 UNIVERSAL LOADER ]] --
if getgenv().XorfhookExecuting then return end -- Prevent infinite loops
getgenv().XorfhookExecuting = true

local loaderURL = "https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/loader.luau"
local guiURL = "https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/main.luau"

-- 1. Optimized Queue On Teleport (Xeno/Universal)
local function Queue()
    local script = 'loadstring(game:HttpGet("' .. loaderURL .. '"))()'
    if queue_on_teleport then
        queue_on_teleport(script)
    elseif syn and syn.queue_on_teleport then
        syn.queue_on_teleport(script)
    elseif fluxus and fluxus.queue_on_teleport then
        fluxus.queue_on_teleport(script)
    end
end

Queue()

-- 2. Direct Load (No complex timeout, just a clean pcall)
task.spawn(function()
    print("[Xorfhook] Fetching V2 Script...")
    
    local success, content = pcall(game.HttpGet, game, guiURL)
    if success and content then
        local func, err = loadstring(content)
        if func then
            print("[Xorfhook] Execution Started.")
            local execSuccess, execErr = pcall(func)
            if not execSuccess then
                warn("[Xorfhook] Main Script Error: " .. tostring(execErr))
            end
        else
            warn("[Xorfhook] Syntax Error: " .. tostring(err))
        end
    else
        warn("[Xorfhook] Connection Error: Could not reach GitHub.")
    end
    
    getgenv().XorfhookExecuting = false -- Reset so you can re-run if it fails
end)
