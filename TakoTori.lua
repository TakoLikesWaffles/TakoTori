local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
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

local Tab = Window:CreateTab("Change-Log", 4483362458) -- Title, Image
local Label = Tab:CreateLabel("wip there isnt anything to talk about", 4483362458, Color3.fromRGB(50, 20, 20), false) -- Title, Icon, Color, IgnoreTheme


local Tab = Window:CreateTab("Player", 4483362458)
local Divider = Tab:CreateDivider() -- Added Divider

local Section = Tab:CreateSection("Speed stuff")
local tpWalkEnabled = false  
local speed = 1.5
local lerpStrength = 0.3  
local function tpWalk()
    while tpWalkEnabled do
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local moveDirection = player.Character.Humanoid.MoveDirection

            if moveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame:Lerp(root.CFrame + (moveDirection * speed), lerpStrength)
            end
        end
        task.wait(0.015)
    end
end
local Toggle = Tab:CreateToggle({
    Name = "Tp walk (Makes you faster)",
    CurrentValue = false,
    Flag = "TpWalk",
    Callback = function(Value)
        tpWalkEnabled = Value
        if tpWalkEnabled then
            task.spawn(tpWalk)
        end
    end,
})

local SpeedSlider = Tab:CreateSlider({
    Name = "TP Walk Speed",
    Range = {1, 10}, -- Minimum: 1, Maximum: 10
    Increment = 0.5, -- Adjusts in steps of 0.5
    Suffix = "Speed",
    CurrentValue = speed, -- Uses the existing speed variable
    Flag = "TpWalkSpeed",
    Callback = function(Value)
        speed = Value -- Updates speed variable dynamically
    end,
})

local Section = Tab:CreateSection("Jumping stuff")

local Button = Tab:CreateButton({
    Name = "Allow Jumping",
    Callback = function()
        -- Get the local player and character
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        -- Set the JumpPower to a high value (optional, can be adjusted)
        humanoid.JumpPower = 50

        -- Force the character to jump by applying an upward velocity directly to the HumanoidRootPart
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(5000, 5000, 5000)  -- Allowing high force
        bodyVelocity.Velocity = Vector3.new(0, 100, 0)  -- Apply upward force to simulate jump
        bodyVelocity.Parent = rootPart

        -- Remove the BodyVelocity after a short period so the player doesn't float in the air
        game.Debris:AddItem(bodyVelocity, 0.1)

        -- Make sure the character is not in PlatformStand mode (could prevent jumping)
        humanoid.PlatformStand = false
        
        Rayfield:Notify({
            Title = "Notice:",
            Content = "when falling you can get slowed. also idk if this works for mobile",
            Duration = 6.5,
            Image = 4483362458,
         })
        end,
})
local JumpPowerSlider = Tab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200}, -- Adjust the range as needed
    Increment = 5, -- Adjusts in steps of 5
    Suffix = "JumpPower",
    CurrentValue = 50, -- Default JumpPower
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.JumpPower = Value -- Updates JumpPower dynamically
        end
    end,
})

 

local Section = Tab:CreateSection("Misc")
-- Function to perform a backflip
local function performBackflip()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        local rootPart = character.HumanoidRootPart

        -- Prevent any other actions during the backflip
        humanoid.PlatformStand = true

        -- Apply a small upward force for a more controlled flip
        local backflipForce = Instance.new("BodyVelocity")
        backflipForce.MaxForce = Vector3.new(5000, 5000, 5000) -- Lower force than before
        backflipForce.Velocity = Vector3.new(0, 35, 0) -- Moderate upward velocity
        backflipForce.Parent = rootPart

        -- Apply fast rotation to simulate the flip
        local initialRotation = rootPart.CFrame
        local rotationSpeed = 10 -- Control the speed of the flip rotation

        -- Rotate the HumanoidRootPart quickly to simulate the flip
        for i = 1, 25 do -- Rotate 25 times in the loop for the backflip effect
            local newRotation = initialRotation * CFrame.Angles(math.rad(15 * i), 0, 0) -- Rotate around X-axis
            rootPart.CFrame = newRotation
            task.wait(0.03) -- Short time between each small rotation step
        end

        -- Cleanup after the backflip is done
        backflipForce:Destroy()
        humanoid.PlatformStand = false
    end
end

-- Add Backflip Button in the Player Tab
local BackflipButton = Tab:CreateButton({
    Name = "Backflip",
    Callback = function()
        performBackflip()
    end,
})


local Tab = Window:CreateTab("ESP", 4483362458) -- Title, Image
local Divider = Tab:CreateDivider()
local espEnabled = false
local players = game:GetService("Players")
local killerESPColor = Color3.fromRGB(255, 0, 0)  -- Default Red for Killer
local survivorESPColor = Color3.fromRGB(0, 255, 0)  -- Default Green for Survivor

-- Function to apply ESP to Killer/Survivor models
local function applyESPToModel(model, color)
    if not model or not model:FindFirstChild("Humanoid") then return end

    -- Create Highlight if it doesn't exist
    if model:FindFirstChild("ESP_Highlight") then
        model.ESP_Highlight:Destroy()
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Parent = model
    highlight.FillTransparency = 1
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0.2
end

