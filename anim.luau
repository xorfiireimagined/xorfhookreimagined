local Players = game:GetService("Players")
local Player = Players.LocalPlayer

getgenv().animid = "92281817840531"
getgenv().animspeed = 1
getgenv().doAnimation = false

local function anim2track(asset_id)
    local success, objs = pcall(function() return game:GetObjects(asset_id) end)
    if success and objs then
        for i = 1, #objs do
            if objs[i]:IsA("Animation") then
                return objs[i].AnimationId
            end
        end
    end
    return asset_id
end

local function playAnim(character)
    if not getgenv().doAnimation then return end

    local Hum = character:FindFirstChildOfClass("Humanoid")
    if not Hum then return end

    -- Use task.spawn to prevent the main thread from hanging
    task.spawn(function()
        -- Stop existing tracks to prevent overlapping
        for _, track in next, Hum:GetPlayingAnimationTracks() do
            track:Stop()
        end

        local animation = Instance.new("Animation")
        local cleanID = tostring(getgenv().animid):gsub("rbxassetid://", "")
        animation.AnimationId = anim2track("rbxassetid://" .. cleanID)
        
        local anim = Hum:LoadAnimation(animation)
        anim.Priority = Enum.AnimationPriority.Action4
        anim:Play()
        
        -- FIXED: Changed 'speed' to 'animspeed' to match your config [cite: 24, 25]
        anim:AdjustSpeed(getgenv().animspeed or 1)

        -- Improved loop logic to prevent crashing
        repeat task.wait(0.1) until not anim.IsPlaying or not getgenv().doAnimation
        
        if getgenv().doAnimation then
            playAnim(character)
        else
            anim:Stop()
        end
    end)
end

-- Re-trigger when the toggle is turned ON
debug.getregistry().PlayAnimGlobal = playAnim 

Player.CharacterAdded:Connect(playAnim)
if Player.Character then playAnim(Player.Character) end
