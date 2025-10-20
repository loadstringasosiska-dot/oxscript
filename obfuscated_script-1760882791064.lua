--// 🎃 MM2 Halloween AutoFarm 💰 [OPTIMIZED]
--// Works on XENO

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local function getChar()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    return char, hrp, humanoid
end

local character, hrp, humanoid = getChar()

local parentGui
pcall(function() parentGui = game:GetService("CoreGui") end)
if not parentGui then parentGui = LocalPlayer:WaitForChild("PlayerGui") end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2AutoFarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = parentGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 320)
frame.Position = UDim2.new(0.5, -160, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
}
gradient.Rotation = 135

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 140, 0)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.3

local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 15)

local titleMask = Instance.new("Frame", titleBar)
titleMask.Size = UDim2.new(1, 0, 0.5, 0)
titleMask.Position = UDim2.new(0, 0, 0.5, 0)
titleMask.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
titleMask.BorderSizePixel = 0

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "🎃 MM2 AutoFarm"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local autoBtn = Instance.new("TextButton", frame)
autoBtn.Text = "🚀 Start AutoFarm"
autoBtn.Size = UDim2.new(0, 140, 0, 36)
autoBtn.Position = UDim2.new(0, 15, 0, 55)
autoBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 14
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 8)

local afkBtn = Instance.new("TextButton", frame)
afkBtn.Text = "💤 Anti-AFK"
afkBtn.Size = UDim2.new(0, 140, 0, 36)
afkBtn.Position = UDim2.new(0, 165, 0, 55)
afkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
afkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
afkBtn.Font = Enum.Font.GothamBold
afkBtn.TextSize = 14
Instance.new("UICorner", afkBtn).CornerRadius = UDim.new(0, 8)

local afkModeBtn = Instance.new("TextButton", frame)
afkModeBtn.Text = "🌙 AFK Mode Farm"
afkModeBtn.Size = UDim2.new(0, 290, 0, 32)
afkModeBtn.Position = UDim2.new(0, 15, 0, 100)
afkModeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
afkModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
afkModeBtn.Font = Enum.Font.GothamBold
afkModeBtn.TextSize = 14
Instance.new("UICorner", afkModeBtn).CornerRadius = UDim.new(0, 8)

local espBtn = Instance.new("TextButton", frame)
espBtn.Text = "👁 Coin ESP"
espBtn.Size = UDim2.new(0, 290, 0, 32)
espBtn.Position = UDim2.new(0, 15, 0, 140)
espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1, -30, 0, 18)
speedLabel.Position = UDim2.new(0, 15, 0, 180)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
speedLabel.Font = Enum.Font.GothamMedium
speedLabel.TextSize = 12
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Text = "⚡ Speed: 30 (Safe: 20, Risk: 35)"

local speedSlider = Instance.new("Frame", frame)
speedSlider.Size = UDim2.new(0, 190, 0, 6)
speedSlider.Position = UDim2.new(0, 15, 0, 205)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", speedSlider).CornerRadius = UDim.new(1, 0)

local speedFill = Instance.new("Frame", speedSlider)
speedFill.Size = UDim2.new(0.66, 0, 1, 0)
speedFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
speedFill.BorderSizePixel = 0
Instance.new("UICorner", speedFill).CornerRadius = UDim.new(1, 0)

local speedDragger = Instance.new("TextButton", speedSlider)
speedDragger.Size = UDim2.new(0, 16, 0, 16)
speedDragger.Position = UDim2.new(0.66, -8, 0.5, -8)
speedDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedDragger.Text = ""
speedDragger.AutoButtonColor = false
Instance.new("UICorner", speedDragger).CornerRadius = UDim.new(1, 0)

local speedInput = Instance.new("TextBox", frame)
speedInput.Size = UDim2.new(0, 80, 0, 26)
speedInput.Position = UDim2.new(0, 225, 0, 195)
speedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.Font = Enum.Font.GothamBold
speedInput.TextSize = 14
speedInput.Text = "30"
speedInput.PlaceholderText = "20-35"
speedInput.ClearTextOnFocus = false
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 6)

local statsLabel = Instance.new("TextLabel", frame)
statsLabel.Size = UDim2.new(1, -30, 0, 20)
statsLabel.Position = UDim2.new(0, 15, 0, 235)
statsLabel.BackgroundTransparency = 1
statsLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
statsLabel.Font = Enum.Font.GothamMedium
statsLabel.TextSize = 13
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.Text = "⏱ Farm Time: 0d 0m 0s"

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -30, 0, 18)
statusLabel.Position = UDim2.new(0, 15, 0, 260)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Text = "Status: Ready"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 150, 0, 45)
toggleBtn.Position = UDim2.new(0.5, -75, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "🎃 AutoFarm"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = screenGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 12)

local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(200, 100, 0)

frame.Visible = false
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local flySpeed = 30
local farmStartTime = 0
local totalFarmTime = 0
local afkModeEnabled = false

