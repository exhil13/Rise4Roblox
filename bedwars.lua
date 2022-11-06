local lplr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
local uis = game:GetService("UserInputService")
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local getremote = function(tab)
    for i,v in pairs(tab) do
        if v == "Client" then
            return tab[i + 1]
        end
    end
    return ""
end

local bedwars = {
    ["SprintController"] = KnitClient.Controllers.SprintController,
    ["ClientHandlerStore"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
    ["KnockbackUtil"] = require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil,
    ["PingController"] = require(lplr.PlayerScripts.TS.controllers.game.ping["ping-controller"]).PingController,
    ["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
    ["SwordController"] = KnitClient.Controllers.SwordController,
    ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
    ["SwordRemote"] = getremote(debug.getconstants((KnitClient.Controllers.SwordController).attackEntity)),
}

local ui = {}
local themes = {
	["blood"] = "blood";
	["sky"] = "sky";
	["dark"] = "dark";
	["light"] = "light"
}
local modules = {}
local ScrollingFrame = {}
local UIcount = 0
local binds = { -- list of characters you can bind a module to
	"a";
	"b";
	"c";
	"d";
	"e";
	"f";
	"g";
	"h";
	"i";
	"j";
	"k";
	"l";
	"m";
	"n";
	"o";
	"p";
	"q";
	"r";
	"s";
	"t";
	"u";
	"v";
	"w";
	"x";
	"y";
	"z"
}

function ui.CreateNotification(mod,text,timer)
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel2 = Instance.new("TextLabel")

	--Properties:

	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	Frame.Position = UDim2.new(0.833129585, 0, 0.850000024, 0)
	Frame.Size = UDim2.new(0, 273, 0, 100)

	UICorner.Parent = Frame

	TextLabel.Parent = ScreenGui
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0.840464532, 0, 0.850000024, 0)
	TextLabel.Size = UDim2.new(0, 248, 0, 29)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = mod
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true

	TextLabel2.Name = "TextLabel2"
	TextLabel2.Parent = ScreenGui
	TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel2.BackgroundTransparency = 1.000
	TextLabel2.Position = UDim2.new(0.840464532, 0, 0.89268297, 0)
	TextLabel2.Size = UDim2.new(0, 248, 0, 29)
	TextLabel2.Font = Enum.Font.SourceSans
	if text == "toggle" then
		TextLabel2.Text = mod.." has been toggled"
	else
		TextLabel2.Text = text
	end

	TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel2.TextScaled = true
	TextLabel2.TextSize = 14.000
	TextLabel2.TextWrapped = true
	task.wait(timer)
	ScreenGui:Destroy()
end

function ui.CreateLib(name,theme)
	UIcount = UIcount + 1
	local ScreenGui = Instance.new("ScreenGui")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local TextButton = Instance.new("TextButton")
	local TextLabel = Instance.new("TextLabel")
	local drag = Instance.new("Frame",ScreenGui)
	drag.Position = UDim2.new(0.440097809*UIcount/3.5, 0, 0.207317069, 0)
	drag.Size = UDim2.new(0, 195, 0, 50)
	drag.Transparency = 1
	drag.Draggable = true
	ScrollingFrame.Draggable = true
	TextLabel.Draggable = true
	drag.Name = "Drag"
	--Properties:

	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.Name = name

	ScrollingFrame.Parent = ScreenGui
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.440097809*UIcount/3.5, 0, 0.268292695, 0)
	ScrollingFrame.Size = UDim2.new(0, 195, 0, 421)
	ScrollingFrame.ScrollBarThickness = 0

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)
	TextLabel.Parent = ScreenGui
	TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TextLabel.Position = UDim2.new(0.440097809*UIcount/3.5, 0, 0.207317069, 0)
	TextLabel.Size = UDim2.new(0, 195, 0, 50)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = name
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
	local userInput = game:GetService("UserInputService")

	
	if theme == themes.blood then
		TextLabel.BackgroundColor3 = Color3.fromRGB(185, 31, 0)
	elseif theme == themes.sky then
		TextLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 248)
	elseif theme == themes.dark then
		TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	elseif theme == themes.light then
		TextLabel.BackgroundColor3 = Color3.fromRGB(188, 188, 188)
	end
	userInput.InputBegan:Connect(function(input,gameProcessed)
		if input.KeyCode == Enum.KeyCode.RightShift then
			local check = ScrollingFrame
			local check2 = TextLabel
			if check.Visible == true then
				check.Visible = false
				check2.Visible = false
			elseif check.Visible == false then
				check.Visible = true
				check2.Visible = true
			end
			
		end
	end)
	
