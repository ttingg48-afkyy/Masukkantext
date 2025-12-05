--========================================================--
--            Tes | Baleg Moal - Hacker UI                --
--                    Developer: Bara Setiawan            --
--========================================================--

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BalegMoal_UI"

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 380)
Main.Position = UDim2.new(0, 20, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Tes Script | Baleg Moal"
Title.TextColor3 = Color3.fromRGB(50, 255, 60)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 22

-- Developer INFO button
local DevBtn = Instance.new("TextButton", Main)
DevBtn.Size = UDim2.new(0, 40, 0, 30)
DevBtn.Position = UDim2.new(1, -45, 0, 5)
DevBtn.Text = "©"
DevBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 70)
DevBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
DevBtn.Font = Enum.Font.Code
DevBtn.TextSize = 20

local DevCorner = Instance.new("UICorner", DevBtn)
DevCorner.CornerRadius = UDim.new(0, 6)

-- Developer Page
local DevPage = Instance.new("Frame", Main)
DevPage.Size = UDim2.new(1, -20, 0, 70)
DevPage.Position = UDim2.new(0, 10, 0, -80) -- hidden
DevPage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DevPage.BorderSizePixel = 0
DevPage.Visible = false
Instance.new("UICorner", DevPage)

local Dev1 = Instance.new("TextLabel", DevPage)
Dev1.Text = "Developer : Bara Setiawan"
Dev1.TextColor3 = Color3.fromRGB(255, 40, 40)
Dev1.Position = UDim2.new(0, 10, 0, 5)
Dev1.Size = UDim2.new(1, -20, 0, 25)
Dev1.BackgroundTransparency = 1
Dev1.Font = Enum.Font.Code
Dev1.TextSize = 16

local Dev2 = Instance.new("TextLabel", DevPage)
Dev2.Text = "TEAM : Barlens Studio"
Dev2.TextColor3 = Color3.fromRGB(40, 255, 50)
Dev2.Position = UDim2.new(0, 10, 0, 35)
Dev2.Size = UDim2.new(1, -20, 0, 25)
Dev2.BackgroundTransparency = 1
Dev2.Font = Enum.Font.Code
Dev2.TextSize = 16

-- Toggle Developer Info
local DevOpen = false
DevBtn.MouseButton1Click:Connect(function()
	DevOpen = not DevOpen

	if DevOpen then
		DevPage.Visible = true
		DevPage:TweenPosition(UDim2.new(0, 10, 0, 45), "Out", "Quad", .3)
	else
		DevPage:TweenPosition(UDim2.new(0, 10, 0, -80), "Out", "Quad", .3)
		wait(.3)
		DevPage.Visible = false
	end
end)

-- Menu List
local MenuList = {
	"Main",
	"Shop",
	"Teleport",
	"Config",
	"Settings"
}

local Y = 100

for _, name in ipairs(MenuList) do
	local B = Instance.new("TextButton", Main)
	B.Size = UDim2.new(1, -20, 0, 35)
	B.Position = UDim2.new(0, 10, 0, Y)
	B.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	B.TextColor3 = Color3.fromRGB(0, 255, 120)
	B.Text = name
	B.Font = Enum.Font.Code
	B.TextSize = 20
	Instance.new("UICorner", B)

	B.MouseButton1Click:Connect(function()
		game.StarterGui:SetCore("SendNotification",{
			Title = name,
			Text = name.." — Coming Soon"
		})
	end)

	Y = Y + 42
end