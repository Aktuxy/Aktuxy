-- Menü oluşturma (aynı)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Text = "Pet Spawner V"
TitleLabel.TextScaled = true

local PetNameTextBox = Instance.new("TextBox")
PetNameTextBox.Parent = MainFrame
PetNameTextBox.Size = UDim2.new(1, 0, 0, 30)
PetNameTextBox.Position = UDim2.new(0, 0, 0.2, 0)
PetNameTextBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PetNameTextBox.TextColor3 = Color3.new(1, 1, 1)
PetNameTextBox.Text = "Frost Dragon" -- Varsayılan evcil hayvan adı

local MFRButton = Instance.new("TextButton")
MFRButton.Parent = MainFrame
MFRButton.Size = UDim2.new(0.25, 0, 0, 30)
MFRButton.Position = UDim2.new(0.05, 0, 0.4, 0)
MFRButton.BackgroundColor3 = Color3.new(1, 0.5, 0)
MFRButton.TextColor3 = Color3.new(1, 1, 1)
MFRButton.Text = "MFR"

local NFRButton = Instance.new("TextButton")
NFRButton.Parent = MainFrame
NFRButton.Size = UDim2.new(0.25, 0, 0, 30)
NFRButton.Position = UDim2.new(0.375, 0, 0.4, 0)
NFRButton.BackgroundColor3 = Color3.new(0, 1, 0)
NFRButton.TextColor3 = Color3.new(1, 1, 1)
NFRButton.Text = "NFR"

local FRButton = Instance.new("TextButton")
FRButton.Parent = MainFrame
FRButton.Size = UDim2.new(0.25, 0, 0, 30)
FRButton.Position = UDim2.new(0.7, 0, 0.4, 0)
FRButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
FRButton.TextColor3 = Color3.new(1, 1, 1)
FRButton.Text = "FR"

local DuplicateButton = Instance.new("TextButton")
DuplicateButton.Parent = MainFrame
DuplicateButton.Size = UDim2.new(0.9, 0, 0, 30)
DuplicateButton.Position = UDim2.new(0.05, 0, 0.6, 0)
DuplicateButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
DuplicateButton.TextColor3 = Color3.new(1, 1, 1)
DuplicateButton.Text = "Duplicate Pet"

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatusLabel.TextColor3 = Color3.new(0, 1, 0)
StatusLabel.Text = ""
StatusLabel.TextScaled = true

-- Envanter işlevselliği (aynı)
local function addPetToInventory(petName, petRarity)
  local inventory = game.Players.LocalPlayer:FindFirstChild("Inventory")
  if not inventory then
    inventory = Instance.new("Folder")
    inventory.Name = "Inventory"
    inventory.Parent = game.Players.LocalPlayer
  end

  local newPet = Instance.new("StringValue")
  newPet.Name = petName
  newPet.Value = petRarity
  newPet.Parent = inventory

  StatusLabel.Text = "âœ... Pet Duplicated: " .. petName .. " (" .. petRarity .. ")"
end

-- Düğme işlevselliği
local selectedRarity = "FR" -- Varsayılan nadirlik

MFRButton.MouseButton1Click:Connect(function()
  selectedRarity = "MFR"
end)

NFRButton.MouseButton1Click:Connect(function()
  selectedRarity = "NFR"
end)

FRButton.MouseButton1Click:Connect(function()
  selectedRarity = "FR"
end)

DuplicateButton.MouseButton1Click:Connect(function()
  local petName = PetNameTextBox.Text
  addPetToInventory(petName, selectedRarity)
end)
