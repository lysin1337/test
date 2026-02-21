-- 💩 Poop GUI v2 - Sekmeli
-- Executor'a yapıştır ve çalıştır!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("PoopGUI") then
    PlayerGui.PoopGUI:Destroy()
end

local poopCount = 0
local minCount = 0
local maxCount = 100
local isDragging = false
local dragStart, startPos
local isOnCooldown = false
local isSending = false
local COOLDOWN = 4.0
local stepAmount = 1

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PoopGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- ─── INTRO ANİMASYONU ───
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundTransparency = 1
IntroFrame.BorderSizePixel = 0
IntroFrame.ZIndex = 100
IntroFrame.Parent = ScreenGui

local GlowFrame = Instance.new("Frame")
GlowFrame.Size = UDim2.new(0, 500, 0, 120)
GlowFrame.Position = UDim2.new(0.5, -250, 0.5, -60)
GlowFrame.BackgroundTransparency = 1
GlowFrame.BorderSizePixel = 0
GlowFrame.ZIndex = 100
GlowFrame.Parent = IntroFrame

local GlowLabel = Instance.new("TextLabel")
GlowLabel.Size = UDim2.new(1, 0, 1, 0)
GlowLabel.BackgroundTransparency = 1
GlowLabel.Text = "lysin1337"
GlowLabel.TextColor3 = Color3.fromRGB(74, 14, 143)
GlowLabel.TextTransparency = 0.85
GlowLabel.TextSize = 82
GlowLabel.Font = Enum.Font.GothamBlack
GlowLabel.ZIndex = 100
GlowLabel.Parent = GlowFrame

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "lysin1337"
IntroText.TextColor3 = Color3.fromRGB(74, 14, 143)
IntroText.TextTransparency = 1
IntroText.TextSize = 72
IntroText.Font = Enum.Font.GothamBlack
IntroText.ZIndex = 101
IntroText.Parent = GlowFrame

local UnderLine = Instance.new("Frame")
UnderLine.Size = UDim2.new(0, 0, 0, 3)
UnderLine.Position = UDim2.new(0.5, 0, 1, 8)
UnderLine.AnchorPoint = Vector2.new(0.5, 0)
UnderLine.BackgroundColor3 = Color3.fromRGB(130, 70, 200)
UnderLine.BackgroundTransparency = 1
UnderLine.BorderSizePixel = 0
UnderLine.ZIndex = 101
UnderLine.Parent = GlowFrame
Instance.new("UICorner", UnderLine).CornerRadius = UDim.new(0, 2)

-- ─── ANA FRAME ───
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 560)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 22, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
})
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

-- ─── BAŞLIK ÇUBUĞU ───
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 52)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 22, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(30, 22, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 70, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 45, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 25, 5))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

local TitleEmoji = Instance.new("TextLabel")
TitleEmoji.Size = UDim2.new(0, 40, 1, 0)
TitleEmoji.Position = UDim2.new(0, 12, 0, 0)
TitleEmoji.BackgroundTransparency = 1
TitleEmoji.Text = "💩"
TitleEmoji.TextSize = 22
TitleEmoji.Font = Enum.Font.GothamBold
TitleEmoji.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 52, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Poop Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 220, 150)
TitleLabel.TextSize = 17
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -42, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ─── SEKME ÇUBUĞU ───
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 58)
TabBar.BackgroundColor3 = Color3.fromRGB(18, 14, 26)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

-- Poop Sekmesi butonu
local PoopTabBtn = Instance.new("TextButton")
PoopTabBtn.Size = UDim2.new(0.5, -4, 1, -8)
PoopTabBtn.Position = UDim2.new(0, 4, 0, 4)
PoopTabBtn.BackgroundColor3 = Color3.fromRGB(101, 55, 0)
PoopTabBtn.Text = "💩 Poop"
PoopTabBtn.TextColor3 = Color3.fromRGB(255, 220, 150)
PoopTabBtn.TextSize = 14
PoopTabBtn.Font = Enum.Font.GothamBold
PoopTabBtn.BorderSizePixel = 0
PoopTabBtn.Parent = TabBar
Instance.new("UICorner", PoopTabBtn).CornerRadius = UDim.new(0, 8)

