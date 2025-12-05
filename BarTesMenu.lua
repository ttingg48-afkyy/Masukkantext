-- DraggableMenu.local.lua
-- LocalScript: membuat UI 'BaraLeaks' style, draggable, minimize, toggle rows.
-- GANTI owner avatar id di bawah dengan decal asset id yang lo upload di Roblox (angka tanpa "rbxassetid://")
-- Gambar model link tanpa id
local OWNER_AVATAR_URL = "https://imgur.com/a/oaWMMf7.png"
local MAIN_PIC_URL = "https://imgur.com/a/oaWMMf7.png"
local USE_MAIN_PIC = false

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Utility: create instance
local function new(class, props)
    local obj = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k == "Parent" then
                obj.Parent = v
            else
                obj[k] = v
            end
        end
    end
    return obj
end

-- Root ScreenGui
local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "BaraLeaksUI", ResetOnSpawn = false})
screenGui.DisplayOrder = 999

-- Main container (frame that looks like window)
local window = new("Frame", {
    Parent = screenGui,
    Name = "Window",
    AnchorPoint = Vector2.new(0.5,0.5),
    Position = UDim2.new(0.5, 0.5, 0.5, 0), -- center-ish
    Size = UDim2.new(0, 820, 0, 380),
    BackgroundColor3 = Color3.fromRGB(45,45,45),
    BorderSizePixel = 0,
    BackgroundTransparency = 0,
    ClipsDescendants = false,
})
window.AnchorPoint = Vector2.new(0.5, 0.5)

-- Rounded look
local corner = new("UICorner", {Parent = window, CornerRadius = UDim.new(0, 16)})

-- Top bar
local topBar = new("Frame", {
    Parent = window, Name = "Top", Size = UDim2.new(1,0,0,64), Position = UDim2.new(0,0,0,0),
    BackgroundColor3 = Color3.fromRGB(36,36,36), BorderSizePixel = 0
})
new("UICorner",{Parent = topBar, CornerRadius = UDim.new(0,16)})

local title = new("TextLabel", {
    Parent = topBar, Name = "Title", Text = "BaraLeaks | Owner Tampan",
    Position = UDim2.new(0, 72, 0, 10), Size = UDim2.new(0.7,0,1, -10),
    BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(245,245,245),
    Font = Enum.Font.GothamBlack, TextSize = 30, TextXAlignment = Enum.TextXAlignment.Left
})

-- avatar small on top-left
local avatarWrap = new("Frame", {Parent = topBar, Name="AvatarWrap", Size = UDim2.new(0,64,0,64), Position = UDim2.new(0,8,0,0), BackgroundTransparency = 1})
local avatar = new("ImageLabel", {
    Parent = avatarWrap, Name = "Avatar", Size = UDim2.new(1,0,1,0),
    BackgroundColor3 = Color3.fromRGB(65,65,65), BorderSizePixel = 0, Image = OWNER_AVATAR_URL,
    ScaleType = Enum.ScaleType.Crop
})
new("UICorner",{Parent = avatar, CornerRadius = UDim.new(0,10)})

-- minimize and close buttons (top-right)
local closeBtn = new("TextButton", {Parent = topBar, Name = "Close", Text = "X", Size = UDim2.new(0,48,0,40), Position = UDim2.new(1,-60,0,10), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.GothamBold, TextSize = 24})
local minBtn = new("TextButton", {Parent = topBar, Name = "Min", Text = "—", Size = UDim2.new(0,48,0,40), Position = UDim2.new(1,-110,0,10), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.GothamBold, TextSize = 24})

-- Body area (grid-like)
local body = new("Frame", {Parent = window, Name="Body", Position = UDim2.new(0,0,0,64), Size = UDim2.new(1,0,1,-64), BackgroundTransparency = 1})

-- left column labels
local leftCol = new("Frame",{Parent = body, Name="LeftCol", Position = UDim2.new(0,0,0,0), Size = UDim2.new(0,0,0,1,0)})
-- we'll create rows dynamically
local ROW_COUNT = 6
local rowHeight = 1/ROW_COUNT