end


function ui.NewButton(name,func,lib)
	local TextButton = Instance.new("TextButton")
	TextButton.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")[lib].ScrollingFrame
	TextButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	TextButton.Position = UDim2.new(0, 0, -0.103048779, 0)
	TextButton.Size = UDim2.new(0, 200, 0, 50)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.TextScaled = true
	TextButton.TextSize = 14.000
	TextButton.TextWrapped = true
	TextButton.Text = name
	TextButton.MouseButton1Down:Connect(function()
		local func2 = func
		modules[func]()
	end)
	local bind
	local UserInputService = game:GetService("UserInputService")
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	
	mouse.KeyDown:connect(function(key)
		if key == bind then
			local func2 = func
			modules[func]()
		end
	end)
	
	TextButton.MouseButton2Down:Connect(function()
		local binding = true
		ui.CreateNotification(lib,"Type a Key To Bind "..name.." To In The Box",3)
		local userInput = game:GetService("UserInputService")

		local ScreenGui = Instance.new("ScreenGui")
		TextBox = Instance.new("TextBox")

		--Properties:

		ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

		TextBox.Parent = ScreenGui
		TextBox.BackgroundColor3 = Color3.fromRGB(30, 101, 255)
		TextBox.Position = UDim2.new(0.389975548, 0, 0.896341443*0.232, 0)
		TextBox.Size = UDim2.new(0, 359, 0, 61)
		TextBox.Font = Enum.Font.SourceSans
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.TextScaled = true
		TextBox.TextSize = 14.000
		TextBox.TextWrapped = true
		TextBox.FocusLost:Connect(function()
			bind = TextBox.Text
			TextBox:Destroy()
		end)
	end)
end

function ui.CreateNewArray(name)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")

    local UIListLayout = Instance.new("UIListLayout")

    --Properties:

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "Array"..name

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1.000
    Frame.Position = UDim2.new(0.941340387, 0, 0, 0)
    Frame.Size = UDim2.new(0, 94, 0, 665)
    UIListLayout.Parent = Frame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 18)


end
function ui.AddLineToArray(module,array)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")["Array"..array].Frame
    TextLabel.Text = module
    TextLabel.Name = "ArrayModule"..module
    TextLabel.TextSize = 14
end

function ui.RemoveArrayLine(module,array)
    game.Players.LocalPlayer:WaitForChild("PlayerGui")["Array"..array].Frame["ArrayModule_"..module]:Destroy()
end

ui.CreateNewArray("Rise B1.0")

function ui.Uninject()
	for _,v in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
		if v:IsA("Chat") then
		else
			v:Destroy()
		end
		
	end
end

function modules.SayHi()
	print("hi")
	ui.CreateNotification("test","toggle",3)
end

function modules.Velocity()
	local KnockbackTable = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1)
    wait()
    KnockbackTable["kbDirectionStrength"] = 0
	KnockbackTable["kbUpwardStrength"] = 0
end

function modules.KALegit()
	local player = game:GetService("Players")
	local lplr = player.LocalPlayer
	local cam = workspace.CurrentCamera
	local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
	local SwordCont = KnitClient.Controllers.SwordController

	local aura = false
	local DistVal = {["Value"] = 14}
	function Aura()
		for i,v in pairs(game.Players:GetChildren()) do
			if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
				local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
				if mag <= DistVal["Value"] and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") then
					if v.Character.Humanoid.Health > 0 then
						aura = true
						SwordCont:swingSwordAtMouse()
					end
				end
			end
		end
	end

	game:GetService("RunService").Stepped:connect(function()
		Aura()
	end)
    ui.CreateNotification("LegitAura","toggle",3)
