-- BaraLeaks FIX WINDOW VERSION (Not Fullscreen)
-- By ChatGPT for Bara Tamvan ❤️

local OWNER_AVATAR_URL = "https://i.imgur.com/oaWMMf7.png"
local MAIN_PIC_URL = "https://i.imgur.com/oaWMMf7.png"
local USE_MAIN_PIC = false

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

------------------------------------------------------------------

local function new(class, props)
    local o = Instance.new(class)
    if props then for k,v in pairs(props) do o[k] = v end end
    return o
end

local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "BaraLeaksUI", ResetOnSpawn = false})

local window = new("Frame", {
    Parent = screenGui,
    Name = "Window",
    Size = UDim2.new(0, 820, 0, 380),
    Position = UDim2.new(0.5, -410, 0.4, 0),
    BackgroundColor3 = Color3.fromRGB(45,45,45),
})
new("UICorner", {Parent = window, CornerRadius = UDim.new(0,16)})

--------------------------------------------------------
-- TOP BAR
--------------------------------------------------------
local topBar = new("Frame", {
    Parent = window,
    Size = UDim2.new(1,0,0,64),
    BackgroundColor3 = Color3.fromRGB(36,36,36)
})
new("UICorner",{Parent = topBar, CornerRadius = UDim.new(0,16)})

local avatar = new("ImageLabel", {
    Parent = topBar,
    Size = UDim2.new(0,58,0,58),
    Position = UDim2.new(0,8,0,3),
    Image = OWNER_AVATAR_URL,
    BackgroundTransparency = 1,
    ScaleType = Enum.ScaleType.Crop
})
new("UICorner",{Parent = avatar, CornerRadius = UDim.new(0,12)})

local title = new("TextLabel", {
    Parent = topBar,
    Text = "BaraLeaks | Owner Tampan",
    BackgroundTransparency = 1,
    Position = UDim2.new(0,80,0,10),
    Size = UDim2.new(1,-150,1,-10),
    TextColor3 = Color3.fromRGB(240,240,240),
    Font = Enum.Font.GothamBlack,
    TextSize = 30,
    TextXAlignment = Enum.TextXAlignment.Left
})

local closeBtn = new("TextButton", {
    Parent = topBar, Text="X", Size=UDim2.new(0,50,0,40),
    Position = UDim2.new(1,-55,0,12),
    BackgroundTransparency=1,
    TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 26
})

local minBtn = new("TextButton", {
    Parent = topBar, Text="—", Size=UDim2.new(0,50,0,40),
    Position = UDim2.new(1,-110,0,12),
    BackgroundTransparency=1,
    TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 26
})

--------------------------------------------------------
-- BODY
--------------------------------------------------------

local body = new("Frame", {
    Parent = window,
    Position = UDim2.new(0,0,0,64),
    Size = UDim2.new(1,0,1,-64),
    BackgroundTransparency = 1
})

local ROWS = {
    "Feature",
    "Info Owner",
    "Coming Soon",
    "Coming Soon",
    "Coming Soon",
    "Coming Soon"
}

local leftWidth = 0.33
local rowsFrames = {}
local contentCells = {}

