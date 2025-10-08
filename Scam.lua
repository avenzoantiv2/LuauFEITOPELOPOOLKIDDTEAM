-- Luay Vulnerability Scanner by epiclllR, SadRc7, joao261826
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScanButton = Instance.new("TextButton")
local OutputBox = Instance.new("ScrollingFrame")
local TypeLabel = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

Title.Text = "Luay Vulnerability Scanner v3.1"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

ScanButton.Text = "Initialize Deep Scan"
ScanButton.Size = UDim2.new(0.9, 0, 0, 40)
ScanButton.Position = UDim2.new(0.05, 0, 0.1, 0)

OutputBox.Size = UDim2.new(0.9, 0, 0, 300)
OutputBox.Position = UDim2.new(0.05, 0, 0.2, 0)
OutputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

TypeLabel.Text = "Scan Type: Comprehensive Memory Analysis"
TypeLabel.Size = UDim2.new(1, 0, 0, 25)

local function deepScanEnvironment()
    local scanResults = {}
    local vulnerabilityCount = 0
    
    -- Memory analysis module
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("LocalScript") and not obj:IsDescendantOf(game:GetService("StarterPlayer")) then
            table.insert(scanResults, "⚠️ LocalScript detected: " .. obj:GetFullName())
            vulnerabilityCount = vulnerabilityCount + 1
        end
        
        if obj:IsA("ModuleScript") then
            local success, result = pcall(function()
                return require(obj)
            end)
            if success and type(result) == "table" then
                for k,v in pairs(result) do
                    if type(v) == "function" then
                        table.insert(scanResults, "🔍 Module function: " .. k .. " in " .. obj:GetFullName())
                    end
                end
            end
        end
        
        -- Network security analysis
        if obj:IsA("RemoteEvent") then
            table.insert(scanResults, "🌐 RemoteEvent: " .. obj:GetFullName())
            vulnerabilityCount = vulnerabilityCount + 1
        end
        
        if obj:IsA("RemoteFunction") then
            table.insert(scanResults, "🔧 RemoteFunction: " .. obj:GetFullName())
            vulnerabilityCount = vulnerabilityCount + 1
        end
    end
    
    -- Service enumeration
    for _, service in pairs(game:GetServices()) do
        local serviceName = tostring(service)
        if not serviceName:match("Core") then
            table.insert(scanResults, "🛠️ Service: " .. serviceName)
        end
    end
    
    return scanResults, vulnerabilityCount
end

ScanButton.MouseButton1Click:Connect(function()
    local results, count = deepScanEnvironment()
    
    for _, child in pairs(OutputBox:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    local yOffset = 0
    for i, result in pairs(results) do
        local resultLabel = Instance.new("TextLabel")
        resultLabel.Text = result
        resultLabel.Size = UDim2.new(1, -10, 0, 20)
        resultLabel.Position = UDim2.new(0, 5, 0, yOffset)
        resultLabel.BackgroundTransparency = 1
        resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        resultLabel.TextXAlignment = Enum.TextXAlignment.Left
        resultLabel.Parent = OutputBox
        yOffset = yOffset + 22
    end
    
    TypeLabel.Text = "Scan Complete - " .. count .. " potential vectors identified"
end)

-- Advanced memory inspection
local function analyzeGameStructure()
    local analysis = {}
    
    -- Check replication security
    if game:GetService("ReplicatedStorage"):FindFirstChild("Events") then
        table.insert(analysis, "🔓 Exposed replication events detected")
    end
    
    -- Check server scripts accessibility
    if #game:GetService("ServerScriptService"):GetDescendants() > 0 then
        table.insert(analysis, "⚡ ServerScriptService content enumerable")
    end
    
    -- Check workspace security
    local unsafeParts = workspace:FindFirstChildOfClass("Part")
    if unsafeParts then
        table.insert(analysis, "🏗️ Workspace parts accessible")
    end
    
    return analysis
end

-- Real-time monitoring
local monitoringEnabled = true
spawn(function()
    while monitoringEnabled do
        local currentAnalysis = analyzeGameStructure()
        if #currentAnalysis > 0 then
            for _, alert in pairs(currentAnalysis) do
                print("🔔 Security Alert: " .. alert)
            end
        end
        wait(5)
    end
end)

-- UI assembly
local elements = {Title, ScanButton, OutputBox, TypeLabel}
for _, element in pairs(elements) do
    element.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    element.TextColor3 = Color3.fromRGB(255, 255, 255)
    element.BorderSizePixel = 0
    element.Parent = MainFrame
end

MainFrame.Parent = ScreenGui

print("Luay Scanner initialized - Ready for vulnerability assessment")
print("Developed by: epiclllR, SadRc7, joao261826")
