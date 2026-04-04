-- ESP Configuration (Global)
getgenv().ESP = {
    Enabled = false,
    Dynamic = false,
    UpdateRate = 1,
    
    -- Individual toggles
    Names = false,
    HealthBar = false,
    HealthText = false,
    Tracers = false,
    Distance = false,
    
    -- Settings
    MaxDistance = 500,
    Color = Color3.fromRGB(255, 50, 50),
    
    -- Internal storage (not needed in UI)
    Objects = {},
    Cache = {
        Square = {},
        Text = {},
        Line = {}
    }
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Drawing cache functions
local function GetDrawing(type)
    local cache = getgenv().ESP.Cache[type]
    if #cache > 0 then
        return table.remove(cache)
    end
    return Drawing.new(type)
end

local function ReturnDrawing(obj, type)
    obj.Visible = false
    table.insert(getgenv().ESP.Cache[type], obj)
end

-- Create ESP for player
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local objects = {
        Box = GetDrawing("Square"),
        Name = GetDrawing("Text"),
        HealthBar = GetDrawing("Square"),
        HealthBarBG = GetDrawing("Square"),
        HealthText = GetDrawing("Text"),
        Tracer = GetDrawing("Line"),
        Distance = GetDrawing("Text")
    }
    
    -- Setup Box
    objects.Box.Thickness = 1
    objects.Box.Filled = false
    objects.Box.Visible = false
    
    -- Setup Name
    objects.Name.Size = 13
    objects.Name.Center = true
    objects.Name.Outline = true
    objects.Name.Visible = false
    
    -- Setup Health Bars
    objects.HealthBar.Thickness = 1
    objects.HealthBar.Filled = true
    objects.HealthBar.Visible = false
    
    objects.HealthBarBG.Thickness = 1
    objects.HealthBarBG.Filled = true
    objects.HealthBarBG.Color = Color3.fromRGB(0, 0, 0)
    objects.HealthBarBG.Visible = false
    
    -- Setup Health Text
    objects.HealthText.Size = 11
    objects.HealthText.Center = true
    objects.HealthText.Outline = true
    objects.HealthText.Visible = false
    
    -- Setup Tracer
    objects.Tracer.Thickness = 1
    objects.Tracer.Visible = false
    
    -- Setup Distance
    objects.Distance.Size = 11
    objects.Distance.Center = true
    objects.Distance.Outline = true
    objects.Distance.Visible = false
    
    getgenv().ESP.Objects[player] = objects
    
    -- Cleanup
    player.AncestryChanged:Connect(function()
        if not player:IsDescendantOf(game) then
            for _, obj in pairs(objects) do
                if obj then obj:Remove() end
            end
            getgenv().ESP.Objects[player] = nil
        end
    end)
end

-- Main ESP Update
local function UpdateESP()
    local ESP = getgenv().ESP
    
    if not ESP.Enabled then
        for _, objects in pairs(ESP.Objects) do
            for _, obj in pairs(objects) do
                if obj then obj.Visible = false end
            end
        end
        return
    end
    
    -- Frame skip for performance
    ESP.LastUpdate = (ESP.LastUpdate or 0) + 1
    if ESP.UpdateRate > 0 and ESP.LastUpdate % (ESP.UpdateRate + 1) ~= 0 then
        return
    end
    
    local cameraPos = Camera.CFrame.Position
    local viewportSize = Camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y)
    
    for player, objects in pairs(ESP.Objects) do
        local character = player.Character
        
        if not character then
            for _, obj in pairs(objects) do
                if obj then obj.Visible = false end
            end
            continue
        end
        
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
        
        if not humanoid or not rootPart or humanoid.Health <= 0 then
            for _, obj in pairs(objects) do
                if obj then obj.Visible = false end
            end
            continue
        end
        
        -- Distance check
        local distance = (rootPart.Position - cameraPos).Magnitude
        if distance > ESP.MaxDistance then
            for _, obj in pairs(objects) do
                if obj then obj.Visible = false end
            end
            continue
        end
        
        -- World to screen
        local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        if not onScreen then
            for _, obj in pairs(objects) do
                if obj then obj.Visible = false end
            end
            continue
        end
        
        -- Calculate box
        local scale = math.clamp(1000 / distance, 10, 100)
        local boxWidth = scale
        local boxHeight = scale * 1.8
        local boxX = pos.X - boxWidth / 2
        local boxY = pos.Y - boxHeight / 2
        
        local color = ESP.Color
        
        -- Box
        objects.Box.Size = Vector2.new(boxWidth, boxHeight)
        objects.Box.Position = Vector2.new(boxX, boxY)
        objects.Box.Color = color
        objects.Box.Visible = true
        
        -- Name
        if ESP.Names then
            objects.Name.Text = player.Name
            objects.Name.Position = Vector2.new(pos.X, boxY - 15)
            objects.Name.Color = color
            objects.Name.Visible = true
        else
            objects.Name.Visible = false
        end
        
        -- Health Bar
        if ESP.HealthBar then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            local barWidth = 4
            local barHeight = boxHeight
            local barX = boxX - barWidth - 2
            local barY = boxY
            
            objects.HealthBarBG.Size = Vector2.new(barWidth, barHeight)
            objects.HealthBarBG.Position = Vector2.new(barX, barY)
            objects.HealthBarBG.Visible = true
            
            local healthHeight = barHeight * healthPercent
            objects.HealthBar.Size = Vector2.new(barWidth, healthHeight)
            objects.HealthBar.Position = Vector2.new(barX, barY + (barHeight - healthHeight))
            objects.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
            objects.HealthBar.Visible = true
        else
            objects.HealthBar.Visible = false
            objects.HealthBarBG.Visible = false
        end
        
        -- Health Text
        if ESP.HealthText then
            objects.HealthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
            objects.HealthText.Position = Vector2.new(pos.X, boxY + boxHeight + 2)
            objects.HealthText.Color = Color3.fromRGB(255, 255, 255)
            objects.HealthText.Visible = true
        else
            objects.HealthText.Visible = false
        end
        
        -- Tracers
        if ESP.Tracers then
            objects.Tracer.From = screenCenter
            objects.Tracer.To = Vector2.new(pos.X, boxY + boxHeight)
            objects.Tracer.Color = color
            objects.Tracer.Visible = true
        else
            objects.Tracer.Visible = false
        end
        
        -- Distance
        if ESP.Distance then
            objects.Distance.Text = math.floor(distance) .. "m"
            objects.Distance.Position = Vector2.new(pos.X, boxY + boxHeight + (ESP.HealthText and 15 or 2))
            objects.Distance.Color = Color3.fromRGB(200, 200, 200)
            objects.Distance.Visible = true
        else
            objects.Distance.Visible = false
        end
    end
end

-- Initialize
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(CreateESP)

-- Start loop
RunService.RenderStepped:Connect(UpdateESP)