-- Character Sekmesi butonu
local CharTabBtn = Instance.new("TextButton")
CharTabBtn.Size = UDim2.new(0.5, -4, 1, -8)
CharTabBtn.Position = UDim2.new(0.5, 0, 0, 4)
CharTabBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 40)
CharTabBtn.Text = "🧍 Character"
CharTabBtn.TextColor3 = Color3.fromRGB(120, 100, 140)
CharTabBtn.TextSize = 14
CharTabBtn.Font = Enum.Font.GothamBold
CharTabBtn.BorderSizePixel = 0
CharTabBtn.Parent = TabBar
Instance.new("UICorner", CharTabBtn).CornerRadius = UDim.new(0, 8)

-- Divider
local Divider0 = Instance.new("Frame")
Divider0.Size = UDim2.new(1, -20, 0, 1)
Divider0.Position = UDim2.new(0, 10, 0, 102)
Divider0.BackgroundColor3 = Color3.fromRGB(139, 90, 43)
Divider0.BackgroundTransparency = 0.5
Divider0.BorderSizePixel = 0
Divider0.Parent = MainFrame

-- ─── POOP SEKME İÇERİĞİ ───
local PoopPage = Instance.new("Frame")
PoopPage.Size = UDim2.new(1, 0, 1, -108)
PoopPage.Position = UDim2.new(0, 0, 0, 108)
PoopPage.BackgroundTransparency = 1
PoopPage.BorderSizePixel = 0
PoopPage.Parent = MainFrame

-- Miktar başlığı
local CountLabel = Instance.new("TextLabel")
CountLabel.Size = UDim2.new(1, -40, 0, 26)
CountLabel.Position = UDim2.new(0, 20, 0, 8)
CountLabel.BackgroundTransparency = 1
CountLabel.Text = "Miktar"
CountLabel.TextColor3 = Color3.fromRGB(180, 140, 100)
CountLabel.TextSize = 13
CountLabel.Font = Enum.Font.GothamBold
CountLabel.TextXAlignment = Enum.TextXAlignment.Left
CountLabel.Parent = PoopPage

-- Sayaç frame
local CounterFrame = Instance.new("Frame")
CounterFrame.Size = UDim2.new(1, -40, 0, 60)
CounterFrame.Position = UDim2.new(0, 20, 0, 36)
CounterFrame.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
CounterFrame.BorderSizePixel = 0
CounterFrame.Parent = PoopPage
Instance.new("UICorner", CounterFrame).CornerRadius = UDim.new(0, 10)
local cs = Instance.new("UIStroke", CounterFrame)
cs.Color = Color3.fromRGB(139, 90, 43); cs.Transparency = 0.6; cs.Thickness = 1

local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 54, 1, -16)
MinusBtn.Position = UDim2.new(0, 8, 0, 8)
MinusBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 10)
MinusBtn.Text = "−"
MinusBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
MinusBtn.TextSize = 26
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.BorderSizePixel = 0
MinusBtn.Parent = CounterFrame
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 8)

local NumberDisplay = Instance.new("TextLabel")
NumberDisplay.Size = UDim2.new(1, -124, 1, 0)
NumberDisplay.Position = UDim2.new(0, 70, 0, 0)
NumberDisplay.BackgroundTransparency = 1
NumberDisplay.Text = "0"
NumberDisplay.TextColor3 = Color3.fromRGB(255, 230, 150)
NumberDisplay.TextSize = 28
NumberDisplay.Font = Enum.Font.GothamBold
NumberDisplay.Parent = CounterFrame

local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 54, 1, -16)
PlusBtn.Position = UDim2.new(1, -62, 0, 8)
PlusBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 10)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
PlusBtn.TextSize = 26
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.BorderSizePixel = 0
PlusBtn.Parent = CounterFrame
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 8)

