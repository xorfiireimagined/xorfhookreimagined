getgenv().XorfhookLoaded = true

local loaderURL = "https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/loader.luau"
local guiURL = "https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/main.luau"

-- Universal queue_on_teleport with proper error handling
local function setupQueueOnTeleport()
    local queued = false
    
    local function tryQueue(func, name)
        if queued then return end
        local success = pcall(func)
        if success then 
            queued = true 
            print("[Xorfhook] Queued on teleport using " .. name)
        end
    end
    
    -- Try various methods
    if typeof(queue_on_teleport) == "function" then
        tryQueue(function() queue_on_teleport('loadstring(game:HttpGet("' .. loaderURL .. '"))()') end, "queue_on_teleport")
    end
    
    if not queued and typeof(syn) == "table" and typeof(syn.queue_on_teleport) == "function" then
        tryQueue(function() syn.queue_on_teleport('loadstring(game:HttpGet("' .. loaderURL .. '"))()') end, "syn")
    end
    
    if not queued and typeof(fluxus) == "table" and typeof(fluxus.queue_on_teleport) == "function" then
        tryQueue(function() fluxus.queue_on_teleport('loadstring(game:HttpGet("' .. loaderURL .. '"))()') end, "fluxus")
    end
    
    if not queued and typeof(KRNL) == "table" and typeof(KRNL.queue_on_teleport) == "function" then
        tryQueue(function() KRNL.queue_on_teleport('loadstring(game:HttpGet("' .. loaderURL .. '"))()') end, "KRNL")
    end
    
    if not queued and typeof(YUBX) == "table" and typeof(YUBX.queue_on_teleport) == "function" then
        tryQueue(function() YUBX.queue_on_teleport('loadstring(game:HttpGet("' .. loaderURL .. '"))()') end, "YUBX")
    end
end

-- Non-blocking load with timeout
local function safeLoad(url, timeout)
    timeout = timeout or 10
    
    local result = nil
    local loaded = false
    
    -- Load in separate thread
    task.spawn(function()
        local success, data = pcall(function()
            local content = game:HttpGet(url, true)
            if content and #content > 0 then
                local func, err = loadstring(content)
                if func then
                    return func
                else
                    error("Loadstring failed: " .. tostring(err))
                end
            else
                error("Empty content")
            end
        end)
        
        if success then
            result = data
        else
            warn("[Xorfhook] Failed to load " .. url .. ": " .. tostring(data))
        end
        loaded = true
    end)
    
    -- Wait with timeout
    local start = tick()
    while not loaded and (tick() - start) < timeout do
        task.wait(0.1)
    end
    
    return result
end

-- Setup teleport queue (non-blocking)
setupQueueOnTeleport()

-- Load GUI immediately without waiting
task.spawn(function()
    -- Small delay to let game initialize
    task.wait(0.5)
    
    print("[Xorfhook] Loading GUI...")
    local guiScript = safeLoad(guiURL, 15)
    
    if guiScript then
        print("[Xorfhook] GUI loaded, executing...")
        local success, err = pcall(guiScript)
        if not success then
            warn("[Xorfhook] GUI execution error: " .. tostring(err))
        else
            print("[Xorfhook] GUI executed successfully!")
        end
    else
        warn("[Xorfhook] Failed to load GUI after timeout!")
    end
end)

print("[Xorfhook] Loader initialized")