for i=1,6 do
    local y = (i-1)*(1/6)

    -- left
    local left = new("Frame", {
        Parent = body,
        Position = UDim2.new(0,0,y,0),
        Size = UDim2.new(leftWidth,0,1/6,0),
        BackgroundColor3 = Color3.fromRGB(50,50,50)
    })
    new("UICorner",{Parent=left,CornerRadius=UDim.new(0,4)})

    new("TextLabel", {
        Parent = left,
        Text = ROWS[i],
        BackgroundTransparency = 1,
        Position = UDim2.new(0,12,0,0),
        Size = UDim2.new(1,-12,1,0),
        TextColor3 = Color3.fromRGB(240,240,240),
        Font = Enum.Font.Gotham,
        TextSize = 26,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- right cell
    local right = new("Frame", {
        Parent = body,
        Position = UDim2.new(leftWidth,0,y,0),
        Size = UDim2.new(1-leftWidth,0,1/6,0),
        BackgroundColor3 = Color3.fromRGB(70,70,70)
    })
    new("UICorner",{Parent=right,CornerRadius=UDim.new(0,4)})

    local txt = new("TextLabel", {
        Parent = right,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.85,0,1,0),
        Position = UDim2.new(0.05,0,0,0),
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 22,
        Font = Enum.Font.GothamSemibold,
        Text = (i==2) and "Owner" or "Segera Hadir"
    })

    local arrow = new("TextLabel",{
        Parent = right,
        Text = "V",
        BackgroundTransparency = 1,
        Size = UDim2.new(0,32,0,32),
        Position = UDim2.new(1,-36,0.5,-16),
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamBold,
        TextSize = 24
    })

    contentCells[i] = {frame = right}
end

--------------------------------------------------------
-- POPUP OWNER
--------------------------------------------------------

local popup = new("Frame", {
    Parent = window,
    Size = UDim2.new(0,0,0,0),
    BackgroundColor3 = Color3.fromRGB(90,90,90),
    Visible = false
})
new("UICorner",{Parent=popup,CornerRadius=UDim.new(0,8)})

local popupImg = new("ImageLabel", {
    Parent = popup,
    Size = UDim2.new(0,80,0,80),
    Position = UDim2.new(0.05,0,0.1,0),
    BackgroundTransparency = 1,
    Image = OWNER_AVATAR_URL,
    ScaleType = Enum.ScaleType.Crop
})
new("UICorner",{Parent=popupImg,CornerRadius=UDim.new(0,10)})

new("TextLabel", {
    Parent = popup,
    Text = "Logo Bara Leaks Script\nFist it",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.3,0,0.1,0),
    Size = UDim2.new(0.65,0,0.2,0),
    Font = Enum.Font.GothamBold,
    TextSize = 24,
    TextColor3 = Color3.new(1,1,1)
})

--------------------------------------------------------
-- DRAGGING
--------------------------------------------------------

local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos

topBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = window.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        window.Position = startPos + UDim2.new(0, d.X, 0, d.Y)
    end
end)

topBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

--------------------------------------------------------
-- MINIMIZE / CLOSE
--------------------------------------------------------

local isMin = false
local originalSize = window.Size

minBtn.MouseButton1Click:Connect(function()
    if not isMin then
        TweenService:Create(window,TweenInfo.new(.25),{Size = UDim2.new(0,300,0,64)}):Play()
    else
        TweenService:Create(window,TweenInfo.new(.25),{Size = originalSize}):Play()
    end
    isMin = not isMin
end)

closeBtn.MouseButton1Click:Connect(function()
    window:Destroy()
    screenGui:Destroy()
end)

--------------------------------------------------------
-- TOGGLE INFO OWNER
--------------------------------------------------------

local open = false
contentCells[2].frame.InputBegan:Connect(function(i)
    if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    open = not open

    if open then
        popup.Visible = true
        popup.Size = UDim2.new(0,420,0,240)
        popup.Position = UDim2.new(0.5,-210,0.5,-120)
    else
        popup.Visible = false
    end
end)

--------------------------------------------------------
-- COMING SOON POP PANEL
--------------------------------------------------------

for i=1,6 do
    if i ~= 2 then
        contentCells[i].frame.InputBegan:Connect(function(inp)
            if inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
            local big = new("Frame", {
                Parent = window,
                BackgroundColor3 = Color3.fromRGB(85,85,85),
                Size = UDim2.new(0,500,0,200),
                Position = UDim2.new(0.5,-250,0.5,-100)
            })
            new("UICorner",{Parent=big,CornerRadius=UDim.new(0,8)})

            new("TextLabel", {
                Parent = big,
                Text = "Segera Hadir",
                BackgroundTransparency = 1,
                Size = UDim2.new(1,0,1,0),
                Font = Enum.Font.GothamBlack,
                TextSize = 50,
                TextColor3 = Color3.new(1,1,1)
            })

            task.delay(1.4, function()
                if big then big:Destroy() end
            end)
        end)
    end
end

--------------------------------------------------------

-- OPTIONAL BACKGROUND MAIN PICTURE
if USE_MAIN_PIC then
    local bg = new("ImageLabel", {
        Parent = body,
        Image = MAIN_PIC_URL,
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 0.2,
        ScaleType = Enum.ScaleType.Crop
    })
end