local rows = {}

for i=1,ROW_COUNT do
    local r = new("Frame", {
        Parent = body, Name = "Row"..i,
        Position = UDim2.new(0, 0, (i-1)/ROW_COUNT, 0),
        Size = UDim2.new(0.35, 0, 1/ROW_COUNT, 0),
        BackgroundColor3 = Color3.fromRGB(50,50,50),
        BorderSizePixel = 0
    })
    new("UICorner",{Parent = r, CornerRadius = UDim.new(0,0)})
    local labelText = (i==1) and "Feature" or (i==2 and "Info Owner" or "Coming Soon")
    local t = new("TextLabel", {
        Parent = r, Name = "Label", Text = labelText,
        Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0,12,0,0),
        BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(245,245,245),
        Font = Enum.Font.Gotham, TextSize = 28, TextXAlignment = Enum.TextXAlignment.Left
    })
    -- separator lines
    local sep = new("Frame",{Parent = body, BackgroundColor3 = Color3.new(1,1,1), BackgroundTransparency = 0.85, Size = UDim2.new(1,0,0,1), Position = UDim2.new(0,0,(i-1)/ROW_COUNT, 0)})
    rows[i] = r
end

-- right content column
local content = new("Frame", {Parent = body, Name = "Content", Position = UDim2.new(0.35,0,0,0), Size = UDim2.new(0.65,0,1,0), BackgroundTransparency = 1})

-- header top of content
local contentHeader = new("TextLabel", {Parent = content, Text = "List Feature Yang Akan Segera Datang", Size = UDim2.new(1,0,0,64), Position = UDim2.new(0,0,0,0), BackgroundTransparency = 1, Font = Enum.Font.FreightSans, TextSize = 28, TextColor3 = Color3.fromRGB(240,240,240), TextXAlignment = Enum.TextXAlignment.Center})
-- create cells corresponding to rows
local contentCells = {}
for i=1,ROW_COUNT do
    local y = (i-1)/ROW_COUNT
    local cell = new("Frame", {Parent = content, Name = "Cell"..i, Position = UDim2.new(0,0,y,64), Size = UDim2.new(1,0,1/ROW_COUNT, -64), BackgroundColor3 = Color3.fromRGB(70,70,70)})
    new("UICorner",{Parent=cell, CornerRadius = UDim.new(0,0)})
    local txt = new("TextLabel", {Parent = cell, Name = "Text", Size = UDim2.new(0.85,-20,1,0), Position = UDim2.new(0.05,0,0,0), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(250,250,250), Font = Enum.Font.GothamSemibold, TextSize = 22, TextXAlignment = Enum.TextXAlignment.Center})
    if i == 2 then
        txt.Text = "Owner"
        txt.Font = Enum.Font.GothamBold
        txt.TextSize = 24
    else
        txt.Text = "Segera Hadir"
        txt.Font = Enum.Font.Gotham
        txt.TextSize = 22
    end

    -- small arrow indicator to right
    local arrow = new("TextLabel", {Parent = cell, Text = "V", Size = UDim2.new(0,32,0,32), Position = UDim2.new(1,-36,0.5,-16), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 24, TextColor3 = Color3.fromRGB(245,245,245)})
    contentCells[i] = {frame = cell, text = txt, arrow = arrow}
end

-- popup for detailed owner info (hidden)
local popup = new("Frame", {Parent = window, Name = "Popup", Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), BackgroundColor3 = Color3.fromRGB(80,80,80), Visible = false})
new("UICorner",{Parent=popup, CornerRadius = UDim.new(0,6)})
local popupImg = new("ImageLabel", {Parent = popup, Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.05,0,0.1,0), Image = "rbxassetid://"..OWNER_AVATAR_ID, BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop})
local popupTitle = new("TextLabel", {Parent = popup, Text = "Logo Bara Leaks Script\nFist it", Font = Enum.Font.FreightSans, TextSize = 24, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, Position = UDim2.new(0.3,0,0.1,0), Size = UDim2.new(0.65,0,0.2,0)})
local popupDev = new("TextLabel", {Parent = popup, Text = "Developer : Bara Tamvan", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = Color3.fromRGB(255,102,255), BackgroundTransparency = 1, Position = UDim2.new(0.05,0,0.4,0), Size = UDim2.new(0.9,0,0.12,0)})
local popupTeam = new("TextLabel", {Parent = popup, Text = "Team : BarLens Studio", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = Color3.fromRGB(50,255,100), BackgroundTransparency = 1, Position = UDim2.new(0.05,0,0.55,0), Size = UDim2.new(0.9,0,0.12,0)})

