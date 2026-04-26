local KeyFilePath = "xorfhook/v2/key.txt"

local CorrectKey = "AX-WDTONTOP2026-2"

local Authenticated = false 
 
 -- [[ FILE SYSTEM SETUP ]] --

-- Ensure the folders exist so writefile doesn't error

if not isfolder("xorfhook") then makefolder("xorfhook") end

if not isfolder("xorfhook/v2") then makefolder("xorfhook/v2") end


-- [[ AUTO-LOGIN CHECK ]] --

if isfile(KeyFilePath) then

    local SavedKey = readfile(KeyFilePath)

    if SavedKey == CorrectKey then

        Authenticated = true

        warn("Xorfhook: Key loaded from file. Authenticated!")

    end

end


-- [[ KEY WINDOW (Only runs if not Authenticated) ]] --

if not Authenticated then

    local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua'))()

    local KeyWindow = Library:CreateWindow({ Title = 'Xorfhook v2 | Auth', Center = true, AutoShow = true })

    local KeyTab = KeyWindow:AddTab('Key')

    local KeyGroup = KeyTab:AddLeftGroupbox('Verification')


    KeyGroup:AddInput('KeyInput', {

        Text = 'Enter Key',

        Default = '',

        Placeholder = 'Paste key here...',

        Callback = function(Value) getgenv().TempKey = Value end

    })


    KeyGroup:AddButton('Verify & Save', function()

        if getgenv().TempKey == CorrectKey then

            -- Save the key to the file

            writefile(KeyFilePath, getgenv().TempKey)

           

            Library:Notify("Key Valid! Saved to " .. KeyFilePath, 3)

            task.wait(1)

           

            Authenticated = true

            Library:Unload() -- Close the key window

        else

            Library:Notify("Invalid Key! Please try again.", 3)

        end

    end)


    -- Halt the rest of the script until they get the key right

    repeat task.wait() until Authenticated == true

end


local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'


local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()

local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()


loadstring(game:HttpGet('https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/aimbot.luau'))()

task.wait(0.5)

loadstring(game:HttpGet('https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/esp.luau'))()

task.wait(0.5)

loadstring(game:HttpGet('https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/fly.luau?v=2'))()


local Window = Library:CreateWindow({

    Title = 'Xorfhook v2 | Rivals',

    Center = true,

    AutoShow = true,

    TabPadding = 8,

    MenuFadeTime = 0.2

})


local Tabs = {

    Main = Window:AddTab('main'),

    World = Window:AddTab('world'),

    Visual = Window:AddTab('visual'),

    Character = Window:AddTab('character'),

    Misc = Window:AddTab('misc'),

    Settings = Window:AddTab('settings')

}


local TabBoxMainLeft = Tabs.Main:AddLeftTabbox()

local TabMainAimbot = TabBoxMainLeft:AddTab('Aimbot')

local TabMainSilent = TabBoxMainLeft:AddTab('Silent Aim')


TabMainAimbot:AddToggle('EnableAimbot', {

    Text = 'Enable Aimbot',

    Default = false,


    Callback = function(Value)

        getgenv().Aimbot = Value

    end

})


TabMainAimbot:AddToggle('EnableFOVACircle', {

    Text = 'Show FOV Circle',

    Default = false,


    Callback = function(Value)

        getgenv().showCircle = Value

    end

})


TabMainAimbot:AddSlider('AimbotFSlider', {

    Text = 'Aimbot FOV',

    Default = 180,

    Min = 10,

    Max = 600,

    Rounding = 1,


    Callback = function(Value)

        getgenv().FOV = Value

    end

})


TabMainAimbot:AddSlider('AimbotSSlider', {

    Text = 'Smoothness',

    Default = 0.5,

    Min = 0.1,

    Max = 5,

    Rounding = 1,


    Callback = function(Value)

        getgenv().Smoothness = Value

    end

})


local Lighting = game:GetService("Lighting")


-- Skyboxes (verified working)

local Skyboxes = {

    Default = {

        SkyboxBk = "rbxassetid://59173387",

        SkyboxDn = "rbxassetid://59173393",

        SkyboxFt = "rbxassetid://59173399",

        SkyboxLf = "rbxassetid://59173411",

        SkyboxRt = "rbxassetid://59173405",

        SkyboxUp = "rbxassetid://59173421"

    },

    Night = {

        SkyboxBk = "rbxassetid://5084575798",

        SkyboxDn = "rbxassetid://5084575916",

        SkyboxFt = "rbxassetid://5084576016",

        SkyboxLf = "rbxassetid://5084576116",

        SkyboxRt = "rbxassetid://5084576248",

        SkyboxUp = "rbxassetid://5084576337"

    },

    Sunset = {

        SkyboxBk = "rbxassetid://4156883784",

        SkyboxDn = "rbxassetid://4156883794",

        SkyboxFt = "rbxassetid://4156883804",

        SkyboxLf = "rbxassetid://4156883814",

        SkyboxRt = "rbxassetid://4156883824",

        SkyboxUp = "rbxassetid://4156883834"

    },

    Space = {

        SkyboxBk = "rbxassetid://159454299",

        SkyboxDn = "rbxassetid://159454296",

        SkyboxFt = "rbxassetid://159454293",

        SkyboxLf = "rbxassetid://159454286",

        SkyboxRt = "rbxassetid://159454300",

        SkyboxUp = "rbxassetid://159454288"

    },

    PurpleNebula = {

        SkyboxBk = "rbxassetid://570557514",

        SkyboxDn = "rbxassetid://570557775",

        SkyboxFt = "rbxassetid://570557559",

        SkyboxLf = "rbxassetid://570557620",

        SkyboxRt = "rbxassetid://570557672",

        SkyboxUp = "rbxassetid://570557727"

    },

    RedNight = {

        SkyboxBk = "rbxassetid://401664839",

        SkyboxDn = "rbxassetid://401664862",

        SkyboxFt = "rbxassetid://401664960",

        SkyboxLf = "rbxassetid://401664969",

        SkyboxRt = "rbxassetid://401664977",

        SkyboxUp = "rbxassetid://401664985"

    },

    Cloudy = {

        SkyboxBk = "rbxassetid://151165214",

        SkyboxDn = "rbxassetid://151165197",

        SkyboxFt = "rbxassetid://151165224",

        SkyboxLf = "rbxassetid://151165227",

        SkyboxRt = "rbxassetid://151165191",

        SkyboxUp = "rbxassetid://151165206"

    },

    Aurora = {

        SkyboxBk = "rbxassetid://1417494030",

        SkyboxDn = "rbxassetid://1417494145",

        SkyboxFt = "rbxassetid://1417494253",

        SkyboxLf = "rbxassetid://1417494402",

        SkyboxRt = "rbxassetid://1417494499",

        SkyboxUp = "rbxassetid://1417494643"

    },

    Dawn = {

        SkyboxBk = "rbxassetid://570557620",

        SkyboxDn = "rbxassetid://570557775",

        SkyboxFt = "rbxassetid://570557559",

        SkyboxLf = "rbxassetid://570557514",

        SkyboxRt = "rbxassetid://570557672",

        SkyboxUp = "rbxassetid://570557727"

    },

    Storm = {

        SkyboxBk = "rbxassetid://252760853",

        SkyboxDn = "rbxassetid://252760986",

        SkyboxFt = "rbxassetid://252761067",

        SkyboxLf = "rbxassetid://252761107",

        SkyboxRt = "rbxassetid://252761155",

        SkyboxUp = "rbxassetid://252761178"

    }

}


local CurrentSky = nil


-- Optimized skybox apply with error handling

local function applySkybox(skyboxName)

    local success, err = pcall(function()

        local skyboxData = Skyboxes[skyboxName]

        if not skyboxData then return end

       

        for _, child in pairs(Lighting:GetChildren()) do

            if child:IsA("Sky") then

                child:Destroy()

            end

        end

       

        CurrentSky = Instance.new("Sky")

        CurrentSky.Name = "CustomSky"

       

        CurrentSky.SkyboxBk = skyboxData.SkyboxBk

        CurrentSky.SkyboxDn = skyboxData.SkyboxDn

        CurrentSky.SkyboxFt = skyboxData.SkyboxFt

        CurrentSky.SkyboxLf = skyboxData.SkyboxLf

        CurrentSky.SkyboxRt = skyboxData.SkyboxRt

        CurrentSky.SkyboxUp = skyboxData.SkyboxUp

       

        CurrentSky.Parent = Lighting

    end)

   

    if not success then

        warn("Skybox error: " .. tostring(err))

    end

end