-- Adım seçimi başlığı
local StepLabel = Instance.new("TextLabel")
StepLabel.Size = UDim2.new(1, -40, 0, 22)
StepLabel.Position = UDim2.new(0, 20, 0, 106)
StepLabel.BackgroundTransparency = 1
StepLabel.Text = "+ / − Adım Miktarı"
StepLabel.TextColor3 = Color3.fromRGB(180, 140, 100)
StepLabel.TextSize = 13
StepLabel.Font = Enum.Font.GothamBold
StepLabel.TextXAlignment = Enum.TextXAlignment.Left
StepLabel.Parent = PoopPage

-- Adım frame
local StepFrame = Instance.new("Frame")
StepFrame.Size = UDim2.new(1, -40, 0, 44)
StepFrame.Position = UDim2.new(0, 20, 0, 130)
StepFrame.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
StepFrame.BorderSizePixel = 0
StepFrame.Parent = PoopPage
Instance.new("UICorner", StepFrame).CornerRadius = UDim.new(0, 10)
local ss = Instance.new("UIStroke", StepFrame)
ss.Color = Color3.fromRGB(100, 70, 150); ss.Transparency = 0.5; ss.Thickness = 1

local Step1Btn = Instance.new("TextButton")
Step1Btn.Size = UDim2.new(0.33, -6, 1, -12)
Step1Btn.Position = UDim2.new(0, 6, 0, 6)
Step1Btn.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
Step1Btn.Text = "+1"
Step1Btn.TextColor3 = Color3.fromRGB(200, 255, 200)
Step1Btn.TextSize = 15
Step1Btn.Font = Enum.Font.GothamBold
Step1Btn.BorderSizePixel = 0
Step1Btn.Parent = StepFrame
Instance.new("UICorner", Step1Btn).CornerRadius = UDim.new(0, 7)

local Step5Btn = Instance.new("TextButton")
Step5Btn.Size = UDim2.new(0.33, -6, 1, -12)
Step5Btn.Position = UDim2.new(0.33, 3, 0, 6)
Step5Btn.BackgroundColor3 = Color3.fromRGB(40, 30, 10)
Step5Btn.Text = "+5"
Step5Btn.TextColor3 = Color3.fromRGB(255, 200, 100)
Step5Btn.TextSize = 15
Step5Btn.Font = Enum.Font.GothamBold
Step5Btn.BorderSizePixel = 0
Step5Btn.Parent = StepFrame
Instance.new("UICorner", Step5Btn).CornerRadius = UDim.new(0, 7)

local Step10Btn = Instance.new("TextButton")
Step10Btn.Size = UDim2.new(0.33, -6, 1, -12)
Step10Btn.Position = UDim2.new(0.66, 0, 0, 6)
Step10Btn.BackgroundColor3 = Color3.fromRGB(40, 30, 10)
Step10Btn.Text = "+10"
Step10Btn.TextColor3 = Color3.fromRGB(255, 200, 100)
Step10Btn.TextSize = 15
Step10Btn.Font = Enum.Font.GothamBold
Step10Btn.BorderSizePixel = 0
Step10Btn.Parent = StepFrame
Instance.new("UICorner", Step10Btn).CornerRadius = UDim.new(0, 7)

local StepIndicator = Instance.new("TextLabel")
StepIndicator.Size = UDim2.new(1, -40, 0, 18)
StepIndicator.Position = UDim2.new(0, 20, 0, 178)
StepIndicator.BackgroundTransparency = 1
StepIndicator.Text = "Seçili adım: +1"
StepIndicator.TextColor3 = Color3.fromRGB(150, 220, 150)
StepIndicator.TextSize = 12
StepIndicator.Font = Enum.Font.Gotham
StepIndicator.Parent = PoopPage