local function updateSpeed(value)
    flySpeed = math.clamp(math.floor(value), 20, 35)
    speedInput.Text = tostring(flySpeed)
    speedLabel.Text = "⚡ Speed: " .. flySpeed .. " (Safe: 20, Risk: 35)"
    local percent = (flySpeed - 20) / 15
    speedFill.Size = UDim2.new(percent, 0, 1, 0)
    speedDragger.Position = UDim2.new(percent, -8, 0.5, -8)
    if flySpeed <= 22 then
        speedFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    elseif flySpeed <= 28 then
        speedFill.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    else
        speedFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    end
end

local dragging = false
speedDragger.MouseButton1Down:Connect(function()
    dragging = true
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mouse = LocalPlayer:GetMouse()
        local relativeX = mouse.X - speedSlider.AbsolutePosition.X
        local percent = math.clamp(relativeX / speedSlider.AbsoluteSize.X, 0, 1)
        local value = 20 + (percent * 15)
        updateSpeed(value)
    end
end)

speedInput.FocusLost:Connect(function()
    local value = tonumber(speedInput.Text)
    if value then
        updateSpeed(value)
    else
        speedInput.Text = tostring(flySpeed)
    end
end)

local coinCache = {}
local lastFullScan = 0
local SCAN_INTERVAL = 2

local function updateCoinCache()
    local newCache = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
            newCache[obj] = true
            if not coinCache[obj] then
                obj.AncestryChanged:Connect(function()
                    coinCache[obj] = nil
                end)
            end
        end
    end
    coinCache = newCache
    lastFullScan = tick()
end

updateCoinCache()

local function getCoins()
    if tick() - lastFullScan > SCAN_INTERVAL then
        updateCoinCache()
    end
    
    local coins = {}
    for coin, _ in pairs(coinCache) do
        if coin and coin.Parent and coin:IsDescendantOf(workspace) then
            table.insert(coins, coin)
        else
            coinCache[coin] = nil
        end
    end
    return coins
end

local function flyToPart(part)
    if not part or not hrp or not character then return end
    if not part:IsDescendantOf(workspace) then return end
    
    local targetPos = part.Position - Vector3.new(0, 2, 0)
    local distance = (hrp.Position - targetPos).Magnitude
    local time = math.clamp(distance / flySpeed, 0.05, 3)

    local goal = {CFrame = CFrame.new(targetPos)}
    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), goal)
    pcall(function()
        tween:Play()
        tween.Completed:Wait()
    end)
end

