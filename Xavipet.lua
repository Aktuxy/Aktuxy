flocal Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.Position = UDim2.new(0.5, -175, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Rounded Corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Rainbow Border Effect
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3  
UIStroke.Parent = Frame

local function animateRainbow()
    while true do
        for hue = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(hue, 1, 1)  
            task.wait(0.05)  
        end
    end
end

task.spawn(animateRainbow)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleText = Instance.new("TextLabel")
TitleText.Text = "Pet Spawner V4       by Xavi Scripts"
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

-- Input Box
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0.25, 0)
TextBox.PlaceholderText = "Enter Pet Name"
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.Parent = Frame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = TextBox

-- Pet Type Selection
local petType = "FR"  

local function createTypeButton(name, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.25, 0, 0, 30)
    button.Position = UDim2.new(position, 0, 0.45, 0)
    button.Text = name
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = Frame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = button

    button.MouseButton1Click:Connect(function()
        petType = name
        Feedback.Text = "Selected: " .. name
        Feedback.TextColor3 = Color3.fromRGB(255, 255, 0)
    end)

    return button
end

local MFRButton = createTypeButton("MFR", 0.1, Color3.fromRGB(255, 100, 100))
local NFRButton = createTypeButton("NFR", 0.4, Color3.fromRGB(100, 255, 100))
local FRButton = createTypeButton("FR", 0.7, Color3.fromRGB(100, 100, 255))

-- Duplicate Button
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8, 0, 0, 40)
Button.Position = UDim2.new(0.1, 0, 0.65, 0)
Button.Text = "Duplicate Pet"
Button.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Button.Parent = Frame

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 8)
UICorner3.Parent = Button

-- Feedback Text
local Feedback = Instance.new("TextLabel")
Feedback.Size = UDim2.new(1, 0, 0, 30)
Feedback.Position = UDim2.new(0, 0, 0.85, 0)
Feedback.BackgroundTransparency = 1
Feedback.Text = ""
Feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
Feedback.Font = Enum.Font.Gotham
Feedback.TextSize = 14
Feedback.Parent = Frame

-- FUNCTION TO DUPLICATE PET
local function duplicatePet(petName)
    local Loads = require(game.ReplicatedStorage.Fsys).load
    local ClientData = Loads("ClientData")
    local InventoryDB = Loads("InventoryDB")
    local Inventory = ClientData.get("inventory")

    local function generate_prop()
        return {
            flyable = true,
            rideable = true,
            neon = petType == "NFR" or petType == "MFR",
            mega_neon = petType == "MFR",
            age = 1
        }
    end

    local function cloneTable(original)
        local copy = {}
        for key, value in pairs(original) do
            if type(value) == "table" then
                copy[key] = cloneTable(value)
            else
                copy[key] = value
            end
        end
        return copy
    end

    for category_name, category_table in pairs(InventoryDB) do
        for id, item in pairs(category_table) do
            if category_name == "pets" and item.name == petName then
                local fake_uuid = game.HttpService:GenerateGUID()
                local n_item = cloneTable(item)

                n_item["unique"] = "uuid_" .. fake_uuid
                n_item["category"] = "pets"
                n_item["properties"] = generate_prop()
                n_item["newness_order"] = math.random(1, 900000)

                if not Inventory[category_name] then
                    Inventory[category_name] = {}
                end

                Inventory[category_name][fake_uuid] = n_item

                Feedback.Text = "✅ Pet Duplicated: " .. petName .. " (" .. petType .. ")"
                Feedback.TextColor3 = Color3.fromRGB(0, 255, 0)

                game.StarterGui:SetCore("SendNotification", {
                    Title = "Pet Duplicated!";
                    Text = petName .. " (" .. petType .. ") has been spawned!";
                    Duration = 5;
                })

                return
            end
        end
    end

    Feedback.Text = "❌ Pet Not Found: " .. petName
    Feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
end

-- BUTTON CLICK EVENT
Button.MouseButton1Click:Connect(function()
    local petName = TextBox.Text
    if petName and petName ~= "" then
        duplicatePet(petName)
    else
        Feedback.Text = "❌ Please enter a pet name."
        Feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
