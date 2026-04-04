local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lp = plrs.LocalPlayer
local cam = workspace.CurrentCamera

-- [[ CONFIGURATION ]] --
getgenv().Aimbot = true
getgenv().WallCheck = true
getgenv().Smoothness = 0.15 -- 0.1 to 1 (Lower is smoother/legit, 1 is instant)
getgenv().FOV = 150
getgenv().showCircle = true

-- [[ FOV CIRCLE SETUP ]] --
local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.NumSides = 64
circle.Radius = getgenv().FOV
circle.Visible = getgenv().showCircle
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Transparency = 0.5

-- [[ VISIBILITY CHECK (WALL CHECK) ]] --
local function is_visible(target_part)
    local origin = cam.CFrame.Position
    local direction = (target_part.Position - origin).Unit * (target_part.Position - origin).Magnitude
    
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {lp.Character, cam}
    params.FilterType = Enum.RaycastFilterType.Exclude
    
    local result = workspace:Raycast(origin, direction, params)
    
    -- Returns true if nothing is in the way, or if the hit object belongs to the target
    return not result or result.Instance:IsDescendantOf(target_part.Parent)
end

-- [[ TARGETING LOGIC ]] --
local function get_target()
    local target = nil
    local dist = getgenv().FOV
    local mouse = uis:GetMouseLocation()

    for _, v in pairs(plrs:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            
            -- Checks for Rivals HeadHB or standard character parts
            local part = v.Character:FindFirstChild("HeadHB") or v.Character:FindFirstChild("Head") or v.Character:FindFirstChild("UpperTorso")
            
            if part then
                local pos, on_screen = cam:WorldToViewportPoint(part.Position)
                
                if on_screen then
                    local mag = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                    
                    if mag < dist then
                        -- Check visibility if WallCheck is enabled
                        if not getgenv().WallCheck or is_visible(part) then
                            dist = mag
                            target = part
                        end
                    end
                end
            end
        end
    end
    return target
end

-- [[ MAIN LOOP ]] --
rs.RenderStepped:Connect(function()
    -- Update FOV Circle
    circle.Visible = getgenv().Aimbot and getgenv().showCircle
    circle.Radius = getgenv().FOV
    circle.Position = uis:GetMouseLocation()

    -- Aimbot Execution (Holding Right Click)
    if getgenv().Aimbot and uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then 
        local target = get_target()
        
        if target then
            local pos, _ = cam:WorldToViewportPoint(target.Position)
            local mouse_loc = uis:GetMouseLocation()
            
            -- Smooth relative movement
            local x = (pos.X - mouse_loc.X) * getgenv().Smoothness
            local y = (pos.Y - mouse_loc.Y) * getgenv().Smoothness
            
            -- Xeno supports mousemoverel perfectly
            if mousemoverel then
                mousemoverel(x, y)
            end
        end
    end
end)