-- Function to toggle ESP for Killers and Survivors
local function toggleESP(value)
    espEnabled = value

    if espEnabled then
        -- Apply ESP to existing Killers
        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
        if killersFolder then
            for _, model in pairs(killersFolder:GetChildren()) do
                if model:IsA("Model") then
                    applyESPToModel(model, killerESPColor)
                end
            end
        end

        -- Apply ESP to existing Survivors
        local survivorsFolder = game.Workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            for _, model in pairs(survivorsFolder:GetChildren()) do
                if model:IsA("Model") then
                    applyESPToModel(model, survivorESPColor)
                end
            end
        end

        -- Watch for new Killers or Survivors being added
        game.Workspace.Players.Killers.ChildAdded:Connect(function(model)
            if model:IsA("Model") then
                applyESPToModel(model, killerESPColor)
            end
        end)

        game.Workspace.Players.Survivors.ChildAdded:Connect(function(model)
            if model:IsA("Model") then
                applyESPToModel(model, survivorESPColor)
            end
        end)

        -- Set up periodic checking for new Killers and Survivors
        task.spawn(function()
            while espEnabled do
                -- Reapply ESP to Killers and Survivors every 0.2 seconds
                local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                if killersFolder then
                    for _, model in pairs(killersFolder:GetChildren()) do
                        if model:IsA("Model") then
                            if not model:FindFirstChild("ESP_Highlight") then
                                applyESPToModel(model, killerESPColor)
                            end
                        end
                    end
                end

                local survivorsFolder = game.Workspace.Players:FindFirstChild("Survivors")
                if survivorsFolder then
                    for _, model in pairs(survivorsFolder:GetChildren()) do
                        if model:IsA("Model") then
                            if not model:FindFirstChild("ESP_Highlight") then
                                applyESPToModel(model, survivorESPColor)
                            end
                        end
                    end
                end

                task.wait(0.2) -- Wait 0.2 seconds before checking again
            end
        end)
    else
        -- Remove all ESP highlights
        local function removeESP(folder)
            for _, model in pairs(folder:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("ESP_Highlight") then
                    model.ESP_Highlight:Destroy()
                end
            end
        end

        removeESP(game.Workspace.Players.Killers)
        removeESP(game.Workspace.Players.Survivors)
    end
end

local ESP_Toggle = Tab:CreateToggle({
    Name = "ESP (Killer and Survivor)",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        toggleESP(Value)
    end,
})

-- Health ESP Update
local healthESPEnabled = false

local function updateHealthESP()
    while healthESPEnabled do
        for _, player in pairs(players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") then
                local head = player.Character.Head
                local humanoid = player.Character.Humanoid
                local billboard = head:FindFirstChild("HealthESP")

                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "HealthESP"
                    billboard.Size = UDim2.new(2, 0, 1, 0)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.Adornee = head
                    billboard.AlwaysOnTop = true

                    -- Create the outline text label with larger offset
                    local outlineLabel = Instance.new("TextLabel", billboard)
                    outlineLabel.Size = UDim2.new(1, 0, 1, 0)
                    outlineLabel.BackgroundTransparency = 1
                    outlineLabel.TextScaled = true
                    outlineLabel.Font = Enum.Font.FredokaOne  -- Set font to FredokaOne
                    outlineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White outline
                    outlineLabel.TextStrokeTransparency = 0.5  -- Set the transparency for the stroke (outline)
                    outlineLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Black outline
                    outlineLabel.Position = UDim2.new(0, 4, 0, 4)  -- Increased offset for a thicker outline
                    outlineLabel.Text = ""  -- The outline doesn't need any text itself

                    -- Create the main text label
                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.FredokaOne  -- Set font to FredokaOne
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Default text color
                    textLabel.TextStrokeTransparency = 0  -- No stroke for main text
                    textLabel.Text = ""  -- Empty text initially
                    billboard.Parent = head
                end

                local textLabel = billboard:FindFirstChildOfClass("TextLabel")
                if textLabel then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth * 100
                    textLabel.Text = "Health: " .. math.floor(healthPercent) .. "%"
                    
                    if healthPercent > 50 then
                        textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
                    elseif healthPercent > 30 then
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow
                    else
                        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red
                    end
                end
            end
        end
        task.wait(0.2) -- Update Health ESP every 0.2 seconds
    end
end

local HealthESP_Toggle = Tab:CreateToggle({
    Name = "health % above head  (useful for elliot)",
    CurrentValue = false,
    Flag = "HealthESP",
    Callback = function(Value)
        healthESPEnabled = Value
        if healthESPEnabled then
            task.spawn(updateHealthESP)
        else
            for _, player in pairs(players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    local billboard = player.Character.Head:FindFirstChild("HealthESP")
                    if billboard then billboard:Destroy() end
                end
            end
        end
    end,
})



local Section = Tab:CreateSection("Color picker")

-- Optional: Allow users to change ESP colors for Killer and Survivor
local killerColorPicker = Tab:CreateColorPicker({
    Name = "Killer ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "KillerESPColor",
    Callback = function(Value)
        killerESPColor = Value
    end
})

local survivorColorPicker = Tab:CreateColorPicker({
    Name = "Survivor ESP Color",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "SurvivorESPColor",
    Callback = function(Value)
        survivorESPColor = Value
    end
})

local Tab = Window:CreateTab("Map stuff", 4483362458) -- Title, Image
local Divider = Tab:CreateDivider()  
local function enableDaylight()
    local Lighting = game:GetService("Lighting")
    Lighting.TimeOfDay = "5:00:00"
    Lighting.FogStart = 100000
    Lighting.FogEnd = 100000
    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
    Lighting.Technology = Enum.Technology.Compatibility
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
end

local DaylightToggle = Tab:CreateToggle({
    Name = "Daylight (see better)",
    CurrentValue = false,
    Flag = "DaylightToggle",
    Callback = function(Value)
        if Value then
            enableDaylight()
            Rayfield:Notify({
                Title = "Might be buggy",
                Content = "sometimes theres fog thats orange. and when on the highest graphs it can be  VERY blurry",
                Duration = 6.5,
                Image = 4483362458,
             })
        end
    end,
})