-- Skybox Group

local SkyboxGroup = Tabs.World:AddLeftGroupbox('Skybox')


SkyboxGroup:AddDropdown('SkyboxSelector', {

    Text = 'Select Skybox',

    Default = 'Default',

    Values = {

        'Default', 'Night', 'Sunset', 'Space', 'PurpleNebula',

        'RedNight', 'Cloudy', 'Aurora', 'Dawn', 'Storm'

    },

    Callback = function(Value)

        applySkybox(Value)

        Library:Notify('Skybox: ' .. Value, 2)

    end

})


SkyboxGroup:AddButton('Restore Default', function()

    applySkybox('Default')

    Library:Notify('Default skybox restored!', 2)

end)


SkyboxGroup:AddDivider()


-- Custom skybox inputs

local customInputs = {'Bk', 'Dn', 'Ft', 'Lf', 'Rt', 'Up'}

for _, dir in pairs(customInputs) do

    SkyboxGroup:AddInput('CustomSkybox' .. dir, {

        Text = 'Custom ' .. dir .. ' ID',

        Default = '',

        Placeholder = 'rbxassetid://...',

        Callback = function(Value)

            getgenv()['CustomSky' .. dir] = Value

        end

    })

end


SkyboxGroup:AddButton('Apply Custom Skybox', function()

    local success, err = pcall(function()

        local customSky = {

            SkyboxBk = getgenv().CustomSkyBk or "",

            SkyboxDn = getgenv().CustomSkyDn or "",

            SkyboxFt = getgenv().CustomSkyFt or "",

            SkyboxLf = getgenv().CustomSkyLf or "",

            SkyboxRt = getgenv().CustomSkyRt or "",

            SkyboxUp = getgenv().CustomSkyUp or ""

        }

       

        local hasValidId = false

        for _, id in pairs(customSky) do

            if id ~= "" then

                hasValidId = true

                break

            end

        end

       

        if not hasValidId then

            Library:Notify('Please enter at least one skybox ID!', 3)

            return

        end

       

        for _, child in pairs(Lighting:GetChildren()) do

            if child:IsA("Sky") then

                child:Destroy()

            end

        end

       

        CurrentSky = Instance.new("Sky")

        CurrentSky.Name = "CustomSky_User"

       

        for prop, assetId in pairs(customSky) do

            if assetId ~= "" then

                if not assetId:find("rbxassetid://") then

                    assetId = "rbxassetid://" .. assetId

                end

                CurrentSky[prop] = assetId

            end

        end

       

        CurrentSky.Parent = Lighting

        Library:Notify('Custom skybox applied!', 2)

    end)

   

    if not success then

        warn("Custom skybox error: " .. tostring(err))

        Library:Notify('Failed to apply skybox!', 3)

    end

end)


-- Atmosphere Group

local AtmosphereGroup = Tabs.World:AddRightGroupbox('Atmosphere')


AtmosphereGroup:AddSlider('TimeOfDay', {

    Text = 'Time of Day',

    Default = 12,

    Min = 0,

    Max = 24,

    Rounding = 1,

    Callback = function(Value)

        Lighting.ClockTime = Value

    end

})


AtmosphereGroup:AddSlider('Brightness', {

    Text = 'Brightness',

    Default = 2,

    Min = 0,

    Max = 10,

    Rounding = 1,

    Callback = function(Value)

        Lighting.Brightness = Value

    end

})


AtmosphereGroup:AddSlider('FogStart', {

    Text = 'Fog Start',

    Default = 0,

    Min = 0,

    Max = 1000,

    Rounding = 0,

    Callback = function(Value)

        Lighting.FogStart = Value

    end

})


AtmosphereGroup:AddSlider('FogEnd', {

    Text = 'Fog End',

    Default = 1000,

    Min = 100,

    Max = 10000,

    Rounding = 0,

    Callback = function(Value)

        Lighting.FogEnd = Value

    end

})


AtmosphereGroup:AddLabel('Fog Color'):AddColorPicker('FogColorPicker', {

    Default = Color3.fromRGB(192, 192, 192),

    Title = 'Fog Color',

    Callback = function(Value)

        Lighting.FogColor = Value

    end

})


AtmosphereGroup:AddLabel('Ambient'):AddColorPicker('AmbientColorPicker', {

    Default = Color3.fromRGB(128, 128, 128),

    Title = 'Ambient Color',

    Callback = function(Value)

        Lighting.Ambient = Value

    end

})


AtmosphereGroup:AddButton('Reset Atmosphere', function()

    Lighting.ClockTime = 12

    Lighting.Brightness = 2

    Lighting.FogStart = 0

    Lighting.FogEnd = 1000

    Lighting.FogColor = Color3.fromRGB(192, 192, 192)

    Lighting.Ambient = Color3.fromRGB(128, 128, 128)

    Library:Notify('Atmosphere reset!', 2)

end)


-- Effects Group with error handling

local EffectsGroup = Tabs.World:AddLeftGroupbox('Effects')


-- Bloom

local BloomEffect = nil

EffectsGroup:AddToggle('EnableBloom', {

    Text = 'Enable Bloom',

    Default = false,

    Callback = function(Value)

        local success = pcall(function()

            if Value then

                if not BloomEffect then

                    BloomEffect = Instance.new("BloomEffect")

                    BloomEffect.Name = "CustomBloom"

                    BloomEffect.Intensity = 0.5

                    BloomEffect.Size = 24

                    BloomEffect.Threshold = 2

                    BloomEffect.Parent = Lighting

                end

            else

                if BloomEffect then

                    BloomEffect:Destroy()

                    BloomEffect = nil

                end

            end

        end)

        if not success then

            Library:Notify('Bloom failed to apply!', 2)

        end

    end

})


EffectsGroup:AddSlider('BloomIntensity', {

    Text = 'Bloom Intensity',

    Default = 0.5,

    Min = 0,

    Max = 5,

    Rounding = 1,

    Callback = function(Value)

        if BloomEffect then

            BloomEffect.Intensity = Value

        end

    end

})


EffectsGroup:AddSlider('BloomSize', {

    Text = 'Bloom Size',

    Default = 24,

    Min = 0,

    Max = 100,

    Rounding = 0,

    Callback = function(Value)

        if BloomEffect then

            BloomEffect.Size = Value

        end

    end

})


EffectsGroup:AddSlider('BloomThreshold', {

    Text = 'Bloom Threshold',

    Default = 2,

    Min = 0,

    Max = 10,

    Rounding = 1,

    Callback = function(Value)

        if BloomEffect then

            BloomEffect.Threshold = Value

        end

    end

})


EffectsGroup:AddDivider()


-- Motion Blur

local BlurEffect = nil

EffectsGroup:AddToggle('EnableBlur', {

    Text = 'Enable Motion Blur',

    Default = false,

    Callback = function(Value)

        pcall(function()

            if Value then

                if not BlurEffect then

                    BlurEffect = Instance.new("BlurEffect")

                    BlurEffect.Name = "CustomBlur"

                    BlurEffect.Size = 5

                    BlurEffect.Parent = Lighting

                end

            else

                if BlurEffect then

                    BlurEffect:Destroy()

                    BlurEffect = nil

                end

            end

        end)

    end

})


EffectsGroup:AddSlider('BlurSize', {

    Text = 'Blur Size',

    Default = 5,

    Min = 0,

    Max = 50,

    Rounding = 0,

    Callback = function(Value)

        if BlurEffect then

            BlurEffect.Size = Value

        end

    end

})


EffectsGroup:AddDivider()


-- Sun Rays

local SunRaysEffect = nil

EffectsGroup:AddToggle('EnableSunRays', {

    Text = 'Enable Sun Rays',

    Default = false,

    Callback = function(Value)

        pcall(function()

            if Value then

                if not SunRaysEffect then

                    SunRaysEffect = Instance.new("SunRaysEffect")

                    SunRaysEffect.Name = "CustomSunRays"

                    SunRaysEffect.Intensity = 0.25

                    SunRaysEffect.Spread = 1

                    SunRaysEffect.Parent = Lighting

                end

            else

                if SunRaysEffect then

                    SunRaysEffect:Destroy()

                    SunRaysEffect = nil

                end

            end

        end)

    end

})


EffectsGroup:AddSlider('SunRaysIntensity', {

    Text = 'Sun Rays Intensity',

    Default = 0.25,

    Min = 0,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        if SunRaysEffect then

            SunRaysEffect.Intensity = Value

        end

    end

})


