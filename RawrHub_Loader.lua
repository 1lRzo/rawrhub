-- Rawr Hub v3 PRO - Feito por Ethical Hacker GPT

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local HUB_KEY = "Rawr"
local KEY_FILE = "RawrHubKey.txt"
local THEME_FILE = "RawrHubTheme.txt"

-- Variáveis principais
local sessionUnlocked = false
local isDarkTheme = true
local hubVisible = false
local minimized = false
local menuFrame, contentFrame, mainHubFrame
local uiElements = {}

-- Salvar key
local function saveKey(key)
    if writefile then
        writefile(KEY_FILE, key)
    end
end

-- Carregar key
local function loadKey()
    if readfile and isfile and isfile(KEY_FILE) then
        return readfile(KEY_FILE)
    end
end

-- Salvar tema
local function saveTheme()
    if writefile then
        writefile(THEME_FILE, tostring(isDarkTheme))
    end
end

-- Carregar tema
local function loadTheme()
    if readfile and isfile and isfile(THEME_FILE) then
        local result = readfile(THEME_FILE)
        if result == "true" then isDarkTheme = true
        elseif result == "false" then isDarkTheme = false end
    end
end

-- Sons
local function playClickSound()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://12222005"
    s.Volume = 0.5
    s.PlayOnRemove = true
    s.Parent = LocalPlayer:WaitForChild("PlayerGui")
    s:Destroy()
end

local function playOpenSound()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://88064647826500"
    s.Volume = 1
    s.PlayOnRemove = true
    s.Parent = LocalPlayer:WaitForChild("PlayerGui")
    s:Destroy()
end

-- Tema
local function getThemeColors()
    return isDarkTheme and {
        mainBg = Color3.fromRGB(20, 20, 20),
        contentBg = Color3.fromRGB(15, 15, 15),
        menuBg = Color3.fromRGB(30, 30, 30),
        titleBg = Color3.fromRGB(25, 25, 25),
        textColor = Color3.new(1, 1, 1),
        buttonColor = Color3.fromRGB(40, 40, 40),
        hoverColor = Color3.fromRGB(55, 55, 55),
        inputColor = Color3.fromRGB(35, 35, 35),
    } or {
        mainBg = Color3.fromRGB(230, 230, 230),
        contentBg = Color3.fromRGB(245, 245, 245),
        menuBg = Color3.fromRGB(210, 210, 210),
        titleBg = Color3.fromRGB(200, 200, 200),
        textColor = Color3.new(0, 0, 0),
        buttonColor = Color3.fromRGB(180, 180, 180),
        hoverColor = Color3.fromRGB(160, 160, 160),
        inputColor = Color3.fromRGB(200, 200, 200),
    }
end

local function updateTheme()
    local c = getThemeColors()
    for _, e in ipairs(uiElements) do
        if e:IsA("TextButton") then
            e.BackgroundColor3 = c.buttonColor
            e.TextColor3 = c.textColor
        elseif e:IsA("TextBox") then
            e.BackgroundColor3 = c.inputColor
            e.TextColor3 = c.textColor
        elseif e:IsA("TextLabel") then
            e.BackgroundColor3 = c.titleBg
            e.TextColor3 = c.textColor
        elseif e:IsA("Frame") then
            e.BackgroundColor3 = c.mainBg
        end
    end
end

local function createButton(text, parent, callback)
    local c = getThemeColors()
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = c.buttonColor
    btn.TextColor3 = c.textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = text
    btn.Parent = parent
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = c.hoverColor end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = c.buttonColor end)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        playClickSound()
        callback()
    end)
    table.insert(uiElements, btn)
    return btn
end