local noclipParts = {}
local noclipConn
local function enableNoclip()
    if noclipConn then return end
    
    noclipParts = {}
    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("BasePart") then
            noclipParts[v] = v.CanCollide
        end
    end
    
    noclipConn = RunService.Stepped:Connect(function()
        if not character or not character.Parent then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function disableNoclip()
    if noclipConn then 
        noclipConn:Disconnect()
        noclipConn = nil
    end
    for part, original in pairs(noclipParts) do
        if part and part.Parent then
            part.CanCollide = original
        end
    end
    noclipParts = {}
end

local bodyVelocity
local function enableAntiGravity()
    if bodyVelocity and bodyVelocity.Parent then return end
    if bodyVelocity then bodyVelocity:Destroy() end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
    bodyVelocity.Parent = hrp
end

local function disableAntiGravity()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

local farming = false
local farmTask
local afkWaitTask

local function waitForRound()
    statusLabel.Text = "AFK: Searching for map..."
    local mapModel = workspace:WaitForChild("MapID", 30)
    if not mapModel then
        statusLabel.Text = "AFK: Map not found!"
        return false
    end
    
    local mapPos = mapModel:IsA("Model") and mapModel:GetPivot().Position or mapModel.Position
    statusLabel.Text = "AFK: Hovering near map..."
    
    enableNoclip()
    enableAntiGravity()
    
    local hoverPos = mapPos + Vector3.new(math.random(-30, 30), 50, math.random(-30, 30))
    hrp.CFrame = CFrame.new(hoverPos)
    
    local roundTimer = workspace:WaitForChild("RoundTimerPart", 10)
    if not roundTimer then
        statusLabel.Text = "AFK: RoundTimer not found!"
        return false
    end
    
    while farming and afkModeEnabled do
        local timeAttr = roundTimer:GetAttribute("Time")
        if timeAttr and timeAttr ~= -1 then
            statusLabel.Text = "AFK: Round started! Farming..."
            return true
        end
        
        hrp.CFrame = CFrame.new(hoverPos)
        task.wait(0.5)
    end
    
    return false
end

local function startFarm()
    if farming then return end
    farming = true
    farmStartTime = tick()
    
    task.spawn(function()
        while farming do
            local elapsed = totalFarmTime + (tick() - farmStartTime)
            local days = math.floor(elapsed / 86400)
            local minutes = math.floor((elapsed % 86400) / 60)
            local seconds = math.floor(elapsed % 60)
            statsLabel.Text = string.format("⏱ Farm Time: %dd %dm %ds", days, minutes, seconds)
            task.wait(1)
        end
    end)
    
    farmTask = task.spawn(function()
        if afkModeEnabled then
            local roundReady = waitForRound()
            if not roundReady or not farming then
                if farming then stopFarm() end
                return
            end
        end
        
        enableNoclip()
        
        while farming do
            local success = pcall(function()
                if not hrp or not hrp.Parent or not humanoid or humanoid.Health <= 0 then
                    character, hrp, humanoid = getChar()
                    disableAntiGravity()
                    task.wait(1)
                    return
                end

                local coins = getCoins()
                local visibleCoins = {}
                
                for _, c in ipairs(coins) do
                    if c.Transparency == 0 then
                        table.insert(visibleCoins, c)
                    end
                end

                if #visibleCoins > 0 then
                    enableAntiGravity()
                    
                    table.sort(visibleCoins, function(a, b)
                        return (a.Position - hrp.Position).Magnitude < (b.Position - hrp.Position).Magnitude
                    end)
                    
                    local closest = visibleCoins[1]
                    flyToPart(closest)
                else
                    disableAntiGravity()
                    statusLabel.Text = "Waiting for coins..."
                    task.wait(0.5)
                end
            end)
            
            if not success then task.wait(0.1) end
            task.wait(0.08)
        end
    end)
end

local function stopFarm()
    farming = false
    if farmTask then task.cancel(farmTask) end
    totalFarmTime = totalFarmTime + (tick() - farmStartTime)
    disableNoclip()
    disableAntiGravity()
end

local AntiAFK = false
local afkConn
local function startAFK()
    if AntiAFK then return end
    AntiAFK = true
    afkConn = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

local function stopAFK()
    AntiAFK = false
    if afkConn then afkConn:Disconnect() end
end

local espEnabled = false
local espHighlights = {}
local hue = 0
local espTask

local function createESP(part)
    if espHighlights[part] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.Parent = part
    espHighlights[part] = highlight
end

local function enableESP()
    if espEnabled then return end
    espEnabled = true
    
    for _, part in ipairs(getCoins()) do
        createESP(part)
    end

    espTask = task.spawn(function()
        while espEnabled do
            hue = (hue + 2) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            
            for part, h in pairs(espHighlights) do
                if part.Parent and h.Parent then
                    h.OutlineColor = color
                else
                    h:Destroy()
                    espHighlights[part] = nil
                end
            end
            
            if tick() % 1 < 0.3 then
                for _, part in ipairs(getCoins()) do
                    if not espHighlights[part] then
                        createESP(part)
                    end
                end
            end
            
            task.wait(0.03)
        end
    end)
end

local function disableESP()
    espEnabled = false
    if espTask then task.cancel(espTask) end
    for _, h in pairs(espHighlights) do
        h:Destroy()
    end
    espHighlights = {}
end

autoBtn.MouseButton1Click:Connect(function()
    if farming then
        stopFarm()
        autoBtn.Text = "🚀 Start AutoFarm"
        autoBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
        statusLabel.Text = "AutoFarm stopped"
    else
        startFarm()
        autoBtn.Text = "⏸ Stop AutoFarm"
        autoBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        statusLabel.Text = "AutoFarm active"
    end
end)

afkBtn.MouseButton1Click:Connect(function()
    if AntiAFK then
        stopAFK()
        afkBtn.Text = "💤 Anti-AFK"
        afkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        statusLabel.Text = "Anti-AFK disabled"
    else
        startAFK()
        afkBtn.Text = "✅ Anti-AFK ON"
        afkBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        statusLabel.Text = "Anti-AFK active"
    end
end)

afkModeBtn.MouseButton1Click:Connect(function()
    if afkModeEnabled then
        afkModeEnabled = false
        afkModeBtn.Text = "🌙 AFK Mode Farm"
        afkModeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        statusLabel.Text = "AFK Mode disabled"
    else
        afkModeEnabled = true
        afkModeBtn.Text = "✅ AFK Mode ON"
        afkModeBtn.BackgroundColor3 = Color3.fromRGB(120, 100, 220)
        statusLabel.Text = "AFK Mode enabled"
    end
end)

espBtn.MouseButton1Click:Connect(function()
    if espEnabled then
        disableESP()
        espBtn.Text = "👁 Coin ESP"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        statusLabel.Text = "ESP disabled"
    else
        enableESP()
        espBtn.Text = "✅ ESP Active"
        espBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 220)
        statusLabel.Text = "ESP enabled"
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local wasFarming = farming
    
    if farming then
        stopFarm()
    end
    
    character = char
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:FindFirstChildOfClass("Humanoid")
    
    updateCoinCache()
    
    if wasFarming then
        task.wait(1)
        startFarm()
        statusLabel.Text = "AutoFarm resumed"
    end
end)

statusLabel.Text = "Ready to farm!"