EffectsGroup:AddSlider('SunRaysSpread', {

    Text = 'Sun Rays Spread',

    Default = 1,

    Min = 0,

    Max = 10,

    Rounding = 1,

    Callback = function(Value)

        if SunRaysEffect then

            SunRaysEffect.Spread = Value

        end

    end

})


EffectsGroup:AddDivider()


-- Color Correction

local ColorCorrection = nil

EffectsGroup:AddToggle('EnableColorCorrection', {

    Text = 'Color Correction',

    Default = false,

    Callback = function(Value)

        pcall(function()

            if Value then

                if not ColorCorrection then

                    ColorCorrection = Instance.new("ColorCorrectionEffect")

                    ColorCorrection.Name = "CustomColorCorrection"

                    ColorCorrection.Brightness = 0

                    ColorCorrection.Contrast = 0

                    ColorCorrection.Saturation = 0

                    ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)

                    ColorCorrection.Parent = Lighting

                end

            else

                if ColorCorrection then

                    ColorCorrection:Destroy()

                    ColorCorrection = nil

                end

            end

        end)

    end

})


EffectsGroup:AddSlider('CCBrightness', {

    Text = 'Brightness',

    Default = 0,

    Min = -1,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        if ColorCorrection then

            ColorCorrection.Brightness = Value

        end

    end

})


EffectsGroup:AddSlider('CCContrast', {

    Text = 'Contrast',

    Default = 0,

    Min = -1,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        if ColorCorrection then

            ColorCorrection.Contrast = Value

        end

    end

})


EffectsGroup:AddSlider('CCSaturation', {

    Text = 'Saturation',

    Default = 0,

    Min = -1,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        if ColorCorrection then

            ColorCorrection.Saturation = Value

        end

    end

})


EffectsGroup:AddLabel('Tint Color'):AddColorPicker('CCTintColor', {

    Default = Color3.fromRGB(255, 255, 255),

    Title = 'Tint',

    Callback = function(Value)

        if ColorCorrection then

            ColorCorrection.TintColor = Value

        end

    end

})


EffectsGroup:AddButton('Reset All Effects', function()

    pcall(function()

        if BloomEffect then BloomEffect:Destroy() BloomEffect = nil end

        if BlurEffect then BlurEffect:Destroy() BlurEffect = nil end

        if SunRaysEffect then SunRaysEffect:Destroy() SunRaysEffect = nil end

        if ColorCorrection then ColorCorrection:Destroy() ColorCorrection = nil end

    end)

    Library:Notify('All effects reset!', 2)

end)


-- ESP Group

local ESPGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')


ESPGroupBox:AddToggle('EnableESP', {

    Text = 'Enable ESP',

    Default = false,

    Callback = function(Value)

        getgenv().ESP.Enabled = Value

    end

})


ESPGroupBox:AddDropdown("ESPType", {

    Text = 'ESP Type',

    Default = 'Static',

    Values = {'Static', 'Dynamic', 'Ultra FPS'},

    Multi = false,

    Callback = function(Value)

        if Value == "Static" then

            getgenv().ESP.Dynamic = false

            getgenv().ESP.UpdateRate = 1

        elseif Value == "Dynamic" then

            getgenv().ESP.Dynamic = true

            getgenv().ESP.UpdateRate = 0

        elseif Value == "Ultra FPS" then

            getgenv().ESP.Dynamic = false

            getgenv().ESP.UpdateRate = 2

        end

    end

})


ESPGroupBox:AddToggle("ESPNames", {

    Text = "Show Names",

    Default = false,

    Callback = function(Value)

        getgenv().ESP.Names = Value

    end

})


ESPGroupBox:AddToggle("ESPHealthText", {

    Text = "Health Text (150/150)",

    Default = false,

    Callback = function(Value)

        getgenv().ESP.HealthText = Value

    end

})


ESPGroupBox:AddToggle("ESPTracers", {

    Text = "Tracers",

    Default = false,

    Callback = function(Value)

        getgenv().ESP.Tracers = Value

    end

})


ESPGroupBox:AddSlider("ESPMaxDistance", {

    Text = "Max Distance",

    Default = 1000,

    Min = 500,

    Max = 2000,

    Rounding = 0,

    Callback = function(Value)

        getgenv().ESP.MaxDistance = Value

    end

})


ESPGroupBox:AddLabel("ESP Color"):AddColorPicker("ESPColor", {

    Default = Color3.fromRGB(255, 50, 50),

    Title = "Select Color",

    Callback = function(Value)

        getgenv().ESP.Color = Value

    end

})


local FlyGroup = Tabs.Character:AddLeftGroupbox('Flight')


FlyGroup:AddToggle('FlyToggle', {

    Text = 'Enable Fly',

    Default = false,

    Callback = function(Value)

        getgenv().ToggleFly(Value)

    end

})


FlyGroup:AddSlider('FlySpeed', {

    Text = 'Fly Speed',

    Default = 50,

    Min = 10,

    Max = 300,

    Rounding = 0,

    Callback = function(Value)

        getgenv().FlySettings.Speed = Value

    end

})

-- [[ MOVEMENT GROUPBOX ]] --
local MoveGroup = Tabs.Character:AddRightGroupbox('Movement')

-- WalkSpeed Slider
MoveGroup:AddSlider('WalkSpeedSlider', {
    Text = 'Walk Speed',
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        getgenv().WalkSpeedValue = Value
    end
})

-- JumpPower Slider
MoveGroup:AddSlider('JumpPowerSlider', {
    Text = 'Jump Power',
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        getgenv().JumpPowerValue = Value
    end
})

-- Toggle to keep the speed locked (Prevents the game from resetting it)
MoveGroup:AddToggle('LoopMovement', {
    Text = 'Loop WalkSpeed/JumpPower',
    Default = false,
    Callback = function(Value)
        getgenv().LoopMovement = Value
    end
})

-- [[ SETTINGS ]] --
getgenv().WalkSpeedValue = 16
getgenv().MovementEnabled = false

-- [[ THE VELOCITY LOOP ]] --
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    if getgenv().MovementEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if root and hum and hum.MoveDirection.Magnitude > 0 then
                -- We calculate how much "extra" speed to add
                -- If WalkSpeedValue is 50, we add the difference to your current movement
                local targetSpeed = getgenv().WalkSpeedValue
                local currentVelocity = root.Velocity
                local moveDirection = hum.MoveDirection
                
                -- This pushes your character's RootPart manually
                root.CFrame = root.CFrame + (moveDirection * (targetSpeed / 100))
            end
        end)
    end
end)

-- [[ SETTINGS ]] --
getgenv().CrosshairEnabled = false
getgenv().CrosshairPulse = false
getgenv().CrosshairSize = 10
getgenv().CrosshairGap = 5
getgenv().PulseAmount = 5
getgenv().PulseSpeed = 5
getgenv().CrosshairSpinSpeed = 5
getgenv().CrosshairColor = Color3.fromRGB(0, 255, 0) -- Default Green
getgenv().CrosshairThickness = 2

local CurrentRotation = 0
local PulseTimer = 0

-- [[ DRAWING OBJECTS ]] --
local Lines = {}
for i = 1, 4 do
    Lines[i] = Drawing.new("Line")
    Lines[i].Transparency = 1
    Lines[i].Visible = false
    Lines[i].Thickness = getgenv().CrosshairThickness
end

-- [[ THE ANIMATED LOGIC ]] --
local function UpdateCrosshair()
    local Camera = workspace.CurrentCamera
    if not Camera then return end
    
    local Center = Camera.ViewportSize / 2
    
    if getgenv().CrosshairEnabled then
        -- 1. Update Rotation
        CurrentRotation = CurrentRotation + (getgenv().CrosshairSpinSpeed / 100)
        
        -- 2. Update Pulse
        local CalculatedGap = getgenv().CrosshairGap
        if getgenv().CrosshairPulse then
            PulseTimer = PulseTimer + (getgenv().PulseSpeed / 100)
            CalculatedGap = getgenv().CrosshairGap + (math.sin(PulseTimer) * getgenv().PulseAmount)
        end
        
        for i, line in pairs(Lines) do
            line.Visible = true
            line.Color = getgenv().CrosshairColor
            line.Thickness = getgenv().CrosshairThickness
            
            local angle = CurrentRotation + (i * math.pi / 2)
            local cos, sin = math.cos(angle), math.sin(angle)
            
            local startingPoint = Vector2.new(cos * CalculatedGap, sin * CalculatedGap)
            local endingPoint = Vector2.new(cos * (CalculatedGap + getgenv().CrosshairSize), sin * (CalculatedGap + getgenv().CrosshairSize))
            
            line.From = Center + startingPoint
            line.To = Center + endingPoint
        end
    else
        for _, line in pairs(Lines) do 
            line.Visible = false 
        end
    end
