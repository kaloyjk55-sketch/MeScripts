local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- HỆ THỐNG QUẢN LÝ
local V12 = { Conns = {}, Objs = {}, ESP_List = {} }
function V12:Clear()
    for _, c in pairs(self.Conns) do c:Disconnect() end
    for _, o in pairs(self.Objs) do if o and o.Parent then o:Destroy() end end
    if Lighting:FindFirstChild("V12_Blur") then Lighting.V12_Blur:Destroy() end
end

local State = { Fly = false, Aimbot = false, ESP = false, Noclip = false, Speed = 16 }

-- ===== GUI GỐC CỦA BRO (FIXED) =====
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "TD_V12_Genesis"; gui.ResetOnSpawn = false
table.insert(V12.Objs, gui)

local blur = Instance.new("BlurEffect", Lighting)
blur.Name = "V12_Blur"; blur.Size = 0

-- LOGO BUTTON
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0.5,-30)
logo.BackgroundColor3 = Color3.fromRGB(20,20,25)
logo.Text = "TD"; logo.TextColor3 = Color3.new(1,1,1)
logo.Font = Enum.Font.GothamBold; logo.TextScaled = true
logo.ZIndex = 100
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)
local lStroke = Instance.new("UIStroke", logo)
lStroke.Thickness = 2
task.spawn(function() while task.wait() do lStroke.Color = Color3.fromHSV(tick()%5/5, 0.8, 1) end end)

-- MAIN MENU
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,0,0,0)
menu.Position = UDim2.new(0.5,-175,0.5,-200)
menu.BackgroundColor3 = Color3.fromRGB(25,25,30)
menu.BackgroundTransparency = 0.15
menu.Visible = false
menu.ClipsDescendants = true
menu.ZIndex = 99
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,22)
local mStroke = Instance.new("UIStroke", menu)
mStroke.Thickness = 3; mStroke.Color = Color3.fromRGB(100,100,120)

-- TIÊU ĐỀ "CHỨC NĂNG TD"
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0, 50); title.Text = "CHỨC NĂNG TD"
title.TextColor3 = Color3.new(1,1,1); title.Font = Enum.Font.GothamBold; title.TextSize = 20; title.BackgroundTransparency = 1

local container = Instance.new("ScrollingFrame", menu)
container.Size = UDim2.new(1, -20, 1, -70); container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1; container.ScrollBarThickness = 0
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

-- ===== HÀM THÊM NÚT BẬT/TẮT =====
local function AddToggle(name, stateKey, cb)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    btn.Text = name .. ": OFF"; btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 13
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        local isOn = State[stateKey]
        btn.BackgroundColor3 = isOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40,40,50)
        btn.Text = name .. (isOn and ": ON" or ": OFF")
        cb(isOn)
    end)
end

-- MODULES TD
AddToggle("TD FLY V36", "Fly", function(on)
    local r = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if on and r then
        local bv = Instance.new("BodyVelocity", r); bv.Name = "V_V"; bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        local bg = Instance.new("BodyGyro", r); bg.Name = "V_G"; bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    elseif r then
        if r:FindFirstChild("V_V") then r.V_V:Destroy() end
        if r:FindFirstChild("V_G") then r.V_G:Destroy() end
    end
end)
AddToggle("AIMBOT HEAD", "Aimbot", function() end)
AddToggle("SPEED HACK (100)", "Speed", function(on) State.Speed = on and 100 or 16 end)

-- ===== LOGIC KÉO THẢ & CLICK (QUAN TRỌNG NHẤT) =====
local dragStart, startPos, dragging = nil, nil, false
local moved = false -- Biến kiểm tra xem có đang di chuyển logo không

logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        moved = false
        dragStart = input.Position
        startPos = logo.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then -- Nếu di chuyển quá 5 pixel thì tính là KÉO
            moved = true
            logo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input