local function createTabButton(text, parent, callback, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(85, 60, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.Text = "🗂️ " .. text
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(100, 80, 180) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(85, 60, 150) end)
    btn.MouseButton1Click:Connect(function()
        playClickSound()
        callback()
    end)
    table.insert(uiElements, btn)
    return btn
end

local function switchTab(tab)
    for _, c in ipairs(contentFrame:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end

    local function scriptBtn(txt, action)
        local btn = createButton("📜 " .. txt, contentFrame, function()
            pcall(action)
        end)
        btn.TextSize = 15
        btn.BackgroundColor3 = Color3.fromRGB(60, 90, 180)
        return btn
    end

    if tab == "99Nights" then
        scriptBtn("Abrir Script 99 Nights", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/gHQGTNYH"))()
        end)
        scriptBtn("Luarmor Loader", function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/705e9a93cc18214fb77ab95686a8dba9.lua"))()
        end)

    elseif tab == "NaturalDisaster" then
        scriptBtn("EGOR Script", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DROID-cell-sys/ANTI-UTTP-SCRIPTT/refs/heads/main/EGOR%20SCRIPT%20BY%20ANTI-UTTP"))()
        end)
        scriptBtn("Fake Lag", function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fake-lag-41217"))()
        end)

    elseif tab == "BloxFruits" then
        scriptBtn("Ruby Hub", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GoblinKun009/Script/refs/heads/main/rubymain"))()
        end)

    elseif tab == "Universal" then
        scriptBtn("Infinite Yield", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end)

    elseif tab == "Config" then
        createButton("🎯 Anti-Lag", contentFrame, function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                    v.Enabled = false
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                end
            end
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)

        createButton("🌗 Alternar Tema", contentFrame, function()
            isDarkTheme = not isDarkTheme
            updateTheme()
            saveTheme()
        end)

        createButton("🔻 Minimizar / Expandir", contentFrame, function()
            minimized = not minimized
            local goal = minimized and UDim2.new(0, 420, 0, 40) or UDim2.new(0, 420, 0, 320)
            TweenService:Create(mainHubFrame, TweenInfo.new(0.4), { Size = goal }):Play()
        end)
    end
end

local function createHub()
    local c = getThemeColors()
    uiElements = {}

    local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "RawrHub"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 420, 0, 320)
    main.Position = UDim2.new(0.3, 0, 0.3, 0)
    main.BackgroundColor3 = c.mainBg
    main.Active = true
    main.Draggable = true
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    table.insert(uiElements, main)
    mainHubFrame = main

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = c.titleBg
    title.Text = "Rawr Hub - v3 PRO"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = c.textColor
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)
    table.insert(uiElements, title)

    menuFrame = Instance.new("Frame", main)
    menuFrame.Size = UDim2.new(0, 140, 1, -40)
    menuFrame.Position = UDim2.new(0, 0, 0, 40)
    menuFrame.BackgroundColor3 = c.menuBg
    Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0, 6)
    table.insert(uiElements, menuFrame)

    contentFrame = Instance.new("Frame", main)
    contentFrame.Size = UDim2.new(1, -140, 1, -40)
    contentFrame.Position = UDim2.new(0, 140, 0, 40)
    contentFrame.BackgroundColor3 = c.contentBg
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 6)
    table.insert(uiElements, contentFrame)

    local layout = Instance.new("UIListLayout", contentFrame)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    createTabButton("99 Nights", menuFrame, function() switchTab("99Nights") end, UDim2.new(0, 0, 0, 0))
    createTabButton("Natural Disaster", menuFrame, function() switchTab("NaturalDisaster") end, UDim2.new(0, 0, 0, 40))
    createTabButton("Blox Fruits", menuFrame, function() switchTab("BloxFruits") end, UDim2.new(0, 0, 0, 80))
    createTabButton("Universal", menuFrame, function() switchTab("Universal") end, UDim2.new(0, 0, 0, 120))
    createTabButton("Configurações", menuFrame, function() switchTab("Config") end, UDim2.new(0, 0, 0, 160))

    switchTab("99Nights")

    local toggleBtn = Instance.new("ImageButton", gui)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0, 20, 1, -70)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Image = "rbxassetid://8425069728"
    toggleBtn.MouseButton1Click:Connect(function()
        hubVisible = not hubVisible
        main.Visible = hubVisible
        if hubVisible then
            playOpenSound()
        end
    end)

    updateTheme()
end

local function animateHubOpen()
    mainHubFrame.Visible = true
    mainHubFrame.Position = UDim2.new(0.3, 0, 1, 0)
    TweenService:Create(mainHubFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.3, 0, 0.3, 0)
    }):Play()
    playOpenSound()
end

local function requestKey()
    local savedKey = loadKey()
    if savedKey and savedKey == HUB_KEY then
        sessionUnlocked = true
        loadTheme()
        createHub()
        animateHubOpen()
        return
    end

    local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "RawrHubKey"
    gui.ResetOnSpawn = false
    local c = getThemeColors()

    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 12

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 350, 0, 180)
    frame.Position = UDim2.new(0.5, -175, 0.5, -90)
    frame.BackgroundColor3 = c.mainBg
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = c.titleBg
    title.Text = "🔐 Digite sua Key para acessar o Rawr Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = c.textColor
    Instance.new("UICorner", title)

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0.9, 0, 0, 30)
    input.Position = UDim2.new(0.05, 0, 0.45, 0)
    input.PlaceholderText = "Digite a key correta..."
    input.Font = Enum.Font.Gotham
    input.TextSize = 14
    input.BackgroundColor3 = c.inputColor
    input.TextColor3 = c.textColor
    Instance.new("UICorner", input)

    local feedback = Instance.new("TextLabel", frame)
    feedback.Size = UDim2.new(1, 0, 0, 20)
    feedback.Position = UDim2.new(0, 0, 0.75, 0)
    feedback.Text = ""
    feedback.TextColor3 = Color3.fromRGB(255, 60, 60)
    feedback.BackgroundTransparency = 1
    feedback.Font = Enum.Font.Gotham
    feedback.TextSize = 13
    feedback.Parent = frame

    local confirm = createButton("✅ Confirmar", frame, function()
        if input.Text == HUB_KEY then
            saveKey(input.Text)
            saveTheme()
            sessionUnlocked = true
            gui:Destroy()
            blur:Destroy()
            loadTheme()
            createHub()
            animateHubOpen()
        else
            playClickSound()
            input.Text = ""
            feedback.Text = "❌ Key incorreta, tente novamente."
        end
    end)
    confirm.Size = UDim2.new(0.6, 0, 0, 35)
    confirm.Position = UDim2.new(0.2, 0, 0.63, 0)
end

-- 🔃 Início
requestKey()