end

-- [[ UI SETUP ]] --
local CrossGroup = Tabs.Visual:AddRightGroupbox('Animated Crosshair')

CrossGroup:AddToggle('CrossToggle', {
    Text = 'Enable Crosshair',
    Default = false,
    Callback = function(Value) getgenv().CrosshairEnabled = Value end
})

-- Restored Color Picker
CrossGroup:AddLabel('Color'):AddColorPicker('CrossColor', {
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(Value) getgenv().CrosshairColor = Value end
})

CrossGroup:AddToggle('PulseToggle', {
    Text = 'Enable Pulse (Breathing)',
    Default = false,
    Callback = function(Value) getgenv().CrosshairPulse = Value end
})

CrossGroup:AddSlider('PulseSpd', {
    Text = 'Pulse Speed', Default = 5, Min = 1, Max = 20, Rounding = 1,
    Callback = function(Value) getgenv().PulseSpeed = Value end
})

CrossGroup:AddSlider('PulseAmt', {
    Text = 'Pulse Intensity', Default = 5, Min = 1, Max = 20, Rounding = 0,
    Callback = function(Value) getgenv().PulseAmount = Value end
})

CrossGroup:AddSlider('CrossSpin', {
    Text = 'Spin Speed', Default = 5, Min = 0, Max = 50, Rounding = 1,
    Callback = function(Value) getgenv().CrosshairSpinSpeed = Value end
})

CrossGroup:AddSlider('CrossGapBase', {
    Text = 'Base Gap', Default = 5, Min = 0, Max = 20, Rounding = 0,
    Callback = function(Value) getgenv().CrosshairGap = Value end
})

CrossGroup:AddSlider('CrossThickness', {
    Text = 'Thickness', Default = 2, Min = 1, Max = 5, Rounding = 0,
    Callback = function(Value) getgenv().CrosshairThickness = Value end
})

game:GetService("RunService").RenderStepped:Connect(UpdateCrosshair)

-- Theme & Save Managers

-- [[ CROSSHAIR SETTINGS ]] --
getgenv().CrosshairEnabled = false
getgenv().CrosshairPulse = false
getgenv().RainbowCrosshair = false -- NEW
getgenv().CrosshairSize = 10
getgenv().CrosshairGap = 5
getgenv().PulseAmount = 5
getgenv().PulseSpeed = 5
getgenv().CrosshairSpinSpeed = 5
getgenv().CrosshairColor = Color3.fromRGB(0, 255, 0)
getgenv().CrosshairThickness = 2

local CurrentRotation = 0
local PulseTimer = 0

-- [[ DRAWING OBJECTS ]] --
local Lines = {}
for i = 1, 4 do
    Lines[i] = Drawing.new("Line")
    Lines[i].Transparency = 1
    Lines[i].Visible = false
    Lines[i].Thickness = getgenv().CrosshairThickness
end

-- [[ THE ANIMATED LOGIC ]] --
local function UpdateCrosshair()
    local Camera = workspace.CurrentCamera
    if not Camera or not Library or Library.Unloaded then return end
    
    local Center = Camera.ViewportSize / 2
    
    if getgenv().CrosshairEnabled then
        -- 1. Rainbow Logic
        local FinalColor = getgenv().CrosshairColor
        if getgenv().RainbowCrosshair then
            -- This cycles through the full HSV spectrum every 4 seconds
            FinalColor = Color3.fromHSV(tick() % 4 / 4, 1, 1)
        end

        -- 2. Update Rotation & Pulse
        CurrentRotation = CurrentRotation + (getgenv().CrosshairSpinSpeed / 100)
        
        local CalculatedGap = getgenv().CrosshairGap
        if getgenv().CrosshairPulse then
            PulseTimer = PulseTimer + (getgenv().PulseSpeed / 100)
            CalculatedGap = getgenv().CrosshairGap + (math.sin(PulseTimer) * getgenv().PulseAmount)
        end
        
        for i, line in pairs(Lines) do
            line.Visible = true
            line.Color = FinalColor
            line.Thickness = getgenv().CrosshairThickness
            
            local angle = CurrentRotation + (i * math.pi / 2)
            local cos, sin = math.cos(angle), math.sin(angle)
            
            local startingPoint = Vector2.new(cos * CalculatedGap, sin * CalculatedGap)
            local endingPoint = Vector2.new(cos * (CalculatedGap + getgenv().CrosshairSize), sin * (CalculatedGap + getgenv().CrosshairSize))
            
            line.From = Center + startingPoint
            line.To = Center + endingPoint
        end
    else
        for _, line in pairs(Lines) do line.Visible = false end
    end
end

-- [[ UI SETUP ]] --
local CrossGroup = Tabs.Visual:AddRightGroupbox('Animated Crosshair')

CrossGroup:AddToggle('CrossToggle', {
    Text = 'Enable Crosshair',
    Default = false,
    Callback = function(Value) getgenv().CrosshairEnabled = Value end
})

-- RGB Toggle (The Magic Button)
CrossGroup:AddToggle('RGBTog', {
    Text = 'Rainbow Mode (RGB)',
    Default = false,
    Callback = function(Value) getgenv().RainbowCrosshair = Value end
})

CrossGroup:AddLabel('Static Color'):AddColorPicker('CrossColor', {
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(Value) getgenv().CrosshairColor = Value end
})

CrossGroup:AddToggle('PulseToggle', {
    Text = 'Enable Pulse (Breathing)',
    Default = false,
    Callback = function(Value) getgenv().CrosshairPulse = Value end
})

CrossGroup:AddSlider('CrossSpin', {
    Text = 'Spin Speed', Default = 5, Min = 0, Max = 50, Rounding = 1,
    Callback = function(Value) getgenv().CrosshairSpinSpeed = Value end
})

CrossGroup:AddSlider('CrossGapBase', {
    Text = 'Base Gap', Default = 5, Min = 0, Max = 20, Rounding = 0,
    Callback = function(Value) getgenv().CrosshairGap = Value end
})

game:GetService("RunService").RenderStepped:Connect(UpdateCrosshair)

-- [[ SNOW SETTINGS ]] --
getgenv().SnowEnabled = false
getgenv().SnowColor = Color3.fromRGB(255, 255, 255)
getgenv().SnowAmount = 50
getgenv().SnowSpeed = 2

local Snowflakes = {}

-- Create the snowflakes
for i = 1, getgenv().SnowAmount do
    local flake = Drawing.new("Circle")
    flake.Visible = false
    flake.Filled = true
    flake.Thickness = 0
    flake.Radius = math.random(1, 3)
    flake.Transparency = math.random(4, 8) / 10
    
    -- Random starting position
    local Screen = workspace.CurrentCamera.ViewportSize
    Snowflakes[i] = {
        Obj = flake,
        Pos = Vector2.new(math.random(0, Screen.X), math.random(0, Screen.Y)),
        Vel = math.random(1, 3) -- Random fall speed per flake
    }
end

-- [[ THE SNOW LOOP ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    local Screen = workspace.CurrentCamera.ViewportSize
    
    for i, data in pairs(Snowflakes) do
        if getgenv().SnowEnabled then
            -- Move flake down
            data.Pos = data.Pos + Vector2.new(0, data.Vel * getgenv().SnowSpeed)
            
            -- Reset if it goes off screen
            if data.Pos.Y > Screen.Y then
                data.Pos = Vector2.new(math.random(0, Screen.X), -10)
            end
            
            data.Obj.Position = data.Pos
            data.Obj.Color = getgenv().SnowColor
            data.Obj.Visible = true
        else
            data.Obj.Visible = false
        end
    end
end)

-- [[ UI ADDITION ]] --
local VisualsMisc = Tabs.Visual:AddRightGroupbox('Screen Effects')

VisualsMisc:AddToggle('SnowTog', {
    Text = 'Enable Snow Particles',
    Default = false,
    Callback = function(V) getgenv().SnowEnabled = V end
})

VisualsMisc:AddLabel('Snow Color'):AddColorPicker('SnowCol', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(V) getgenv().SnowColor = V end
})

VisualsMisc:AddSlider('SnowSpd', {
    Text = 'Snow Fall Speed', Default = 2, Min = 1, Max = 10, Rounding = 1,
    Callback = function(V) getgenv().SnowSpeed = V end
})

-- [[ FRAME & WATERMARK SETTINGS ]] --
getgenv().WatermarkEnabled = false
getgenv().BorderGlowEnabled = false
getgenv().BorderThickness = 2

