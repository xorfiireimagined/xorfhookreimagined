local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Settings
getgenv().ESPEnabled = getgenv().ESPEnabled or false
getgenv().ESPColor = getgenv().ESPColor or Color3.fromRGB(255, 0, 0)
getgenv().ESPShowHealth = getgenv().ESPShowHealth or false

-- ESP storage
local ESPObjects = {}

-- Create drawing objects for a player
local function CreateESP(player)
    if ESPObjects[player] then return end
    
    local objects = {
        -- 4 corner lines
        TopLeft = Drawing.new("Line"),
        TopRight = Drawing.new("Line"),
        BottomLeft = Drawing.new("Line"),
        BottomRight = Drawing.new("Line"),
        -- Health text
        HealthText = Drawing.new("Text")
    }
    
    -- Setup corner lines
    for _, line in pairs({objects.TopLeft, objects.TopRight, objects.BottomLeft, objects.BottomRight}) do
        line.Thickness = 1.5
        line.Transparency = 1
        line.Visible = false
    end
    
    -- Setup health text
    objects.HealthText.Size = 13
    objects.HealthText.Center = true
    objects.HealthText.Outline = true
    objects.HealthText.Font = 2
    objects.HealthText.Visible = false
    
    ESPObjects[player] = objects
end

-- Remove ESP for a player
local function RemoveESP(player)
    if not ESPObjects[player] then return end
    
    for _, obj in pairs(ESPObjects[player]) do
        if obj then
            pcall(function() obj:Remove() end)
        end
    end
    
    ESPObjects[player] = nil
end