local RangeLabel = Instance.new("TextLabel")
RangeLabel.Size = UDim2.new(1, -40, 0, 18)
RangeLabel.Position = UDim2.new(0, 20, 0, 196)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "Min: 0  |  Max: 100"
RangeLabel.TextColor3 = Color3.fromRGB(100, 80, 60)
RangeLabel.TextSize = 12
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.Parent = PoopPage

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -40, 0, 18)
TimeLabel.Position = UDim2.new(0, 20, 0, 214)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "⏱ Tahmini süre: ~0.00s"
TimeLabel.TextColor3 = Color3.fromRGB(120, 100, 70)
TimeLabel.TextSize = 12
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.Parent = PoopPage

-- Divider 2
local Divider2 = Instance.new("Frame")
Divider2.Size = UDim2.new(1, -40, 0, 1)
Divider2.Position = UDim2.new(0, 20, 0, 238)
Divider2.BackgroundColor3 = Color3.fromRGB(139, 90, 43)
Divider2.BackgroundTransparency = 0.5
Divider2.BorderSizePixel = 0
Divider2.Parent = PoopPage

-- Cooldown başlığı
local CooldownSectionLabel = Instance.new("TextLabel")
CooldownSectionLabel.Size = UDim2.new(1, -40, 0, 26)
CooldownSectionLabel.Position = UDim2.new(0, 20, 0, 244)
CooldownSectionLabel.BackgroundTransparency = 1
CooldownSectionLabel.Text = "Kullanım Cooldown"
CooldownSectionLabel.TextColor3 = Color3.fromRGB(180, 140, 100)
CooldownSectionLabel.TextSize = 13
CooldownSectionLabel.Font = Enum.Font.GothamBold
CooldownSectionLabel.TextXAlignment = Enum.TextXAlignment.Left
CooldownSectionLabel.Parent = PoopPage

-- Cooldown frame
local CooldownFrame = Instance.new("Frame")
CooldownFrame.Size = UDim2.new(1, -40, 0, 52)
CooldownFrame.Position = UDim2.new(0, 20, 0, 272)
CooldownFrame.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
CooldownFrame.BorderSizePixel = 0
CooldownFrame.Parent = PoopPage
Instance.new("UICorner", CooldownFrame).CornerRadius = UDim.new(0, 10)

local CooldownStroke = Instance.new("UIStroke", CooldownFrame)
CooldownStroke.Color = Color3.fromRGB(80, 60, 120)
CooldownStroke.Transparency = 0.5
CooldownStroke.Thickness = 1

local CooldownLabel = Instance.new("TextLabel")
CooldownLabel.Size = UDim2.new(1, 0, 0, 22)
CooldownLabel.Position = UDim2.new(0, 0, 0, 4)
CooldownLabel.BackgroundTransparency = 1
CooldownLabel.Text = "✅ Hazır"
CooldownLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
CooldownLabel.TextSize = 13
CooldownLabel.Font = Enum.Font.GothamBold
CooldownLabel.Parent = CooldownFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(1, -16, 0, 10)
BarBg.Position = UDim2.new(0, 8, 0, 34)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 30, 55)
BarBg.BorderSizePixel = 0
BarBg.Parent = CooldownFrame
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 5)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(100, 220, 100)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 5)

-- Divider 3
local Divider3 = Instance.new("Frame")
Divider3.Size = UDim2.new(1, -40, 0, 1)
Divider3.Position = UDim2.new(0, 20, 0, 334)
Divider3.BackgroundColor3 = Color3.fromRGB(139, 90, 43)
Divider3.BackgroundTransparency = 0.5
Divider3.BorderSizePixel = 0
Divider3.Parent = PoopPage

-- Durum ve buton
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 26)
StatusLabel.Position = UDim2.new(0, 20, 0, 341)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Hazır!"
StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = PoopPage

local PoopBtn = Instance.new("TextButton")
PoopBtn.Size = UDim2.new(1, -40, 0, 72)
PoopBtn.Position = UDim2.new(0, 20, 0, 374)
PoopBtn.BackgroundColor3 = Color3.fromRGB(101, 55, 0)
PoopBtn.Text = "💩  Poop!"
PoopBtn.TextColor3 = Color3.fromRGB(255, 230, 150)
PoopBtn.TextSize = 22
PoopBtn.Font = Enum.Font.GothamBold
PoopBtn.BorderSizePixel = 0
PoopBtn.Parent = PoopPage
Instance.new("UICorner", PoopBtn).CornerRadius = UDim.new(0, 12)