-- [[ DRAWING OBJECTS ]] --
local WatermarkBase = Drawing.new("Square")
local WatermarkText = Drawing.new("Text")

local BorderLines = {
    Top = Drawing.new("Line"),
    Bottom = Drawing.new("Line"),
    Left = Drawing.new("Line"),
    Right = Drawing.new("Line")
}

-- [[ THE ANIMATION LOOP ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    if not Library or Library.Unloaded then return end
    local Screen = workspace.CurrentCamera.ViewportSize
    
    -- 1. Sync Color with Rainbow Crosshair
    local SyncColor = getgenv().CrosshairColor
    if getgenv().RainbowCrosshair then
        SyncColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end

    -- 2. Border Glow Logic
    if getgenv().BorderGlowEnabled then
        local B = BorderLines
        local T = getgenv().BorderThickness
        
        B.Top.Visible = true
        B.Top.Color = SyncColor
        B.Top.Thickness = T
        B.Top.From = Vector2.new(0, 0)
        B.Top.To = Vector2.new(Screen.X, 0)

        B.Bottom.Visible = true
        B.Bottom.Color = SyncColor
        B.Bottom.Thickness = T
        B.Bottom.From = Vector2.new(0, Screen.Y)
        B.Bottom.To = Vector2.new(Screen.X, Screen.Y)

        B.Left.Visible = true
        B.Left.Color = SyncColor
        B.Left.Thickness = T
        B.Left.From = Vector2.new(0, 0)
        B.Left.To = Vector2.new(0, Screen.Y)

        B.Right.Visible = true
        B.Right.Color = SyncColor
        B.Right.Thickness = T
        B.Right.From = Vector2.new(Screen.X, 0)
        B.Right.To = Vector2.new(Screen.X, Screen.Y)
    else
        for _, l in pairs(BorderLines) do l.Visible = false end
    end

    -- 3. Watermark Logic
    if getgenv().WatermarkEnabled then
        local FPS = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        local Ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        local Time = os.date("%X")
        
        local Content = string.format("Xorfhook v2 | %s | FPS: %d | Ping: %dms", Time, FPS, Ping)
        
        WatermarkText.Visible = true
        WatermarkText.Center = false
        WatermarkText.Outline = true
        WatermarkText.Font = 2
        WatermarkText.Size = 13
        WatermarkText.Color = Color3.fromRGB(255, 255, 255)
        WatermarkText.Text = Content
        WatermarkText.Position = Vector2.new(Screen.X - WatermarkText.TextBounds.X - 20, 15)

        WatermarkBase.Visible = true
        WatermarkBase.Color = Color3.fromRGB(15, 15, 15)
        WatermarkBase.Filled = true
        WatermarkBase.Transparency = 0.7
        WatermarkBase.Size = Vector2.new(WatermarkText.TextBounds.X + 20, 25)
        WatermarkBase.Position = Vector2.new(Screen.X - WatermarkText.TextBounds.X - 30, 10)
    else
        WatermarkBase.Visible = false
        WatermarkText.Visible = false
    end
end)

-- [[ UI ADDITION ]] --
local HUDGroup = Tabs.Visual:AddRightGroupbox('HUD & Overlays')

HUDGroup:AddToggle('WatermarkTog', {
    Text = 'Enable Watermark',
    Default = false,
    Callback = function(V) getgenv().WatermarkEnabled = V end
})

HUDGroup:AddToggle('BorderTog', {
    Text = 'Enable Screen Border',
    Default = false,
    Callback = function(V) getgenv().BorderGlowEnabled = V end
})

HUDGroup:AddSlider('BorderThick', {
    Text = 'Border Thickness', Default = 2, Min = 1, Max = 10, Rounding = 0,
    Callback = function(V) getgenv().BorderThickness = V end
})

-- [[ CHAMS SETTINGS ]] --
getgenv().ChamsEnabled = false
getgenv().ChamsSyncRGB = false
getgenv().ChamsFillColor = Color3.fromRGB(255, 0, 0)
getgenv().ChamsOutlineColor = Color3.fromRGB(255, 255, 255)
getgenv().ChamsFillTransparency = 0.5
getgenv().ChamsOutlineTransparency = 0

local function ApplyChams(player)
    local function UpdateChams()
        if not player.Character then return end
        
        local highlight = player.Character:FindFirstChild("XorfHighlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "XorfHighlight"
            highlight.Parent = player.Character
        end

        if getgenv().ChamsEnabled then
            highlight.Enabled = true
            highlight.Adornee = player.Character
            
            -- RGB Sync Logic
            local Fill = getgenv().ChamsFillColor
            if getgenv().ChamsSyncRGB and getgenv().RainbowCrosshair then
                Fill = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            end
            
            highlight.FillColor = Fill
            highlight.OutlineColor = getgenv().ChamsOutlineColor
            highlight.FillTransparency = getgenv().ChamsFillTransparency
            highlight.OutlineTransparency = getgenv().ChamsOutlineTransparency
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        else
            highlight.Enabled = false
        end
    end

    RunService.RenderStepped:Connect(UpdateChams)
end

-- Apply to everyone
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        ApplyChams(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    ApplyChams(player)
end)

-- [[ UI ADDITION ]] --
local ChamGroup = Tabs.Visual:AddLeftGroupbox('Neon Chams')

ChamGroup:AddToggle('ChamTog', {
    Text = 'Enable Neon Chams',
    Default = false,
    Callback = function(V) getgenv().ChamsEnabled = V end
})

ChamGroup:AddToggle('ChamRGB', {
    Text = 'Sync Chams with RGB',
    Default = false,
    Callback = function(V) getgenv().ChamsSyncRGB = V end
})

ChamGroup:AddSlider('ChamTrans', {
    Text = 'Fill Transparency', Default = 0.5, Min = 0, Max = 1, Rounding = 1,
    Callback = function(V) getgenv().ChamsFillTransparency = V end
})

ChamGroup:AddLabel('Cham Color'):AddColorPicker('ChamCol', {
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(V) getgenv().ChamsFillColor = V end
})

-- [[ 1. DAMAGE POP-UP SETTINGS ]] --
getgenv().DamagePopups = false
getgenv().DamageRGB = false
getgenv().DamageColor = Color3.fromRGB(255, 255, 0) -- Default Neon Yellow

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- [[ UPDATED SNAPPY DAMAGE LOGIC ]] --
local function CreateDamageTag(targetPart, amount)
    local text = Drawing.new("Text")
    text.Visible = true
    text.Size = 20 -- Slightly smaller for a cleaner look
    text.Center = true
    text.Outline = true
    text.Font = 2 
    text.Text = tostring(math.floor(amount))
    
    local startColor = getgenv().DamageColor
    if getgenv().DamageRGB then
        startColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
    text.Color = startColor

    task.spawn(function()
        -- STARTING OFFSET: 0.8 is right above the hair/hat
        local currentOffset = 0.8 
        
        for i = 1, 40 do -- 40 frames is roughly 0.6 seconds
            if not targetPart or not targetPart.Parent then break end
            
            -- CLIMB SPEED: Very slow crawl so it stays "with" them
            currentOffset = currentOffset + 0.03 
            
            local headPos = targetPart.Position + Vector3.new(0, currentOffset, 0)
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(headPos)
            
            if onScreen then
                text.Position = Vector2.new(screenPos.X, screenPos.Y)
                
                -- Fade logic (starts fading halfway through)
                if i > 20 then
                    text.Transparency = 1 - ((i - 20) / 20)
                end
                
                if getgenv().DamageRGB then
                    text.Color = Color3.fromHSV((tick() + i/100) % 5 / 5, 1, 1)
                end
            else
                text.Visible = false
                break
            end
            RunService.RenderStepped:Wait()
        end
        text:Destroy()
    end)
end

-- [[ 2. HEALTH TRACKER ]] --
local EnemyHealths = {}

RunService.Heartbeat:Connect(function()
    if not getgenv().DamagePopups then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local hum = player.Character.Humanoid
            local name = player.Name
            
            -- Initialize health if they just joined/spawned
            if not EnemyHealths[name] then
                EnemyHealths[name] = hum.Health
            end
            
            -- If health dropped, show the pop-up
            if hum.Health < EnemyHealths[name] then
                local damageTaken = EnemyHealths[name] - hum.Health
                local head = player.Character:FindFirstChild("Head")
                if head then
                    CreateDamageTag(head.Position + Vector3.new(0, 2, 0), damageTaken)
                end
            end
            
            EnemyHealths[name] = hum.Health
        end
    end
end)

-- [[ 3. UI CONTROLS ]] --
-- Add this to your "Combat Effects" or "Visuals" Groupbox
local CombatVis = Tabs.Visual:AddRightGroupbox('Damage Feedback')

CombatVis:AddToggle('PopTog', {
    Text = 'Enable Damage Pop-ups',
    Default = false,
    Callback = function(v) getgenv().DamagePopups = v end
})

CombatVis:AddToggle('PopRGB', {
    Text = 'RGB Damage Numbers',
    Default = false,
    Callback = function(v) getgenv().DamageRGB = v end
})

CombatVis:AddLabel('Static Color'):AddColorPicker('PopCol', {
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(v) getgenv().DamageColor = v end
})

-- [[ 1. SMART HITLOG SETTINGS ]] --
getgenv().HitlogEnabled = false
local HitlogHealths = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- [[ 2. THE SMART MONITOR ]] --
task.spawn(function()
    while task.wait(0.05) do 
        if getgenv().HitlogEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hum = player.Character:FindFirstChild("Humanoid")
                    local head = player.Character:FindFirstChild("Head")
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    local name = player.Name
                    
                    if hum and head and root then
                        -- Initialize health
                        if not HitlogHealths[name] then
                            HitlogHealths[name] = hum.Health
                        end
                        
                        -- If they took damage...
                        if hum.Health < HitlogHealths[name] then
                            local dmg = HitlogHealths[name] - hum.Health
                            
                            -- [[ THE "HEAD VS BODY" CHECK ]] --
                            local distToHead = (Mouse.Hit.p - head.Position).Magnitude
                            local distToRoot = (Mouse.Hit.p - root.Position).Magnitude
                            local mouseFocusDist = math.min(distToHead, distToRoot)

                            -- Only show if WE were aiming at them (within 12 studs)
                            if mouseFocusDist < 12 then 
                                -- If we were closer to the head than the chest, it's a Headshot
                                local isHeadshot = distToHead < distToRoot
                                local zone = isHeadshot and "HEAD" or "Body"
                                local colorTag = isHeadshot and " [!!!]" or ""
                                
                                Library:Notify(string.format("[%s] Hit %s for %s%s", 
                                    zone, 
                                    player.DisplayName, 
                                    math.floor(dmg),
                                    colorTag
                                ), 1.5)
                            end
                        end
                        
                        HitlogHealths[name] = hum.Health
                    end
                end
            end
        end
    end
end)

-- [[ UI TOGGLE ]] --
-- Put this in your Visuals or Combat tab
local LogGroup = Tabs.Visual:AddRightGroupbox('Hitlogs')
LogGroup:AddToggle('HitlogTog', {
    Text = 'Enable Hit Notifications',
    Default = false,
    Callback = function(v) getgenv().HitlogEnabled = v end
})

-- [[ 1. THE MAPPING TABLE ]] --
local DeviceMap = {
    ["Mobile"] = "Touch",
    ["Controller"] = "Gamepad",
    ["PC"] = "MouseKeyboard",
    ["VR"] = "VR"
}

local function spoofDevice(device)
    local ReplicatedStorage = game:GetService('ReplicatedStorage') 
    ReplicatedStorage.Remotes.Replication.Fighter.SetControls:FireServer(device)
end

-- The variable your spoofer actually uses
getgenv().spoofedDevice = "MouseKeyboard" -- Default

-- [[ 2. THE UI DROPDOWN ]] --
local SpooferGroup = Tabs.Misc:AddLeftGroupbox('System Spoofer')

SpooferGroup:AddDropdown('DeviceSelector', {
    Text = 'Spoof Device As:',
    Default = 'PC', 
    Values = { 'PC', 'Mobile', 'Controller', 'Console', 'VR' }, -- Friendly Names
    Callback = function(Value)
        -- Look up the 'Friendly Name' in our map to get the 'Code Name'
        local internalName = DeviceMap[Value]
        
        getgenv().spoofedDevice = internalName
        
        Library:Notify("Device spoofed as: " .. internalName, 2)
        spoofDevice(getgenv().spoofedDevice)
    end
})

-- [[ 1. NOCLIP SETTINGS ]] --
getgenv().NoclipEnabled = false

-- [[ 2. THE NOCLIP LOOP ]] --
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- [[ 3. UI TOGGLE ]] --
local MoveGroup = Tabs.Visual:AddLeftGroupbox('Movement') -- Or whatever tab you prefer

MoveGroup:AddToggle('Nocliptog', {
    Text = 'Noclip (Walk Through Walls)',
    Default = false,
    Callback = function(v) 
        getgenv().NoclipEnabled = v 
        if v then
            Library:Notify("Noclip Enabled - Be careful near spawn!", 3)
        else
            Library:Notify("Noclip Disabled", 2)
        end
    end
})

-- [[ 1. SETTINGS ]] --
getgenv().CustomAnimEnabled = false
getgenv().CustomAnimID = "92281817840531"
getgenv().CustomAnimSpeed = 1
local CurrentTrack = nil

-- [[ 2. THE EMOTE UNPACKER ]] --
local function GetTrueAnimationID(assetId)
    local id = tostring(assetId):gsub("%D", "")
    -- Try to fetch the animation object from the catalog asset
    local success, asset = pcall(function() 
        return game:GetObjects("rbxassetid://" .. id)[1] 
    end)

    if success and asset then
        -- If it's an Animation object, return its ID
        if asset:IsA("Animation") then
            return asset.AnimationId
        end
        -- If it's a Folder/Model (Emote Bundle), find the Animation inside
        local deepAnim = asset:FindFirstChildWhichIsA("Animation", true)
        if deepAnim then
            return deepAnim.AnimationId
        end
    end
    -- Fallback to the raw ID if unpacking fails
    return "rbxassetid://" .. id
end

-- [[ 3. THE PLAY LOGIC ]] --
local function playCustomAnimation()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum or not getgenv().CustomAnimEnabled then return end

    -- Stop all current tracks (clears frozen states)
    local animator = hum:FindFirstChildOfClass("Animator") or hum
    for _, track in next, animator:GetPlayingAnimationTracks() do
        track:Stop(0)
    end

    -- Get the "True" ID from the Catalog Asset
    local finalID = GetTrueAnimationID(getgenv().CustomAnimID)
    local animation = Instance.new("Animation")
    animation.AnimationId = finalID

    -- Load and Play
    local success, track = pcall(function() return animator:LoadAnimation(animation) end)
    
    if success and track then
        CurrentTrack = track
        CurrentTrack.Priority = Enum.AnimationPriority.Action4
        CurrentTrack.Looped = true
        CurrentTrack:Play()
        CurrentTrack:AdjustSpeed(getgenv().CustomAnimSpeed)
        
        -- Auto-restart if the game tries to stop it
        CurrentTrack.Stopped:Connect(function()
            if getgenv().CustomAnimEnabled and CurrentTrack == track then
                playCustomAnimation()
            end
        end)
    end
end

-- [[ 4. UI INTEGRATION ]] --
local AnimGroup = Tabs.Character:AddRightGroupbox('Animation Overrider')

AnimGroup:AddToggle('AnimToggle', {
    Text = 'Enable Custom Animation',
    Default = false,
    Callback = function(v) 
        getgenv().CustomAnimEnabled = v 
        if v then 
            playCustomAnimation() 
        elseif CurrentTrack then 
            CurrentTrack:Stop() 
            CurrentTrack = nil
        end
    end
})

AnimGroup:AddInput('AnimIDInput', {
    Text = 'Emote ID',
    Default = '92281817840531',
    Callback = function(v)
        getgenv().CustomAnimID = v
        if getgenv().CustomAnimEnabled then playCustomAnimation() end
    end
})

AnimGroup:AddSlider('AnimSpeedSlider', {
    Text = 'Anim Speed',
    Default = 1, Min = 0, Max = 10, Rounding = 1,
    Callback = function(v)
        getgenv().CustomAnimSpeed = v
        if CurrentTrack then CurrentTrack:AdjustSpeed(v) end
    end
})

-- Respawn logic
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(2)
    if getgenv().CustomAnimEnabled then playCustomAnimation() end
end)

-- [[ WALLBANG / TELEPORT SETTINGS ]] --
getgenv().WallbangEnabled = false
getgenv().TargetPlayer = "None"
getgenv().WallbangHeight = 15

-- [[ TARGET DROPDOWN LOGIC ]] --
local function GetPlayerList()
    local tbl = {"None"}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer then
            table.insert(tbl, v.Name)
        end
    end
    return tbl
end

local WallGroup = Tabs.Character:AddRightGroupbox('Wallbang Assist')

WallGroup:AddDropdown('TargetSelector', {
    Text = 'Select Target',
    Default = 'None',
    Values = GetPlayerList(),
    Callback = function(Value) getgenv().TargetPlayer = Value end
})

-- Button to refresh player list
WallGroup:AddButton('Refresh Players', function()
    Options.TargetSelector:SetValues(GetPlayerList())
end)

WallGroup:AddToggle('WBToggle', {
    Text = 'Enable Overhead Wallbang',
    Default = false,
    Callback = function(Value) getgenv().WallbangEnabled = Value end
})

WallGroup:AddSlider('WBHeight', {
    Text = 'Teleport Height',
    Default = 15, Min = 5, Max = 50, Rounding = 0,
    Callback = function(Value) getgenv().WallbangHeight = Value end
})

-- [[ REFINED TELEPORT LOOP WITH AIM-DOWN ]] --
game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().WallbangEnabled and getgenv().TargetPlayer ~= "None" then
        local TargetObj = game:GetService("Players"):FindFirstChild(getgenv().TargetPlayer)
        local MyChar = game:GetService("Players").LocalPlayer.Character
        local Camera = workspace.CurrentCamera
        
        if TargetObj and TargetObj.Character and MyChar then
            local TargetRoot = TargetObj.Character:FindFirstChild("HumanoidRootPart")
            local MyRoot = MyChar:FindFirstChild("HumanoidRootPart")
            local MyHum = MyChar:FindFirstChildOfClass("Humanoid")
            
            if MyRoot and TargetRoot then
                -- 1. TELEPORT: Stay above them
                local TargetPos = TargetRoot.Position
                local NewPos = TargetPos + Vector3.new(0, getgenv().WallbangHeight, 0)
                
                -- 2. ROTATION: Force character to look DOWN at target
                -- CFrame.lookAt(Position, PointToLookAt)
                MyRoot.CFrame = CFrame.lookAt(NewPos, TargetPos)
                
                -- 3. VELOCITY: Zero out movement so you don't float away
                MyRoot.Velocity = Vector3.new(0, 0, 0)
                
                -- 4. CAMERA: Snap your camera to look at them (optional, helpful for shooting)
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, TargetPos)

                -- 5. FIX: Stop the character from "Righting" itself
                if MyHum then
                    MyHum.AutoRotate = false -- Disables the game forcing you to stand upright
                end
            end
        end
    else
        -- Re-enable rotation when wallbang is off
        local MyChar = game:GetService("Players").LocalPlayer.Character
        if MyChar and MyChar:FindFirstChildOfClass("Humanoid") then
            MyChar:FindFirstChildOfClass("Humanoid").AutoRotate = true
        end
    end
