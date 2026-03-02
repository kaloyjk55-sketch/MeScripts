-- [[ THĐ NANO V12 - CUSTOM UI BY USER ]] --
-- [[ LOGIC INTEGRATED: TD FLY V36 + FULL MODULES ]] --

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

-- TRẠNG THÁI
local State = { Fly = false, Aimbot = false, ESP = false, Noclip = false, Speed = 16 }

-- ===== GUI GỐC CỦA BRO =====
local gui = Instance.new("ScreenGui")
gui.Name = "TD_V12_Genesis"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
table.insert(V12.Objs, gui)

local blur = Instance.new("BlurEffect")
blur.Name = "V12_Blur"
blur.Size = 0
blur.Parent = Lighting

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0.5,-30)
logo.BackgroundColor3 = Color3.fromRGB(20,20,25)
logo.Text = "TD"
logo.TextColor3 = Color3.fromRGB(255,255,255)
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
logo.AutoButtonColor = false
logo.BorderSizePixel = 0
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke", logo)
logoStroke.Thickness = 2
local logoGlow = Instance.new("UIStroke", logo)
logoGlow.Thickness = 6; logoGlow.Transparency = 0.7

-- Hiệu ứng Rainbow cho Logo Stroke
task.spawn(function()
	while task.wait() do
		local col = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
		logoStroke.Color = col; logoGlow.Color = col
	end
end)

-- ===== KÉO THẢ LOGO =====
local dragging, dragStart, startPos
logo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true; dragStart = input.Position; startPos = logo.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		logo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UserInputService.InputEnded:Connect(function() dragging = false end)

-- ===== MAIN MENU CỦA BRO (Đã gộp chức năng) =====
local menu = Instance.new("Frame")
menu.Parent = gui
menu.Size = UDim2.new(0,0,0,0)
menu.Position = UDim2.new(0.5,-175,0.5,-200)
menu.BackgroundColor3 = Color3.fromRGB(25,25,30)
menu.BackgroundTransparency = 0.15
menu.Visible = false
menu.ClipsDescendants = true
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,22)

local stroke = Instance.new("UIStroke", menu)
stroke.Thickness = 3; stroke.Color = Color3.fromRGB(100, 100, 120)

local gradient = Instance.new("UIGradient", menu)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(40,40,50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15,15,20))
}

-- TIÊU ĐỀ "CHỨC NĂNG TD"
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "CHỨC NĂNG TD"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local line = Instance.new("Frame", menu)
line.Size = UDim2.new(0.8, 0, 0, 2)
line.Position = UDim2.new(0.1, 0, 0, 45)
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BackgroundTransparency = 0.5

-- KHU VỰC CHỨA NÚT (Scrolling)
local container = Instance.new("ScrollingFrame", menu)
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 0
local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 10); layout.HorizontalAlignment = "Center"

-- ===== HÀM TẠO NÚT BẬT/TẮT =====
local function AddToggle(name, stateKey, cb)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	btn.Text = name .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		State[stateKey] = not State[stateKey]
		local isOn = State[stateKey]
		TweenService:Create(btn, TweenInfo.new(0.3), {
			BackgroundColor3 = isOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40, 40, 50),
			TextColor3 = isOn and Color3.new(1, 1, 1) or Color3.fromRGB(200, 200, 200)
		}):Play()
		btn.Text = name .. (isOn and ": ON" or ": OFF")
		cb(isOn)
	end)
end

-- ===== KHỞI TẠO CÁC CHỨC NĂNG TD =====

AddToggle("TD FLY V36", "Fly", function(on)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if on and root then
		local bv = Instance.new("BodyVelocity", root); bv.Name = "V36_V"; bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		local bg = Instance.new("BodyGyro", root); bg.Name = "V36_G"; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	elseif root then
		if root:FindFirstChild("V36_V") then root.V36_V:Destroy() end
		if root:FindFirstChild("V36_G") then root.V36_G:Destroy() end
	end
end)

AddToggle("AIMBOT HEAD", "Aimbot", function() end)

AddToggle("ESP BOX", "ESP", function(on)
	if not on then for _, v in pairs(V12.ESP_List) do v.Visible = false end end
end)

AddToggle("NOCLIP WALL", "Noclip", function() end)

AddToggle("SPEED HACK", "Speed", function(on)
	State.Speed = on and 100 or 16
end)

-- NÚT TẮT SCRIPT
local kill = Instance.new("TextButton", container)
kill.Size = UDim2.new(0.9, 0, 0, 40); kill.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
kill.Text = "KILL SCRIPT"; kill.TextColor3 = Color3.new(1,1,1); kill.Font = Enum.Font.GothamBold
Instance.new("UICorner", kill)
kill.MouseButton1Click:Connect(function() V12:Clear() end)

-- ===== ĐÓNG/MỞ MENU =====
local isOpen = false
logo.MouseButton1Click:Connect(function()
	if dragging then return end
	isOpen = not isOpen
	menu.Visible = true
	TweenService:Create(blur, TweenInfo.new(0.5), {Size = isOpen and 15 or 0}):Play()
	TweenService:Create(menu, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
		Size = isOpen and UDim2.new(0, 350, 0, 400) or UDim2.new(0, 0, 0, 0)
	}):Play()
end)

-- ===== HỆ THỐNG VẬN HÀNH LOOP =====
table.insert(V12.Conns, RunService.RenderStepped:Connect(function()
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end

	-- Speed
	hum.WalkSpeed = State.Speed

	-- Fly V36
	if State.Fly and root:FindFirstChild("V36_V") then
		root.V36_V.Velocity = hum.MoveDirection * 100
		root.V36_G.CFrame = camera.CFrame
		hum.PlatformStand = true
	elseif not State.Fly and hum.PlatformStand then hum.PlatformStand = false end

	-- Noclip
	if State.Noclip then
		for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
	end

	-- Aimbot
	if State.Aimbot then
		local target, dist = nil, 400
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
				local pos, vis = camera:WorldToViewportPoint(p.Character.Head.Position)
				if vis then
					local m = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
					if m < dist then dist = m; target = p.Character.Head end
				end
			end
		end
		if target then camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position) end
	end
end))

-- ESP Loop
task.spawn(function()
	while task.wait(0.2) do
		if not State.ESP then continue end
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				if not V12.ESP_List[p] then
					local s = Drawing.new("Square"); s.Thickness = 1.5; s.Color = Color3.new(1,0,0); s.Visible = false
					V12.ESP_List[p] = s
				end
				local b = V12.ESP_List[p]
				local pos, vis = camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
				if vis then
					b.Size = Vector2.new(1200/pos.Z, 1800/pos.Z)
					b.Position = Vector2.new(pos.X - b.Size.X/2, pos.Y - b.Size.Y/2)
					b.Visible = true
				else b.Visible = false end
			end
		end
	end
end)