local PoopGradient = Instance.new("UIGradient")
PoopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 90, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 40, 0))
})
PoopGradient.Rotation = 90
PoopGradient.Parent = PoopBtn

local PoopStroke = Instance.new("UIStroke", PoopBtn)
PoopStroke.Color = Color3.fromRGB(220, 150, 50)
PoopStroke.Transparency = 0.3
PoopStroke.Thickness = 1.5

-- ─── CHARACTER SEKME İÇERİĞİ ───
local CharPage = Instance.new("Frame")
CharPage.Size = UDim2.new(1, 0, 1, -108)
CharPage.Position = UDim2.new(0, 0, 0, 108)
CharPage.BackgroundTransparency = 1
CharPage.BorderSizePixel = 0
CharPage.Visible = false
CharPage.Parent = MainFrame

-- Başlık
local CharTitle = Instance.new("TextLabel")
CharTitle.Size = UDim2.new(1, -40, 0, 26)
CharTitle.Position = UDim2.new(0, 20, 0, 8)
CharTitle.BackgroundTransparency = 1
CharTitle.Text = "Karakter Ayarları"
CharTitle.TextColor3 = Color3.fromRGB(180, 140, 100)
CharTitle.TextSize = 13
CharTitle.Font = Enum.Font.GothamBold
CharTitle.TextXAlignment = Enum.TextXAlignment.Left
CharTitle.Parent = CharPage

-- Yardımcı: toggle satırı oluştur
local function makeToggleRow(parent, yPos, icon, labelText)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -40, 0, 54)
    row.Position = UDim2.new(0, 20, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
    row.BorderSizePixel = 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", row)
    stroke.Color = Color3.fromRGB(100, 70, 150)
    stroke.Transparency = 0.6
    stroke.Thickness = 1

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 36, 1, 0)
    ico.Position = UDim2.new(0, 8, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextSize = 22
    ico.Font = Enum.Font.GothamBold
    ico.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -110, 1, 0)
    lbl.Position = UDim2.new(0, 48, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(210, 190, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 44, 0, 30)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -15)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    toggleBtn.Text = "✕"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 16
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = row
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

    return row, toggleBtn, stroke
end

-- Yardımcı: slider satırı oluştur
local function makeSliderRow(parent, yPos, icon, labelText, minVal, maxVal, defaultVal)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -40, 0, 80)
    row.Position = UDim2.new(0, 20, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
    row.BorderSizePixel = 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", row)
    stroke.Color = Color3.fromRGB(100, 70, 150)
    stroke.Transparency = 0.6
    stroke.Thickness = 1

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 36, 0, 36)
    ico.Position = UDim2.new(0, 8, 0, 6)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextSize = 20
    ico.Font = Enum.Font.GothamBold
    ico.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -110, 0, 36)
    lbl.Position = UDim2.new(0, 48, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(210, 190, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0, 54, 0, 36)
    valLabel.Position = UDim2.new(1, -60, 0, 6)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(defaultVal)
    valLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
    valLabel.TextSize = 14
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.Parent = row

    -- Slider track
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -16, 0, 10)
    track.Position = UDim2.new(0, 8, 0, 56)
    track.BackgroundColor3 = Color3.fromRGB(40, 30, 55)
    track.BorderSizePixel = 0
    track.Parent = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(0, 5)

    local fill = Instance.new("Frame")
    local defaultRatio = (defaultVal - minVal) / (maxVal - minVal)
    fill.Size = UDim2.new(defaultRatio, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(130, 70, 200)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 5)

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(defaultRatio, 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
    knob.Text = ""
    knob.BorderSizePixel = 0
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local currentVal = defaultVal
    local dragging = false

    knob.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    knob.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    track.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local trackPos = track.AbsolutePosition.X
            local trackW = track.AbsoluteSize.X
            local ratio = math.clamp((inp.Position.X - trackPos) / trackW, 0, 1)
            currentVal = math.floor(minVal + (maxVal - minVal) * ratio)
            fill.Size = UDim2.new(ratio, 0, 1, 0)
            knob.Position = UDim2.new(ratio, 0, 0.5, 0)
            valLabel.Text = tostring(currentVal)
        end
    end)

    return row, fill, valLabel, function() return currentVal end