end)

-- [[ GUN TP SETTINGS ]] --
getgenv().GunTPEnabled = false
getgenv().GunTPTarget = "None"
getgenv().GunTPHeight = 10 -- How high above their head the bullets spawn

-- Helper to get fresh player list
local function GetPlayerList()
    local tbl = {"None"}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer then
            table.insert(tbl, v.Name)
        end
    end
    return tbl
end

local RageGroup = Tabs.Character:AddLeftGroupbox('Rage: Gun Manipulation')

-- Dropdown to choose the victim
local TargetDrop = RageGroup:AddDropdown('GunTPTargetDrop', {
    Values = GetPlayerList(),
    Default = 1,
    Multi = false,
    Text = 'Select Gun TP Target',
    Callback = function(Value) getgenv().GunTPTarget = Value end
})

-- Refresh button so the dropdown stays updated
RageGroup:AddButton('Refresh Player List', function()
    TargetDrop:SetValues(GetPlayerList())
end)

RageGroup:AddToggle('GunTPToggle', {
    Text = 'Invisible Wallbang (Gun TP)',
    Default = false,
    Callback = function(Value) getgenv().GunTPEnabled = Value end
})

RageGroup:AddSlider('GunTPHeightSlider', {
    Text = 'Bullet Origin Height',
    Default = 10, Min = 2, Max = 30, Rounding = 0,
    Callback = function(Value) getgenv().GunTPHeight = Value end
})

