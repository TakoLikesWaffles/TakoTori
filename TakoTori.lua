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

local Tab = Window:CreateTab("Change-Log", 4483362458)        
local Label = Tab:CreateLabel("W.I.P Added expiremntal tab, Added frontflip", 4483362458, Color3.fromRGB(50, 20, 20), false)        


local Tab = Window:CreateTab("Player", 4483362458)
local Divider = Tab:CreateDivider()        

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
    Range = {1, 10},        
    Increment = 0.5,        
    Suffix = "Speed",
    CurrentValue = speed,        
    Flag = "TpWalkSpeed",
    Callback = function(Value)
        speed = Value        
    end,
})

local Section = Tab:CreateSection("Jumping stuff")

local Button = Tab:CreateButton({
    Name = "Allow Jumping",
    Callback = function()
               
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

               
        humanoid.JumpPower = 50

               
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(5000, 5000, 5000)         
        bodyVelocity.Velocity = Vector3.new(0, 100, 0)         
        bodyVelocity.Parent = rootPart

               
        game.Debris:AddItem(bodyVelocity, 0.1)

               
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
    Range = {50, 200},        
    Increment = 5,        
    Suffix = "JumpPower",
    CurrentValue = 50,        
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.JumpPower = Value        
        end
    end,
})

 

local Section = Tab:CreateSection("Misc")
local function performBackflip()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        local rootPart = character.HumanoidRootPart

               
        humanoid.PlatformStand = true

               
        local backflipForce = Instance.new("BodyVelocity")
        backflipForce.MaxForce = Vector3.new(5000, 5000, 5000)        
        backflipForce.Velocity = Vector3.new(0, 35, 0)        
        backflipForce.Parent = rootPart

               
        local initialRotation = rootPart.CFrame
        local rotationSpeed = 10        

               
        for i = 1, 25 do        
            local newRotation = initialRotation * CFrame.Angles(math.rad(15 * i), 0, 0)        
            rootPart.CFrame = newRotation
            task.wait(0.03)        
        end

               
        backflipForce:Destroy()
        humanoid.PlatformStand = false
    end
end

       
local BackflipButton = Tab:CreateButton({
    Name = "Backflip",
    Callback = function()
        performBackflip()
    end,
})

local function performFrontflip()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        local rootPart = character.HumanoidRootPart

               
        humanoid.PlatformStand = true

               
        local frontflipForce = Instance.new("BodyVelocity")
        frontflipForce.MaxForce = Vector3.new(5000, 5000, 5000)        
        frontflipForce.Velocity = Vector3.new(0, 35, 0)        
        frontflipForce.Parent = rootPart

               
        local initialRotation = rootPart.CFrame
        local rotationSpeed = 10        

               
        for i = 1, 25 do        
            local newRotation = initialRotation * CFrame.Angles(math.rad(-15 * i), 0, 0)        
            rootPart.CFrame = newRotation
            task.wait(0.03)        
        end

               
        frontflipForce:Destroy()
        humanoid.PlatformStand = false
    end
end

       
local FrontflipButton = Tab:CreateButton({
    Name = "Frontflip",
    Callback = function()
        performFrontflip()
    end,
})



local Tab = Window:CreateTab("ESP", 4483362458)        
local Divider = Tab:CreateDivider()
local espEnabled = false
local players = game:GetService("Players")
local killerESPColor = Color3.fromRGB(255, 0, 0)         
local survivorESPColor = Color3.fromRGB(0, 255, 0)         

       
local function applyESPToModel(model, color)
    if not model or not model:FindFirstChild("Humanoid") then return end

           
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

       
local function toggleESP(value)
    espEnabled = value

    if espEnabled then
               
        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
        if killersFolder then
            for _, model in pairs(killersFolder:GetChildren()) do
                if model:IsA("Model") then
                    applyESPToModel(model, killerESPColor)
                end
            end
        end

               
        local survivorsFolder = game.Workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            for _, model in pairs(survivorsFolder:GetChildren()) do
                if model:IsA("Model") then
                    applyESPToModel(model, survivorESPColor)
                end
            end
        end

               
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

               
        task.spawn(function()
            while espEnabled do
                       
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

                task.wait(0.2)        
            end
        end)
    else
               
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

                           
                    local outlineLabel = Instance.new("TextLabel", billboard)
                    outlineLabel.Size = UDim2.new(1, 0, 1, 0)
                    outlineLabel.BackgroundTransparency = 1
                    outlineLabel.TextScaled = true
                    outlineLabel.Font = Enum.Font.FredokaOne         
                    outlineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)         
                    outlineLabel.TextStrokeTransparency = 0.5         
                    outlineLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)         
                    outlineLabel.Position = UDim2.new(0, 4, 0, 4)         
                    outlineLabel.Text = ""         

                           
                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.FredokaOne         
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)         
                    textLabel.TextStrokeTransparency = 0         
                    textLabel.Text = ""         
                    billboard.Parent = head
                end

                local textLabel = billboard:FindFirstChildOfClass("TextLabel")
                if textLabel then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth * 100
                    textLabel.Text = "Health: " .. math.floor(healthPercent) .. "%"
                    
                    if healthPercent > 50 then
                        textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)        
                    elseif healthPercent > 30 then
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)        
                    else
                        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)        
                    end
                end
            end
        end
        task.wait(0.2)        
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

local Tab = Window:CreateTab("Map stuff", 4483362458)        
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
local Tab = Window:CreateTab("EXPIRMENTALS", 4483362458)        
local Divider = Tab:CreateDivider()  

local function CompleteGenerators()
    local MapFolder = workspace:FindFirstChild("Map")
    local IngameFolder = MapFolder and MapFolder:FindFirstChild("Ingame")
    local TakoToriFolder = IngameFolder and IngameFolder:FindFirstChild("Map")

    if TakoToriFolder then
        for _, generator in ipairs(TakoToriFolder:GetChildren()) do
            if generator.Name == "Generator" and generator:FindFirstChild("Progress") and generator.Progress.Value < 100 then
                       
                generator.Remotes.RE:FireServer()
            end
        end
    end
end

       
local function IsOnGenerator()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local MapFolder = workspace:FindFirstChild("Map")
    local IngameFolder = MapFolder and MapFolder:FindFirstChild("Ingame")
    local TakoToriFolder = IngameFolder and IngameFolder:FindFirstChild("Map")

    if TakoToriFolder then
        for _, generator in ipairs(TakoToriFolder:GetChildren()) do
            if generator.Name == "Generator" then
                local generatorPosition = generator.Position
                local distance = (humanoidRootPart.Position - generatorPosition).Magnitude
                       
                if distance < 5 then
                    return true
                end
            end
        end
    end
    return false
end

       
local GeneratorToggle = Tab:CreateToggle({
    Name = "Do generators automaticly (really broken)",
    CurrentValue = false,
    Flag = "CompleteGenerators",
    Callback = function(Value)
        if Value then
                   
            spawn(function()
                while wait(1) do         
                    if IsOnGenerator() then
                        CompleteGenerators()         
                    end
                end
            end)
            Rayfield:Notify({
                Title = "Note:",
                Content = "Its slow to make it realistic.",
                Duration = 5,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({
                Title = "Note:",
                Content = "also generators might be broken when you try to open them..",
                Duration = 5,
                Image = 4483362458,
            })
        end
    end,
})