end

-- ── InfJump ──
local infJumpRow, infJumpToggle, infJumpStroke = makeToggleRow(CharPage, 40, "🦘", "Infinite Jump")
local infJumpActive = false
local infJumpConn = nil

infJumpToggle.MouseButton1Click:Connect(function()
    infJumpActive = not infJumpActive
    if infJumpActive then
        infJumpToggle.Text = "✔"
        infJumpToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 60)
        infJumpStroke.Color = Color3.fromRGB(40, 200, 80)
        infJumpStroke.Transparency = 0.3
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum:GetState() ~= Enum.HumanoidStateType.Dead then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        infJumpToggle.Text = "✕"
        infJumpToggle.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        infJumpStroke.Color = Color3.fromRGB(100, 70, 150)
        infJumpStroke.Transparency = 0.6
        if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
    end
end)

-- ── JumpBoost ──
local _, jumpFill, jumpValLabel, getJumpVal = makeSliderRow(CharPage, 104, "⬆️", "Jump Power", 50, 500, 50)
local jumpBoostRow2, jumpBoostToggle, jumpBoostStroke = makeToggleRow(CharPage, 194, "✅", "JumpBoost Uygula")
local jumpBoostActive = false

jumpBoostToggle.MouseButton1Click:Connect(function()
    jumpBoostActive = not jumpBoostActive
    if jumpBoostActive then
        jumpBoostToggle.Text = "✔"
        jumpBoostToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 60)
        jumpBoostStroke.Color = Color3.fromRGB(40, 200, 80)
        jumpBoostStroke.Transparency = 0.3
        task.spawn(function()
            while jumpBoostActive do
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.JumpPower = getJumpVal() end
                end
                task.wait(0.1)
            end
        end)
    else
        jumpBoostToggle.Text = "✕"
        jumpBoostToggle.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        jumpBoostStroke.Color = Color3.fromRGB(100, 70, 150)
        jumpBoostStroke.Transparency = 0.6
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = 50 end
        end
    end
end)

-- ── Speed ──
local _, speedFill, speedValLabel, getSpeedVal = makeSliderRow(CharPage, 258, "💨", "Walk Speed", 16, 500, 16)
local speedRow2, speedToggle, speedStroke = makeToggleRow(CharPage, 348, "✅", "Speed Uygula")
local speedActive = false

speedToggle.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        speedToggle.Text = "✔"
        speedToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 60)
        speedStroke.Color = Color3.fromRGB(40, 200, 80)
        speedStroke.Transparency = 0.3
        task.spawn(function()
            while speedActive do
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.WalkSpeed = getSpeedVal() end
                end
                task.wait(0.1)
            end
        end)
    else
        speedToggle.Text = "✕"
        speedToggle.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        speedStroke.Color = Color3.fromRGB(100, 70, 150)
        speedStroke.Transparency = 0.6
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end)

-- Respawn'da hız/zıplama tekrar uygula
LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    task.wait(0.1)
    if jumpBoostActive then hum.JumpPower = getJumpVal() end
    if speedActive then hum.WalkSpeed = getSpeedVal() end
end)

