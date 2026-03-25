-- Xorfhook v2 - Single File Aimbot
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Settings (linked to GUI)
getgenv().AimbotEnabled = getgenv().AimbotEnabled or false
getgenv().AimbotSmoothness = getgenv().AimbotSmoothness or 1
getgenv().AimbotFOV = getgenv().AimbotFOV or 180

-- FOV Circle setup
local Circle = nil
local function SetupCircle()
    if Circle then return end
    if not Drawing then 
        warn("[Xorfhook] Drawing library not available")
        return 
    end
    
    local success, result = pcall(function()
        local c = Drawing.new("Circle")
        c.Thickness = 2
        c.Visible = false
        c.Color = Color3.fromRGB(255, 50, 50)
        c.Transparency = 0.5
        c.Filled = false
        c.NumSides = 32
        return c
    end)
    
    if success then
        Circle = result
        print("[Xorfhook] FOV Circle created")
    else
        warn("[Xorfhook] Failed to create circle: " .. tostring(result))
    end
end

SetupCircle()

-- Get mousemoverel function
local MouseMoveRel = nil
local function GetMouseMoveRel()
    if MouseMoveRel then return MouseMoveRel end
    
    -- Try all common options
    if typeof(mousemoverel) == "function" then
        MouseMoveRel = mousemoverel
    elseif typeof(syn) == "table" and typeof(syn.mousemoverel) == "function" then
        MouseMoveRel = syn.mousemoverel
    elseif typeof(fluxus) == "table" and typeof(fluxus.mousemoverel) == "function" then
        MouseMoveRel = fluxus.mousemoverel
    elseif typeof(KRNL) == "table" and typeof(KRNL.mousemoverel) == "function" then
        MouseMoveRel = KRNL.mousemoverel
    elseif typeof(YUBX) == "table" and typeof(YUBX.mousemoverel) == "function" then
        MouseMoveRel = YUBX.mousemoverel
    elseif typeof(Xeno) == "table" and typeof(Xeno.mousemoverel) == "function" then
        MouseMoveRel = Xeno.mousemoverel
    else
        -- Fallback to VIM
        local VIM = game:GetService("VirtualInputManager")
        MouseMoveRel = function(x, y)
            local currentPos = UserInputService:GetMouseLocation()
            VIM:SendMouseMoveEvent(currentPos.X + x, currentPos.Y + y, game)
        end
    end
    
    print("[Xorfhook] Using mousemoverel: " .. tostring(MouseMoveRel))
    return MouseMoveRel
end

-- Test mousemoverel
task.spawn(function()
    task.wait(1)
    local mover = GetMouseMoveRel()
    if mover then
        print("[Xorfhook] MouseMoveRel ready!")
    else
        warn("[Xorfhook] MouseMoveRel NOT FOUND!")
    end
end)

-- Get target function
local function GetTarget()
    local target = nil
    local shortestDist = getgenv().AimbotFOV or 180
    local mousePos = UserInputService:GetMouseLocation()
    
    local allPlayers = Players:GetPlayers()
    
    for i = 1, #allPlayers do
        local v = allPlayers[i]
        if v == LocalPlayer then continue end
        
        local character = v.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        -- Check for head hitboxes first, then normal head
        local part = character:FindFirstChild("HeadHB") or 
                     character:FindFirstChild("Head") or 
                     character:FindFirstChild("UpperTorso")
        
        if part then
            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
            
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                
                if dist < shortestDist then
                    shortestDist = dist
                    target = {
                        Part = part,
                        ScreenPos = Vector2.new(pos.X, pos.Y)
                    }
                end
            end
        end
    end
    
    return target
end

-- Main loop with error handling
local Connection = RunService.RenderStepped:Connect(function()
    local success, err = pcall(function()
        -- Update circle
        if Circle then
            Circle.Visible = getgenv().AimbotEnabled
            Circle.Radius = getgenv().AimbotFOV or 180
            Circle.Position = UserInputService:GetMouseLocation()
            
            -- Change color if target found
            if getgenv().AimbotEnabled then
                local target = GetTarget()
                if target then
                    Circle.Color = Color3.fromRGB(0, 255, 0)
                    Circle.Filled = true
                    Circle.Transparency = 0.3
                else
                    Circle.Color = Color3.fromRGB(255, 50, 50)
                    Circle.Filled = false
                    Circle.Transparency = 0.5
                end
            end
        end
        
        -- Aimbot logic
        if getgenv().AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local target = GetTarget()
            
            if target and target.ScreenPos then
                local mousePos = UserInputService:GetMouseLocation()
                local smoothness = math.clamp(getgenv().AimbotSmoothness or 1, 0.1, 10)
                
                -- Calculate movement (FIXED: divide by smoothness, not multiply)
                local deltaX = (target.ScreenPos.X - mousePos.X) / smoothness
                local deltaY = (target.ScreenPos.Y - mousePos.Y) / smoothness
                
                -- Skip tiny movements
                if math.abs(deltaX) < 0.5 and math.abs(deltaY) < 0.5 then
                    return
                end
                
                local mover = GetMouseMoveRel()
                if mover then
                    pcall(function()
                        mover(deltaX, deltaY)
                    end)
                end
            end
        end
    end)
    
    if not success then
        warn("[Xorfhook Aimbot Error] " .. tostring(err))
    end
end)

-- Store connection for cleanup
getgenv().XorfhookAimbotConnection = Connection

print("[Xorfhook] Aimbot loaded successfully!")
