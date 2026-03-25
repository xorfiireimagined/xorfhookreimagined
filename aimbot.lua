local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lp = plrs.LocalPlayer
local cam = workspace.CurrentCamera

-- Settings (read from GUI)
getgenv().Aimbot = getgenv().Aimbot or false
getgenv().Smoothness = getgenv().Smoothness or 1
getgenv().FOV = getgenv().FOV or 180
getgenv().ShowFOVCircle = getgenv().ShowFOVCircle or false  -- NEW!

-- FOV circle setup
local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.Visible = false
circle.Color = Color3.fromRGB(255, 50, 50)
circle.Transparency = 0.5
circle.Filled = false

local function get_target()
    local target = nil
    local dist = getgenv().FOV or 180
    local mouse = uis:GetMouseLocation()

    for _, v in pairs(plrs:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local part = v.Character:FindFirstChild("HeadHB") or v.Character:FindFirstChild("Head") or v.Character:FindFirstChild("UpperTorso")
            
            if part then
                local pos, on_screen = cam:WorldToViewportPoint(part.Position)
                
                if on_screen then
                    local mag = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                    
                    if mag < dist then
                        dist = mag
                        target = part
                    end
                end
            end
        end
    end
    return target
end

rs.RenderStepped:Connect(function()
    -- Update circle visibility based on BOTH Aimbot AND ShowFOVCircle toggles
    circle.Visible = (getgenv().Aimbot or getgenv().ShowFOVCircle) and true or false
    circle.Radius = getgenv().FOV or 180
    circle.Position = uis:GetMouseLocation()

    -- Only aim if enabled and right click held
    if getgenv().Aimbot and uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = get_target()
        
        if target then
            local pos = cam:WorldToViewportPoint(target.Position)
            local mouse_loc = uis:GetMouseLocation()
            
            local smooth = getgenv().Smoothness or 1
            local x = (pos.X - mouse_loc.X) / smooth
            local y = (pos.Y - mouse_loc.Y) / smooth
            
            if mousemoverel then
                mousemoverel(x, y)
            end
        end
    end
end)

print("[Xorfhook] Aimbot loaded")
