local _0xAA2C = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local _0xB5A4 = _0xAA2C:CreateWindow({
    Name = "🌮 - TakoTori",
    Icon = 0,
    LoadingTitle = "TakoTori 🌮",
    LoadingSubtitle = "For Forsaken",
    Theme = "AmberGlow",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "TakoTori"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"Hello"}
    }
})

local _0xD17A = _0xB5A4:CreateTab("Change-Log", 4483362458)
local _0x44B1 = _0xD17A:CreateLabel("wip there isnt anything to talk about", 4483362458, Color3.fromRGB(50, 20, 20), false)

local _0xFF98 = _0xB5A4:CreateTab("Player", 4483362458)
local _0x8831 = _0xFF98:CreateDivider()

local _0x8CC9 = _0xFF98:CreateSection("Speed stuff")
local _0x3287 = false  
local _0x6021 = 1.5
local _0x5A83 = 0.3  
local function _0x93D2()
    while _0x3287 do
        local _0x58E0 = game.Players.LocalPlayer
        if _0x58E0 and _0x58E0.Character and _0x58E0.Character:FindFirstChild("HumanoidRootPart") then
            local _0x6F87 = _0x58E0.Character.HumanoidRootPart
            local _0x3D6E = _0x58E0.Character.Humanoid.MoveDirection

            if _0x3D6E.Magnitude > 0 then
                _0x6F87.CFrame = _0x6F87.CFrame:Lerp(_0x6F87.CFrame + (_0x3D6E * _0x6021), _0x5A83)
            end
        end
        task.wait(0.015)
    end
end

local _0x7C9D = _0xFF98:CreateToggle({
    Name = "Tp walk (Makes you faster)",
    CurrentValue = false,
    Flag = "TpWalk",
    Callback = function(Value)
        _0x3287 = Value
        if _0x3287 then
            task.spawn(_0x93D2)
        end
    end,
})

local _0x7569 = _0xFF98:CreateSlider({
    Name = "TP Walk Speed",
    Range = {1, 10}, 
    Increment = 0.5, 
    Suffix = "Speed",
    CurrentValue = _0x6021, 
    Flag = "TpWalkSpeed",
    Callback = function(Value)
        _0x6021 = Value 
    end,
})

local _0x6217 = _0xFF98:CreateSection("Jumping stuff")

local _0x40E4 = _0xFF98:CreateButton({
    Name = "Allow Jumping",
    Callback = function()
        local _0x58E0 = game.Players.LocalPlayer
        local _0x5D60 = _0x58E0.Character or _0x58E0.CharacterAdded:Wait()
        local _0x599F = _0x5D60:WaitForChild("Humanoid")
        local _0x4C79 = _0x5D60:WaitForChild("HumanoidRootPart")

        _0x599F.JumpPower = 50

        local _0x3794 = Instance.new("BodyVelocity")
        _0x3794.MaxForce = Vector3.new(5000, 5000, 5000)
        _0x3794.Velocity = Vector3.new(0, 100, 0)
        _0x3794.Parent = _0x4C79

        game.Debris:AddItem(_0x3794, 0.1)

        _0x599F.PlatformStand = false
        
        _0xAA2C:Notify({
            Title = "Notice:",
            Content = "when falling you can get slowed. also idk if this works for mobile",
            Duration = 6.5,
            Image = 4483362458,
         })
        end,
})

local _0x654A = _0xFF98:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200}, 
    Increment = 5, 
    Suffix = "JumpPower",
    CurrentValue = 50, 
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        local _0x58E0 = game.Players.LocalPlayer
        local _0x5D60 = _0x58E0.Character or _0x58E0.CharacterAdded:Wait()
        local _0x599F = _0x5D60:FindFirstChildOfClass("Humanoid")

        if _0x599F then
            _0x599F.JumpPower = Value 
        end
    end,
})

local _0xB2D4 = _0xFF98:CreateSection("Misc")

local function _0x5D1F()
    local _0x58E0 = game.Players.LocalPlayer
    local _0x5D60 = _0x58E0.Character
    if _0x5D60 and _0x5D60:FindFirstChild("Humanoid") then
        local _0x599F = _0x5D60.Humanoid
        local _0x4C79 = _0x5D60.HumanoidRootPart

        _0x599F.PlatformStand = true

        local _0x7C30 = Instance.new("BodyVelocity")
        _0x7C30.MaxForce = Vector3.new(5000, 5000, 5000)
        _0x7C30.Velocity = Vector3.new(0, 35, 0)
        _0x7C30.Parent = _0x4C79

        local _0x77C6 = _0x4C79.CFrame
        local _0x9F99 = 10

        for _0x1CC3 = 1, 25 do
            local _0x5A30 = _0x77C6 * CFrame.Angles(math.rad(15 * _0x1CC3), 0, 0)
            _0x4C79.CFrame = _0x5A30
            task.wait(0.03)
        end

        _0x7C30:Destroy()
        _0x599F.PlatformStand = false
    end
end

local _0x51A3 = _0xFF98:CreateButton({
    Name = "Backflip",
    Callback = function()
        _0x5D1F()
    end,
})

local _0xF1D5 = _0xB5A4:CreateTab("ESP", 4483362458)
local _0xBB28 = _0xF1D5:CreateDivider()
local _0x4F61 = false
local _0xD52F = game:GetService("Players")
local _0xE80C = Color3.fromRGB(255, 0, 0)
local _0xC5A9 = Color3.fromRGB(0, 255, 0)

local function _0xB820(_0x91F6, _0xA91A)
    if not _0x91F6 or not _0x91F6:FindFirstChild("Humanoid") then return end

    if _0x91F6:FindFirstChild("ESP_Highlight") then
        _0x91F6.ESP_Highlight:Destroy()
    end

    local _0x6BEF = Instance.new("Highlight")
    _0x6BEF.Name = "ESP_Highlight"
    _0x6BEF.Parent = _0x91F6
    _0x6BEF.FillTransparency = 1
    _0x6BEF.FillColor = _0xA91A
    _0x6BEF.OutlineColor = _0xA91A
    _0x6BEF.OutlineTransparency = 0.2
end

local function _0x29AB(_0x4201)
    _0x4F61 = _0x4201

    if _0x4F61 then
        local _0xB61A = game.Workspace.Players:FindFirstChild("Killers")
        if _0xB61A then
            for _, _0x91F6 in pairs(_0xB61A:GetChildren()) do
                if _0x91F6:IsA("Model") then
                    _0xB820(_0x91F6, _0xE80C)
                end
            end
        end

        local _0x4E1A = game.Workspace.Players:FindFirstChild("Survivors")
        if _0x4E1A then
            for _, _0x91F6 in pairs(_0x4E1A:GetChildren()) do
                if _0x91F6:IsA("Model") then
                    _0xB820(_0x91F6, _0xC5A9)
                end
            end
        end
    end
end

local _0xE9AF = _0xF1D5:CreateToggle({
    Name = "ESP for Survivors and Killers",
    CurrentValue = false,
    Flag = "ESP_Toggle",
    Callback = function(Value)
        _0x29AB(Value)
    end,
})