-- dragging implementation
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        -- do nothing here; movement handled in MoveListener
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        -- convert delta (pixels) to scale relative to screen size
        local screen = workspace.CurrentCamera.ViewportSize
        local newX = startPos.X.Offset + delta.X
        local newY = startPos.Y.Offset + delta.Y
        window.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- minimize/close behaviors
local isMin = false
local originalSize = window.Size
minBtn.MouseButton1Click:Connect(function()
    if not isMin then
        -- minimize to thin bar
        TweenService:Create(window, TweenInfo.new(0.25), {Size = UDim2.new(0, 300, 0, 64)}):Play()
        isMin = true
    else
        TweenService:Create(window, TweenInfo.new(0.25), {Size = originalSize}):Play()
        isMin = false
    end
end)
closeBtn.MouseButton1Click:Connect(function()
    window:Destroy()
    screenGui:Destroy()
end)

-- toggle for Info Owner row (row 2)
local infoOpen = false
local infoIndex = 2
contentCells[infoIndex].frame.Active = true
contentCells[infoIndex].frame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        infoOpen = not infoOpen
        if infoOpen then
            -- expand popup area (show popup)
            popup.Visible = true
            popup.Size = UDim2.new(0, 420, 0, 240)
            popup.Position = UDim2.new(0.5, -210, 0.5, -120)
            popupImg.Size = UDim2.new(0,80,0,80)
            popupImg.Image = OWNER_AVATAR_URL
        else
            popup.Visible = false
            popup.Size = UDim2.new(0,0,0,0)
        end
    end
end)

-- For other Coming Soon rows: clicking toggles a large grey panel with "Segera Hadir"
for i=1,ROW_COUNT do
    if i ~= infoIndex then
        local cell = contentCells[i].frame
        cell.Active = true
        cell.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                -- create temporary big panel inside content to show message
                local big = new("Frame", {Parent = content, Size = UDim2.new(0.9,0,0.6,0), Position = UDim2.new(0.05,0,0.2,0), BackgroundColor3 = Color3.fromRGB(90,90,90)})
                new("UICorner",{Parent=big, CornerRadius = UDim.new(0,6)})
                local bigTxt = new("TextLabel", {Parent = big, Text = "Segera Hadir", Font = Enum.Font.GothamBlack, TextSize = 48, Size = UDim2.new(1, -20, 1, -20), Position = UDim2.new(0,10,0,10), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255,255,255), TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center})
                delay(1.6, function()
                    if big and big.Parent then
                        big:Destroy()
                    end
                end)
            end
        end)
    end
end

-- make Content cells visually separated by vertical lines
local sepVert = new("Frame", {Parent = window, Size = UDim2.new(0,2,1, -64), Position = UDim2.new(0.35,0,0,64), BackgroundColor3 = Color3.fromRGB(255,255,255)})
sepVert.BorderSizePixel = 0

-- optional main picture (big behind content)
if USE_MAIN_PIC then
    local bigImage = new("ImageLabel", {Parent = content, Size = UDim2.new(0.5,0,1, -64), Position = UDim2.new(0.05,0,0,64), Image = "rbxassetid://"..MAIN_PIC_ID, BackgroundTransparency = 0.2, ScaleType = Enum.ScaleType.Crop})
    new("UICorner", {Parent = bigImage, CornerRadius = UDim.new(0,6)})
end

-- final: place window at good starting position (centered horizontally, 40% from top)
window.Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.4, 0)