end

function modules.Speed()
	lplr.Character.Humanoid.WalkSpeed = 23
end

function modules.Fly1()
	local e = Instance.new("Part",workspace)
	e.Size = Vector3.new(99999999,2,999999999999)
	e.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
	e.CFrame = e.CFrame - Vector3.new(0,5.2,0)
	e.Anchored = true
	e.Transparency = 1

	local function PlayerTouched(Part)
		local Parent = Part.Parent
		if game.Players:GetPlayerFromCharacter(Parent) then
			wait(2)
			e:Destroy()
			workspace.Gravity = 196.2
		end
	end

	e.Touched:connect(PlayerTouched)
end

function modules.Fly2()
	local e = Instance.new("Part",workspace)
	e.Size = Vector3.new(99999999,2,999999999999)
	e.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
	e.CFrame = e.CFrame - Vector3.new(0,4.6,0)
	e.Anchored = true
	e.Transparency = 1

	local function PlayerTouched(Part)
		local Parent = Part.Parent
		if game.Players:GetPlayerFromCharacter(Parent) then
			wait(2.8)
			e:Destroy()
			workspace.Gravity = 196.2
		end
	end

	local function PlayerTouched2(Part)
		local Parent = Part.Parent
		if game.Players:GetPlayerFromCharacter(Parent) then
			wait()
			e.CFrame = e.CFrame + Vector3.new(0,0.08,0)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame+ Vector3.new(0,1,0)
		end
	end

	e.Touched:connect(PlayerTouched)
	e.Touched:connect(PlayerTouched2)
end

function modules.HighJump()
	local Velocity = Instance.new("BodyVelocity",game.Players.LocalPlayer.Character.HumanoidRootPart)
	Velocity.Name = "Velocity1"
	Velocity.Velocity = Vector3.new(0,500,0)
	game.Workspace.Gravity = 0
	wait(1.5)
	game.Workspace.Gravity = 192.6
	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity1:Destroy()
end

function modules.DamageLessTPHighJump()
	game.Workspace.Gravity = 1
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
wait()
game.Workspace.Gravity = 192.6
end

function modules.LongJump()
	game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	game.Workspace.Gravity = 10
	wait(2.2)
	game.Workspace.Gravity = 192.6
end

function modules.DamageTPForward()
    if game.Players.LocalPlayer.Character.Humanoid.Health ~= 100 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100
    end
end

function modules.ESP()
	local gui = Instance.new("BillboardGui");
	gui.Name = "names";
	gui.AlwaysOnTop = true;
	gui.LightInfluence = 0;
    gui.Size = UDim2.new(1.75, 0, 1.75, 0);
	local frame = Instance.new("Frame", gui);
	frame.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
	frame.Size = UDim2.new(1.7, 0, 3.89, 0);
	frame.BorderSizePixel = 4;
	frame.BorderColor3 = Color3.fromRGB(0, 0, 0);
	local gi = gui:Clone();
	body = frame:Clone();
	body.Parent = gi;
	body.BackgroundColor3 = Color3.fromRGB(0, 170, 170);

	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Name ~= game:GetService("Players").LocalPlayer.Name and v.Character and v.Character:FindFirstChild("Head") then
			gui:Clone().Parent = v.Character.Head;
		end
	end
end

