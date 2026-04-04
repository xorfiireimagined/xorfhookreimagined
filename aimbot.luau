local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lp = plrs.LocalPlayer
local cam = workspace.CurrentCamera

-- Global Settings
getgenv().Aimbot = false
getgenv().showCircle = false
getgenv().Smoothness = 0.25 -- Lower = Smoother for cross-executor compatibility
getgenv().FOV = 180

-- Universal Mouse Mover Check
local mousemove = mousemoverel or (Input and Input.MouseMove) or (mouse_move_relative)

-- FOV Circle setup
local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.Visible = false
circle.Color = Color3.fromRGB(255, 50, 50)
circle.Transparency = 0.5

local function get_target()
    local target = nil
    local dist = getgenv().FOV
    local mouse = uis:GetMouseLocation()

    for _, v in pairs(plrs:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            -- Added HeadHB for Rivals compatibility
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

-- Main Loop
rs.RenderStepped:Connect(function()
    circle.Visible = getgenv().Aimbot and getgenv().showCircle
    circle.Radius = getgenv().FOV
    circle.Position = uis:GetMouseLocation()

    if getgenv().Aimbot and uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then 
        local target = get_target()
        
        if target then
            local pos, _ = cam:WorldToViewportPoint(target.Position)
            local mouse_loc = uis:GetMouseLocation()
            
            -- Smoothness calculation that works better on Level 8 executors
            -- We use math.floor to prevent "Sub-pixel" errors that crash some executors
            local x = math.floor((pos.X - mouse_loc.X) * getgenv().Smoothness)
            local y = math.floor((pos.Y - mouse_loc.Y) * getgenv().Smoothness)
            
            if mousemove then
                -- Standard Aimbot
                mousemove(x, y)
            else
                -- Fallback for executors without mousemoverel (CFrame Aimbot)
                -- This is slower but works on EVERYTHING
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            end
        end
    end
end)
