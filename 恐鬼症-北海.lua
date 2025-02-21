--只有被开源才能成长 by 冷
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "恐鬼症 1.2.1  [停更]",
   Icon = 0,
   LoadingTitle = "恐鬼症 1.2.1  [停更]",
   LoadingSubtitle = "by 北海",
   Theme = "DarkBlue",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   KeySystem = true,
   KeySettings = {
      Title = "恐鬼症 1.2.1  [停更]",
      Subtitle = "验证系统",
      Note = "北海二改使用版:卡密beihai",
      FileName = "horror",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"beihai"}
   }
})

--函数
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace:GetDescendants()
local Workspace1 = game:GetService("Workspace")
--函数

--锁定函数
local GhostLock = true
--锁定函数

--初始化诅咒道具透视函数
local Cursed = {}
for _, CursedSpawns in ipairs(Workspace) do
	if CursedSpawns:IsA("Model") and CursedSpawns.Name == "Ouija Board" then
		Cursed = CursedSpawns
	end
	if CursedSpawns:IsA("Model") and CursedSpawns.Name == "SummoningCircle" then
		Cursed = CursedSpawns
	end
	if CursedSpawns:IsA("Tool") and CursedSpawns.Name == "Tarot Cards" then
		Cursed = CursedSpawns
	end
end
--初始化诅咒道具透视函数

--初始化互动透视
local EMFBillboardGuiDescendantAdded
function EMFBillboardGui(descendant)
	if descendant:IsA("Part") and descendant.Name == "EMFPart" then
		local BillboardGui = Instance.new("BillboardGui")
		local TextLabel = Instance.new("TextLabel")

        BillboardGui.Name = "EMFBillboardGui"
		BillboardGui.Parent = descendant
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 40, 0, 20)

        TextLabel.Parent = BillboardGui
		TextLabel.Text = "互动"
        TextLabel.BackgroundTransparency = 1
		TextLabel.Size = UDim2.new(0, 40, 0, 20)
        TextLabel.TextColor3 = Color3.fromRGB(70, 255, 0)
		TextLabel.TextSize = 10
	end
end
--初始化互动透视

local Function = Window:CreateTab("功能", "book-check")

--证据
local Section = Function:CreateSection("证据")
local EMFCountLabel = Function:CreateParagraph({Title = "互动(电磁场读取)", Content = "出现次数:未知"})
local Thermometer = Function:CreateParagraph({Title = "冻结温度(一直获取 = 没有冻结温度)", Content = "获取中..."})
local Ouijabox = Function:CreateParagraph({Title = "精灵盒(道具需要在鬼房)", Content = "捕捉中..."})
--证据

--玩家
local Section = Function:CreateSection("玩家")
local Collision = Function:CreateToggle({
    Name = "穿门",
    CurrentValue = false,
    Flag = "切换按钮",
    Callback = function(Value)
        for _, Doors in ipairs(Workspace) do
            if Doors:IsA("Folder") and Doors.Name == "Doors" then
            local ModelDoors = Doors:GetDescendants()
		        for _, ModelDoor in ipairs(ModelDoors) do
		            if ModelDoor:IsA("MeshPart") or ModelDoor:IsA("Part") then
			            if ModelDoor.Name == "RightDoor" or ModelDoor.Name == "LeftDoor" or ModelDoor.Name == "Door"  then
					        if ModelDoor.CanCollide then
						        ModelDoor.CanCollide = false
					        	else
					            ModelDoor.CanCollide = true
					        end
			        	end
		        	end
		        end
            end
        end
    end,
})
local Light = Function:CreateButton({
    Name = "夜视",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.Atmosphere:Destroy()
    end,
})
local SpeedPlayer = Function:CreateToggle({
   Name = "稳定速度+无限体力(BUG利用)",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if Value then
            for _, LocalPlayer in ipairs(LocalPlayer:GetChildren()) do
	            if LocalPlayer.Name == "Dead" then
					LocalPlayer.Value = true
	            end
            end
            Rayfield:Notify({
               Title = "告知",
                Content = "开启后加速无法关闭，除非游戏重置移动数度",
                Duration = 5,
                Image = "triangle-alert",
            })
			else
            for _, LocalPlayer in ipairs(LocalPlayer:GetChildren()) do
	            if LocalPlayer.Name == "Dead" then
					LocalPlayer.Value = false
	            end
            end
		end
   end,
})
--玩家

--透视
local Section = Function:CreateSection("透视")
local Ghost = Function:CreateToggle({
   Name = "幽灵",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if GhostLock then
            GhostLock = false
            GhostESP()
            else
            GhostLock = true
        end
   end,
})
local EMF = Function:CreateToggle({
   Name = "互动",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if Value then
			EMFBillboardGuiDescendantAdded = workspace.Map.DescendantAdded:Connect(EMFBillboardGui)
			else
			EMFBillboardGuiDescendantAdded:Disconnect()
		end
   end,
})
local Cursed = Function:CreateToggle({
   Name = "诅咒道具",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if Value then
			local CursedHighlight = Cursed:FindFirstChild("CursedESP")
            if not CursedHighlight then
	            local Highlight = Instance.new("Highlight")
                Highlight.Name = "CursedESP"
                Highlight.Parent = Cursed
                Highlight.FillTransparency = 1
                Highlight.OutlineColor = Color3.fromRGB(255, 170, 127)
                Highlight.OutlineTransparency = 0.2
            end
			else
			local CursedHighlightDestroy = Cursed:FindFirstChild("CursedESP")
            if CursedHighlightDestroy then
				CursedHighlightDestroy:Destroy()
			end
		end
   end,
})
local VoodooDoll = Function:CreateToggle({
   Name = "巫毒娃娃",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if Value then
			local VoodooDoll = Workspace1.VoodooDoll
            local VoodooDollHighlightRepeat = VoodooDoll:FindFirstChild("VoodooDollESP")
            if not VoodooDollHighlightRepeat then
                local Highlight = Instance.new("Highlight")
                Highlight.Name = "VoodooDollESP"
                Highlight.Parent = VoodooDoll
                Highlight.FillTransparency = 1
                Highlight.OutlineColor = Color3.fromRGB(0,255,255)
                Highlight.OutlineTransparency = 0.5
            end
			else
			local VoodooDollDestroy = Workspace1.VoodooDoll
            local VoodooDollHighlightRepeatDestroy = VoodooDollDestroy:FindFirstChild("VoodooDollESP")
            if VoodooDollHighlightRepeatDestroy then
				VoodooDollHighlightRepeatDestroy:Destroy()
			end
		end
   end,
})
local Generators = Function:CreateToggle({
   Name = "发电机",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if Value then
            local Generators = Workspace1.Map.Generators.GeneratorMesh
            local GeneratorsHighlightRepeat = Generators:FindFirstChild("GeneratorsESP")
        