function modules.Chams()
	local players = game.Players:GetPlayers()

		for i,v in pairs(players) do
			local esp = Instance.new("Highlight")
			esp.Name = v.Name
			esp.FillTransparency = 0.5
			esp.FillColor = Color3.new(0.462745, 0, 0.462745)
			esp.OutlineColor = Color3.new(0.462745, 0, 0.462745)
			esp.OutlineTransparency = 0
			esp.Parent = v.Character
		end
		game.Players.PlayerAdded:Connect(function(plr)
			plr.CharacterAdded:Connect(function(chr)
				local esp = Instance.new("Highlight")
				esp.Name = plr.Name
				esp.FillTransparency = 0.5
				esp.FillColor = Color3.new(0.462745, 0, 0.462745)
				esp.OutlineColor = Color3.new(0.462745, 0, 0.462745)
				esp.OutlineTransparency = 0
				esp.Parent = chr
			end)
	end)
end

function modules.SemiACBypasser()
	local lplr = game.Players.LocalPlayer
local cam = workspace.CurrentCamera
local oldchar
local clone

oldchar = lplr.Character
oldchar.Archivable = true
clone = oldchar:Clone()
oldchar.PrimaryPart.Anchored = false

local humc = oldchar.Humanoid:Clone()
humc.Parent = lplr.Character
game:GetService("RunService").Stepped:connect(function()
    local mag = (clone.PrimaryPart.Position - oldchar.PrimaryPart.Position).Magnitude
    if mag >= 2 then
        oldchar:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame)
    end
end)
pcall(function()
    oldchar.PrimaryPart:GetPropertyChangedSignal("CFrame"):connect(function()
        clone:SetPrimaryPartCFrame(oldchar.PrimaryPart.CFrame - Vector3.new(0,1.85,0)) 
    end)
end)

cam.CameraSubject = clone.Humanoid 
clone.Parent = workspace
lplr.Character = clone
for _,v in pairs(lplr.Character:GetChildren()) do
    v.Transparency = 1
    if v:IsA("Hat") then
        v:Destroy()
    elseif v:IsA("Shirt") then
        v:Destroy()
    elseif v:IsA("Pants") then
        v:Destroy()
    end
end


end

function modules.NoFall()
    while true do
		wait()
		game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.GroundHit:FireServer()
	end
end


function modules.AntiVoid()
    local e = Instance.new("Part",workspace)
		e.Size = Vector3.new(99999999,2,999999999999)
		e.Position = Vector3.new(0,27,0)
		e.Anchored = true
		e.BrickColor = BrickColor.new("Royal purple")
		e.Transparency = 0.5


		local function PlayerTouched(Part)
			local Parent = Part.Parent
			if game.Players:GetPlayerFromCharacter(Parent) then
				for i = 1,3 do wait()
					Parent.HumanoidRootPart.CFrame = Parent.HumanoidRootPart.CFrame + Vector3.new(0,25,0)
				end

			end
		end

		e.Touched:connect(PlayerTouched)
end
-- ONLY CODE UNDER HERE


ui.CreateLib("Combat",themes.sky) 
ui.NewButton("LegitAura","KALegit","Combat")
ui.NewButton("BlatantAura","AuraBlatant","Combat")
ui.NewButton("Velocity","Velocity","Combat")

ui.CreateLib("Movement",themes.sky) 
ui.NewButton("Speed","Speed","Movement")
ui.NewButton("StudFly1","Fly1","Movement")
ui.NewButton("StudFly2","Fly2","Movement")
ui.NewButton("HighJump","HighJump","Movement")
ui.NewButton("TpHighJump","DamageLessTPHighJump","Movement")
ui.NewButton("LongJump","LongJump","Movement")
ui.NewButton("NoFall","NoFall","Movement")
ui.NewButton("AntiVoid","AntiVoid","Movement")
ui.NewButton("DamageTPFW","DamageTPForward","Movement")

ui.CreateLib("Visuals",themes.sky) 
ui.NewButton("ESP","ESP","Visuals")
ui.NewButton("Chams","Chams","Visuals")

ui.CreateLib("Bypasses",themes.sky) 
ui.NewButton("BadSemiACBypasser","ACBypasser","Bypasses")
ui.CreateNotification("Rise","Rise Public is discontinued because am lazy lol | dm Spring67#6969 if u want to have a chance at private",3)