-- ─── SEKME MANTIĞI ───
local function setTab(tab)
    if tab == "poop" then
        PoopPage.Visible = true
        CharPage.Visible = false
        PoopTabBtn.BackgroundColor3 = Color3.fromRGB(101, 55, 0)
        PoopTabBtn.TextColor3 = Color3.fromRGB(255, 220, 150)
        CharTabBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 40)
        CharTabBtn.TextColor3 = Color3.fromRGB(120, 100, 140)
    else
        PoopPage.Visible = false
        CharPage.Visible = true
        CharTabBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
        CharTabBtn.TextColor3 = Color3.fromRGB(200, 160, 255)
        PoopTabBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 40)
        PoopTabBtn.TextColor3 = Color3.fromRGB(120, 100, 80)
    end
end

PoopTabBtn.MouseButton1Click:Connect(function() setTab("poop") end)
CharTabBtn.MouseButton1Click:Connect(function() setTab("char") end)

-- ─── FONKSİYONLAR ───
local function updateDisplay()
    NumberDisplay.Text = tostring(poopCount)
    local totalTime = (poopCount - 1) * 0.4
    TimeLabel.Text = "⏱ Tahmini süre: ~" .. string.format("%.2f", math.max(0, totalTime)) .. "s"
    MinusBtn.BackgroundColor3 = poopCount <= minCount and Color3.fromRGB(40, 20, 5) or Color3.fromRGB(80, 40, 10)
    MinusBtn.TextColor3 = poopCount <= minCount and Color3.fromRGB(100, 70, 40) or Color3.fromRGB(255, 200, 100)
    PlusBtn.BackgroundColor3 = poopCount >= maxCount and Color3.fromRGB(40, 20, 5) or Color3.fromRGB(80, 40, 10)
    PlusBtn.TextColor3 = poopCount >= maxCount and Color3.fromRGB(100, 70, 40) or Color3.fromRGB(255, 200, 100)
end

local function setStep(amount)
    stepAmount = amount
    StepIndicator.Text = "Seçili adım: +" .. tostring(amount)
    Step1Btn.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
    Step5Btn.BackgroundColor3 = Color3.fromRGB(40, 30, 10)
    Step10Btn.BackgroundColor3 = Color3.fromRGB(40, 30, 10)
    if amount == 1 then
        Step1Btn.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
        StepIndicator.TextColor3 = Color3.fromRGB(150, 255, 150)
    elseif amount == 5 then
        Step5Btn.BackgroundColor3 = Color3.fromRGB(160, 90, 10)
        StepIndicator.TextColor3 = Color3.fromRGB(255, 200, 100)
    elseif amount == 10 then
        Step10Btn.BackgroundColor3 = Color3.fromRGB(160, 90, 10)
        StepIndicator.TextColor3 = Color3.fromRGB(255, 180, 80)
    end
end

Step1Btn.MouseButton1Click:Connect(function() setStep(1) end)
Step5Btn.MouseButton1Click:Connect(function() setStep(5) end)
Step10Btn.MouseButton1Click:Connect(function() setStep(10) end)

MinusBtn.MouseButton1Click:Connect(function()
    if poopCount > minCount then
        poopCount = math.max(minCount, poopCount - stepAmount)
        updateDisplay()
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if poopCount < maxCount then
        poopCount = math.min(maxCount, poopCount + stepAmount)
        updateDisplay()
    end
end)

local function startCooldown()
    isOnCooldown = true
    PoopBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 5)
    PoopBtn.TextColor3 = Color3.fromRGB(120, 90, 50)
    BarFill.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    CooldownStroke.Color = Color3.fromRGB(200, 80, 80)
    local steps = 100
    local stepTime = COOLDOWN / steps
    for i = steps, 0, -1 do
        local remaining = i * stepTime
        local progress = i / steps
        CooldownLabel.Text = "🕐 Cooldown: " .. string.format("%.1f", remaining) .. "s"
        CooldownLabel.TextColor3 = Color3.fromRGB(220, 120, 80)
        TweenService:Create(BarFill, TweenInfo.new(stepTime, Enum.EasingStyle.Linear), {
            Size = UDim2.new(progress, 0, 1, 0)
        }):Play()
        local r = math.floor(220 * progress + 80 * (1 - progress))
        local g = math.floor(80 * progress + 220 * (1 - progress))
        BarFill.BackgroundColor3 = Color3.fromRGB(r, g, 60)
        task.wait(stepTime)
    end
    isOnCooldown = false
    CooldownLabel.Text = "✅ Hazır"
    CooldownLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(100, 220, 100)
    CooldownStroke.Color = Color3.fromRGB(80, 60, 120)
    PoopBtn.BackgroundColor3 = Color3.fromRGB(101, 55, 0)
    PoopBtn.TextColor3 = Color3.fromRGB(255, 230, 150)