-- Update ESP for a player
local function UpdateESP(player)
    if not ESPObjects[player] then
        CreateESP(player)
    end
    
    local objects = ESPObjects[player]
    local character = player.Character
    
    -- Check if valid
    if not getgenv().ESPEnabled or not character then
        for _, obj in pairs(objects) do
            obj.Visible = false
        end
        return
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not hrp or humanoid.Health <= 0 then
        for _, obj in pairs(objects) do
            obj.Visible = false
        end
        return
    end
    
    -- Get bounding box
    local cframe, size = character:GetBoundingBox()
    local halfSize = size / 2
    
    -- Get 8 corners of the box
    local corners = {
        cframe * CFrame.new(-halfSize.X, -halfSize.Y, -halfSize.Z),
        cframe * CFrame.new(-halfSize.X, -halfSize.Y, halfSize.Z),
        cframe * CFrame.new(-halfSize.X, halfSize.Y, -halfSize.Z),
        cframe * CFrame.new(-halfSize.X, halfSize.Y, halfSize.Z),
        cframe * CFrame.new(halfSize.X, -halfSize.Y, -halfSize.Z),
        cframe * CFrame.new(halfSize.X, -halfSize.Y, halfSize.Z),
        cframe * CFrame.new(halfSize.X, halfSize.Y, -halfSize.Z),
        cframe * CFrame.new(halfSize.X, halfSize.Y, halfSize.Z)
    }
    
    -- Convert to screen space
    local screenCorners = {}
    local onScreen = false
    
    for i, corner in ipairs(corners) do
        local pos, visible = Camera:WorldToViewportPoint(corner.Position)
        screenCorners[i] = Vector2.new(pos.X, pos.Y)
        if visible then onScreen = true end
    end
    
    if not onScreen then
        for _, obj in pairs(objects) do
            obj.Visible = false
        end
        return
    end
    
    local color = getgenv().ESPColor or Color3.fromRGB(255, 0, 0)
    local cornerLength = 8 -- Length of corner lines in pixels
    
    -- Update corner lines (top left, top right, bottom left, bottom right)
    -- Top left corner: lines going right and down
    objects.TopLeft.From = screenCorners[3]
    objects.TopLeft.To = screenCorners[3] + Vector2.new(cornerLength, 0)
    objects.TopLeft.Color = color
    objects.TopLeft.Visible = true
    
    objects.TopLeft.From = screenCorners[3]
    objects.TopLeft.To = screenCorners[3] + Vector2.new(0, cornerLength)
    -- Actually let's do this properly with 4 separate lines
    
    -- Find min/max for box
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    
    for _, corner in ipairs(screenCorners) do
        minX = math.min(minX, corner.X)
        minY = math.min(minY, corner.Y)
        maxX = math.max(maxX, corner.X)
        maxY = math.max(maxY, corner.Y)
    end
    
    -- Draw corners only (not full box)
    local tl = Vector2.new(minX, minY)
    local tr = Vector2.new(maxX, minY)
    local bl = Vector2.new(minX, maxY)
    local br = Vector2.new(maxX, maxY)
    
    -- Top left corner
    objects.TopLeft.From = tl
    objects.TopLeft.To = tl + Vector2.new(cornerLength, 0)
    objects.TopLeft.Color = color
    objects.TopLeft.Visible = true
    
    -- Actually use 2 lines per corner or just draw 4 corners
    -- Let me simplify: draw 4 corners as L shapes
    
    -- Top left
    objects.TopLeft.From = tl
    objects.TopLeft.To = tl + Vector2.new(cornerLength, 0)
    objects.TopLeft.Color = color
    objects.TopLeft.Visible = true
    
    -- We need 8 lines total for 4 corners, but let's use 4 lines for simplicity
    -- Just draw the outer edges of corners
    
    -- Redo with 8 lines stored properly
    if not objects.Lines then
        objects.Lines = {}
        for i = 1, 8 do
            objects.Lines[i] = Drawing.new("Line")
            objects.Lines[i].Thickness = 1.5
        end
    end
    
    local lines = objects.Lines
    local l = cornerLength
    
    -- Top left: right and down
    lines[1].From = tl
    lines[1].To = Vector2.new(tl.X + l, tl.Y)
    lines[2].From = tl
    lines[2].To = Vector2.new(tl.X, tl.Y + l)
    
    -- Top right: left and down
    lines[3].From = tr
    lines[3].To = Vector2.new(tr.X - l, tr.Y)
    lines[4].From = tr
    lines[4].To = Vector2.new(tr.X, tr.Y + l)
    
    -- Bottom left: right and up
    lines[5].From = bl
    lines[5].To = Vector2.new(bl.X + l, bl.Y)
    lines[6].From = bl
    lines[6].To = Vector2.new(bl.X, bl.Y - l)
    
    -- Bottom right: left and up
    lines[7].From = br
    lines[7].To = Vector2.new(br.X - l, br.Y)
    lines[8].From = br
    lines[8].To = Vector2.new(br.X, br.Y - l)
    
    for i = 1, 8 do
        lines[i].Color = color
        lines[i].Visible = true
    end
    
    -- Hide old objects if they exist
    objects.TopLeft.Visible = false
    objects.TopRight.Visible = false
    objects.BottomLeft.Visible = false
    objects.BottomRight.Visible = false
    
    -- Health text
    if getgenv().ESPShowHealth then
        objects.HealthText.Position = Vector2.new((minX + maxX) / 2, minY - 20)
        objects.HealthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
        objects.HealthText.Color = Color3.fromRGB(255, 255, 255)
        objects.HealthText.Visible = true
    else
        objects.HealthText.Visible = false
    end
end

-- Main loop
RunService.RenderStepped:Connect(function()
    if not getgenv().ESPEnabled then
        -- Hide all
        for _, objects in pairs(ESPObjects) do
            for _, obj in pairs(objects) do
                if typeof(obj) == "table" then
                    for _, line in pairs(obj) do
                        if line and line.Visible ~= nil then
                            line.Visible = false
                        end
                    end
                elseif obj and obj.Visible ~= nil then
                    obj.Visible = false
                end
            end
        end
        return
    end
    
    -- Clean up disconnected players
    for player in pairs(ESPObjects) do
        if not player or not player.Parent then
            RemoveESP(player)
        end
    end
    
    -- Update all players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UpdateESP(player)
        end
    end
end)

-- Cleanup on death/leave
Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

print("[Xorfhook] ESP loaded - Corner boxes with health text")