-- [[ THE HEARTBEAT LOOP FOR METHOD 1 (Floating Tool) ]] --
game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().GunTPEnabled and getgenv().GunTPTarget ~= "None" then
        local TargetObj = game:GetService("Players"):FindFirstChild(getgenv().GunTPTarget)
        local MyChar = game:GetService("Players").LocalPlayer.Character
        local Tool = MyChar and MyChar:FindFirstChildOfClass("Tool")

        if TargetObj and TargetObj.Character and Tool then
            local TargetHead = TargetObj.Character:FindFirstChild("Head")
            local Handle = Tool:FindFirstChild("Handle") or Tool:FindFirstChildOfClass("Part")
            
            if TargetHead and Handle then
                -- Teleports just the gun/handle above the specific player selected
                Handle.CFrame = TargetHead.CFrame * CFrame.new(0, getgenv().GunTPHeight, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                
                -- Anti-Gravity for the tool so it doesn't fall
                if Handle:IsA("BasePart") then
                    Handle.Velocity = Vector3.new(0, 0, 0)
                    Handle.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)

-- [[ DAGGER AURA SETTINGS ]] --
getgenv().DaggerAuraEnabled = false
getgenv().DaggerTarget = "None"

local RageMeleeGroup = Tabs.Character:AddLeftGroupbox('Rage: Melee Aura')

-- 1. Helper function to get fresh names
local function UpdatePlayerList()
    local p = {"None"}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer then
            table.insert(p, v.Name)
        end
    end
    return p
end

-- 2. The Dropdown
local MeleeTargetDrop = RageMeleeGroup:AddDropdown('MeleeTarget', {
    Values = UpdatePlayerList(),
    Default = 1,
    Text = 'Melee Target',
    Callback = function(v) getgenv().DaggerTarget = v end
})

-- 3. THE REFRESH BUTTON (The missing piece!)
RageMeleeGroup:AddButton('Refresh Player List', function()
    local newList = UpdatePlayerList()
    Options.MeleeTarget:SetValues(newList) -- This forces Linoria to update the UI
    Library:Notify("Player list updated!")
end)

RageMeleeGroup:AddDivider()

RageMeleeGroup:AddToggle('DaggerAura', {
    Text = 'Dagger Kill Aura',
    Default = false,
    Callback = function(v) getgenv().DaggerAuraEnabled = v end
})

-- 4. The "Blink" Feature (For extra rage)
RageMeleeGroup:AddButton('Blink Behind Target', function()
    local target = game.Players:FindFirstChild(getgenv().DaggerTarget)
    local lp = game.Players.LocalPlayer
    if target and target.Character and lp.Character then
        local root = lp.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if root and tRoot then
            -- Teleports you 3 studs behind them facing their back
            root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3) 
            Library:Notify("Blinked to " .. target.Name)
        end
    end
end)

-- [[ XORFHOOK RAGE V1 | INTEGRATED GHOST BLINK ]] --
local UIS = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local RS = game:GetService("RunService")
local lp = plrs.LocalPlayer
local cam = workspace.CurrentCamera

-- [[ SETTINGS ]] --
getgenv().BlinkDelay = 0.1
getgenv().BlinkAttackDivisor = 2.5
getgenv().BlinkOffsetX = 0
getgenv().BlinkOffsetY = 0.5
getgenv().BlinkOffsetZ = 3
getgenv().BlinkTarget = "None"
getgenv().AutoTargetBlink = false
getgenv().GhostHideEnabled = false -- Toggle this via UI
getgenv().IsBlinking = false       -- Internal flag

-- [[ 1. THE GHOST HIDE ENGINE ]] --
-- This loop runs forever in the background
task.spawn(function()
    while task.wait() do 
        if getgenv().GhostHideEnabled and not getgenv().IsBlinking then
            pcall(function()
                local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Randomizes slightly around -500 to stay unhittable
                    hrp.CFrame = CFrame.new(hrp.Position.X + math.random(-2,2), -500, hrp.Position.Z + math.random(-2,2))
                end
            end)
        end
    end
end)

