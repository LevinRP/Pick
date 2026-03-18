-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nexus"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 140)
Frame.Position = UDim2.new(0.5, -110, 0.5, -70)
Frame.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
Frame.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 180, 0, 50)
Button.Position = UDim2.new(0.5, -90, 0.3, 0)
Button.Text = "OFF"
Button.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = Frame

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(0, 180, 0, 40)
Info.Position = UDim2.new(0.5, -90, 0.65, 0)
Info.Text = "Press E"
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.new(1,1,1)
Info.Parent = Frame

local enabled = false
local speedMultiplier = 0.1 -- kleiner = schneller

Button.MouseButton1Click:Connect(function()
    enabled = not enabled
    Button.Text = enabled and "ON" or "OFF"
end)

-- Taste erkennen
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.E then
        if enabled then
            print("Schnelle Aktion gestartet")

            -- Beispiel: schnelle "Interaktion"
            -- Statt langer wait-Zeit:
            local normalTime = 2 -- z.B. 2 Sekunden im eigenen Spiel
            local fastTime = normalTime * speedMultiplier

            task.wait(fastTime)

            print("Aktion abgeschlossen (beschleunigt)")
        else
            print("System ist AUS")
        end
    end
end)