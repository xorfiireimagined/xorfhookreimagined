getgenv().FlySettings = {
    Enabled = false,
    Speed = 50
}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera

local BV, BG

-- Change 'local function' to 'getgenv().ToggleFly'
getgenv().ToggleFly = function(Value)
    getgenv().FlySettings.Enabled = Value
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not Value then
        if BV then BV:Destroy() end
        if BG then BG:Destroy() end
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
        return
    end

    if root then
        BG = Instance.new("BodyGyro", root)
        BG.P = 9e4; BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9); BG.CFrame = root.CFrame

        BV = Instance.new("BodyVelocity", root)
        BV.Velocity = Vector3.new(0, 0, 0); BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        char:FindFirstChildOfClass("Humanoid").PlatformStand = true

        task.spawn(function()
            while getgenv().FlySettings.Enabled and root and char.Parent do
                local direction = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - Camera.CFrame.LookVector:Cross(Vector3.new(0, 1, 0)) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + Camera.CFrame.LookVector:Cross(Vector3.new(0, 1, 0)) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end

                BV.Velocity = direction * getgenv().FlySettings.Speed
                BG.CFrame = Camera.CFrame
                RunService.RenderStepped:Wait()
            end
        end)
    end
end