-- [[ 2. THE BLINK STRIKE LOGIC ]] --
UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.P then
        -- PAUSE VOID HIDE
        getgenv().IsBlinking = true 
        
        local victimPart = nil
        
        -- Auto-Target Detection
        if getgenv().AutoTargetBlink then
            local closestTarget = nil
            local shortestDistance = getgenv().FOV or 180 
            for _, player in pairs(plrs:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("Humanoid") then
                    local head = player.Character:FindFirstChild("HeadHB") or player.Character:FindFirstChild("Head")
                    if head then
                        local pos, onScreen = cam:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local magnitude = (Vector2.new(pos.X, pos.Y) - (cam.ViewportSize / 2)).Magnitude
                            if magnitude < shortestDistance then
                                closestTarget = head
                                shortestDistance = magnitude
                            end
                        end
                    end
                end
            end
            victimPart = closestTarget
        end

        -- Dropdown Fallback
        if not victimPart and getgenv().BlinkTarget ~= "None" then
            local p = plrs:FindFirstChild(getgenv().BlinkTarget)
            victimPart = p and p.Character and (p.Character:FindFirstChild("HeadHB") or p.Character:FindFirstChild("Head"))
        end
        
        -- Mouse Fallback
        if not victimPart then
            local mouse = lp:GetMouse()
            local target = mouse.Target
            if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
                victimPart = target.Parent:FindFirstChild("HeadHB") or target.Parent:FindFirstChild("Head")
            end
        end

        -- Execution
        local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if victimPart and myRoot then
            local tRoot = victimPart.Parent:FindFirstChild("HumanoidRootPart")
            if tRoot then
                local oldCF = myRoot.CFrame
                local isLocking = true
                
                -- Camera Lock
                local cameraConnection = RS.RenderStepped:Connect(function()
                    if isLocking and victimPart and victimPart.Parent then
                        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, victimPart.Position)
                    end
                end)

                -- Snap to Target
                local behindPos = tRoot.CFrame * CFrame.new(getgenv().BlinkOffsetX, getgenv().BlinkOffsetY, getgenv().BlinkOffsetZ)
                myRoot.CFrame = CFrame.lookAt(behindPos.Position, tRoot.Position)

                -- Attack Sequence
                local totalTime = getgenv().BlinkDelay
                task.wait(totalTime / getgenv().BlinkAttackDivisor)
                mouse1press()
                task.wait(totalTime - (totalTime / getgenv().BlinkAttackDivisor))
                mouse1release()

                -- Clean up and return
                isLocking = false
                cameraConnection:Disconnect()
                myRoot.CFrame = oldCF
            end
        end
        
        -- RESUME VOID HIDE
        getgenv().IsBlinking = false 
    end
end)

-- [[ UI ELEMENTS ]] --
local BlinkGroup = Tabs.Main:AddRightGroupbox('Rage v1')

BlinkGroup:AddToggle('AutoBlinkTarget', {
    Text = 'Auto-Target Closest',
    Default = false,
    Callback = function(V) getgenv().AutoTargetBlink = V end
})

local PlayerDropdown = BlinkGroup:AddDropdown('BlinkTargetSelector', {
    Text = 'Blink Target',
    Default = 'None',
    Values = { 'None' },
    Callback = function(Value) getgenv().BlinkTarget = Value end
})

task.spawn(function()
    while task.wait(1) do
        local PlayerList = { "None" }
        for _, player in pairs(plrs:GetPlayers()) do
            if player ~= lp then table.insert(PlayerList, player.Name) end
        end
        PlayerDropdown:SetValues(PlayerList)
    end
end)

BlinkGroup:AddSlider('BlinkDelay', {
    Text = 'Total Blink Duration',
    Default = 0.1, Min = 0.01, Max = 0.5, Rounding = 2,
    Callback = function(V) getgenv().BlinkDelay = V end
})

BlinkGroup:AddSlider('BlinkDivisor', {
    Text = 'Attack Timing',
    Default = 2.5, Min = 1.1, Max = 5, Rounding = 1,
    Callback = function(V) getgenv().BlinkAttackDivisor = V end
})

BlinkGroup:AddSlider('BlinkOffX', {
    Text = 'Side Offset',
    Default = 0, Min = -5, Max = 5, Rounding = 1,
    Callback = function(V) getgenv().BlinkOffsetX = V end
})

BlinkGroup:AddSlider('BlinkOffY', {
    Text = 'Height Offset',
    Default = 0.5, Min = -2, Max = 5, Rounding = 1,
    Callback = function(V) getgenv().BlinkOffsetY = V end
})

BlinkGroup:AddSlider('BlinkOffZ', {
    Text = 'Distance Behind',
    Default = 3, Min = 1, Max = 10, Rounding = 1,
    Callback = function(V) getgenv().BlinkOffsetZ = V end
})

-- [[ ANTI-AIM / HEAD HIDER ]] --
local AAGroup = Tabs.Main:AddLeftGroupbox('Anti-Aim')

AAGroup:AddToggle('AAToggle', {
    Text = 'Enable Anti-Aim',
    Default = false,
    Callback = function(V) getgenv().AntiAimEnabled = V end
})

AAGroup:AddDropdown('AAMode', {
    Text = 'AA Mode',
    Default = 'Down',
    Values = { 'Down', 'Spin', 'Back' },
    Callback = function(V) getgenv().AntiAimMode = V end
})

RS.Stepped:Connect(function()
    if getgenv().AntiAimEnabled and lp.Character then
        local neck = lp.Character:FindFirstChild("Neck", true)
        if neck then
            if getgenv().AntiAimMode == "Down" then
                neck.C0 = CFrame.new(neck.C0.Position) * CFrame.Angles(math.rad(-110), 0, math.rad(180))
            elseif getgenv().AntiAimMode == "Spin" then
                neck.C0 = CFrame.new(neck.C0.Position) * CFrame.Angles(0, math.rad(tick() * 1500 % 360), 0)
            elseif getgenv().AntiAimMode == "Back" then
                neck.C0 = CFrame.new(neck.C0.Position) * CFrame.Angles(math.rad(110), 0, 0)
            end
        end
    end
end)

-- [[ AUTO-LOADER SYSTEM ]] --
local UIS = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

-- The script to be queued (Your Loader URL)
local loaderScript = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xorfiireimagined/xorfhookreimagined/refs/heads/main/loader.luau"))()'

-- Function to handle the queue logic
local function QueueScript()
    if getgenv().AutoLoadEnabled then
        local success, err = pcall(function()
            if queue_on_teleport then
                queue_on_teleport(loaderScript)
            elseif syn and syn.queue_on_teleport then
                syn.queue_on_teleport(loaderScript)
            elseif fluxus and fluxus.queue_on_teleport then
                fluxus.queue_on_teleport(loaderScript)
            end
        end)
        if success then 
            print("[Xorfhook] Teleport Queue Armed.") 
        end
    end
end

-- Watch for teleports (Matches starting/ending)
lp.OnTeleport:Connect(QueueScript)

-- [[ UI TOGGLE ]] --
local SettingsTab = Tabs.Settings:AddLeftGroupbox('Script Management')

SettingsTab:AddToggle('AutoLoadToggle', {
    Text = 'Auto-Load on Match',
    Default = false,
    Tooltip = 'Automatically re-loads Xorfhook when you join a match or return to lobby.',
    Callback = function(Value)
        getgenv().AutoLoadEnabled = Value
        if Value then
            QueueScript() -- Arm it immediately if they turn it on
            print("[Xorfhook] Auto-Load Enabled")
        else
            print("[Xorfhook] Auto-Load Disabled")
        end
    end
})

-- [[ INDEPENDENT VOID SPAM / GHOST HIDE ]] --
getgenv().GhostHideEnabled = false
getgenv().IsBlinking = false -- Connect this to your 'P' key script

task.spawn(function()
    while task.wait() do -- Fast loop for absolute stay
        if getgenv().GhostHideEnabled and not getgenv().IsBlinking then
            pcall(function()
                local char = game:GetService("Players").LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    -- Randomizes coordinates slightly around -500 to stay unhittable
                    local x = hrp.Position.X + math.random(-5, 5)
                    local z = hrp.Position.Z + math.random(-5, 5)
                    local y = -500
                    
                    hrp.CFrame = CFrame.new(x, y, z)
                end
            end)
        end
    end
end)

-- [[ UI TOGGLE ]] --
BlinkGroup:AddToggle('GhostHideToggle', {
    Text = 'Void Spam',
    Default = false,
    Tooltip = 'Teleports YOU to -500 rapidly. Pauses when you blink.',
    Callback = function(Value)
        getgenv().GhostHideEnabled = Value
    end
})

ThemeManager:SetLibrary(Library)

SaveManager:SetLibrary(Library)


SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })


ThemeManager:SetFolder('xorfhook/v2')

SaveManager:SetFolder('xorfhook/v2/rivals')


SaveManager:BuildConfigSection(Tabs['Settings'])

ThemeManager:ApplyToTab(Tabs['Settings'])


SaveManager:LoadAutoloadConfig() 
