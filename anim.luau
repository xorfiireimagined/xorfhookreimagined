local Players = game:GetService("Players")
local Player = Players.LocalPlayer

getgenv().animid = "92281817840531"
getgenv().speed = 1
getgenv().doAnimation = false

local function anim2track(asset_id)
    local objs = game:GetObjects(asset_id)
    for i = 1, #objs do
        if objs[i]:IsA("Animation") then
            return objs[i].AnimationId
        end
    end
    return asset_id
end

-- Setup Animation Object
if not animid:find("rbxassetid://") then
    animid = "rbxassetid://" .. animid
end

animid = anim2track(animid)
local animation = Instance.new("Animation")
animation.AnimationId = animid

local function playAnim(character)
    -- Check the variable BEFORE running any logic
    if not getgenv().doAnimation then 
        return 
    end

    local Hum = character:FindFirstChildWhichIsA("Humanoid")
    if not Hum then return end

    -- Stop existing tracks
    for _, track in next, Hum:GetPlayingAnimationTracks() do
        track:Stop()
    end

    local anim = Hum:LoadAnimation(animation)
    anim.Priority = Enum.AnimationPriority.Action4
    anim:Play()
    anim:AdjustSpeed(getgenv().speed)

    -- Loop logic
    anim.Stopped:Connect(function()
        -- Re-check variable before looping
        if getgenv().doAnimation then
            playAnim(character)
        end
    end)
end

-- Listen for Character Respawns
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    playAnim(character)
end)

-- Initial Run
if Player.Character then
    playAnim(Player.Character)
end