end

PoopBtn.MouseEnter:Connect(function()
    if not isOnCooldown and not isSending then
        TweenService:Create(PoopBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(130, 75, 5)}):Play()
    end
end)

PoopBtn.MouseLeave:Connect(function()
    if not isOnCooldown and not isSending then
        TweenService:Create(PoopBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(101, 55, 0)}):Play()
    end
end)

PoopBtn.MouseButton1Click:Connect(function()
    if isOnCooldown or isSending then return end
    if poopCount == 0 then
        StatusLabel.Text = "⚠ Miktar 0, artır!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    isSending = true
    StatusLabel.Text = "Gönderiliyor... (0/" .. poopCount .. ")"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
    local success = 0
    local failed = 0
    for i = 1, poopCount do
        local ok, _ = pcall(function()
            local args = { buffer.fromstring("\000\000\000\000") }
            game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("Packet"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        end)
        if ok then success = success + 1 else failed = failed + 1 end
        StatusLabel.Text = "Gönderiliyor... (" .. i .. "/" .. poopCount .. ")"
        if i < poopCount then
            local delay = 0.4
            local steps = 40
            for t = steps, 1, -1 do
                TimeLabel.Text = "⏱ Bekleniyor: " .. string.format("%.2f", t * (delay / steps)) .. "s"
                task.wait(delay / steps)
            end
            TimeLabel.Text = "⏱ Tahmini süre: ~" .. string.format("%.2f", (poopCount - 1) * 0.4) .. "s"
        end
    end
    isSending = false
    if failed == 0 then
        StatusLabel.Text = "✔ " .. success .. " paket gönderildi!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
    else
        StatusLabel.Text = "⚠ " .. success .. " OK, " .. failed .. " başarısız"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 160, 60)
    end
    task.spawn(startCooldown)
    task.wait(2.5)
    StatusLabel.Text = isOnCooldown and "Cooldown bekleniyor..." or "Hazır!"
    StatusLabel.TextColor3 = isOnCooldown and Color3.fromRGB(180, 120, 60) or Color3.fromRGB(100, 200, 100)
end)

-- Sürükleme
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

setTab("poop")
setStep(1)
updateDisplay()

-- ─── INTRO ANİMASYON ───
task.spawn(function()
    task.wait(0.1)
    TweenService:Create(IntroText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextTransparency = 0, TextSize = 72
    }):Play()
    TweenService:Create(GlowLabel, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextTransparency = 0.75
    }):Play()
    task.wait(0.5)
    TweenService:Create(UnderLine, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.85, 0, 0, 3), BackgroundTransparency = 0
    }):Play()
    task.wait(0.4)
    TweenService:Create(IntroText, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {TextSize = 76}):Play()
    TweenService:Create(GlowLabel, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {TextTransparency = 0.6}):Play()
    task.wait(0.8)
    TweenService:Create(IntroText, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1, TextSize = 60}):Play()
    TweenService:Create(GlowLabel, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1, TextSize = 70}):Play()
    TweenService:Create(UnderLine, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 3)}):Play()
    TweenService:Create(GlowFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -250, 0.4, -60)}):Play()
    task.wait(0.6)
    IntroFrame:Destroy()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 300, 0, 490)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -245)
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 340, 0, 560),
        Position = UDim2.new(0.5, -170, 0.5, -280)
    }):Play()
end)

print("💩 Poop GUI v2 yüklendi! | [Insert] = Aç/Kapat")
