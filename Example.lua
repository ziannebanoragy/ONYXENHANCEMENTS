while not game:IsLoaded() do task.wait(0.1) end

local function load(url, name)
    local ok, src = pcall(game.HttpGet, game, url)
    if not ok then warn("[Load] HttpGet failed for " .. name .. ": " .. tostring(src)) return nil end
    if not src or #src == 0 then warn("[Load] Empty response for " .. name) return nil end
    local fn, err = loadstring(src)
    if not fn then warn("[Load] loadstring failed for " .. name .. ": " .. tostring(err)) return nil end
    local res, ret = pcall(fn)
    if not res then warn("[Load] Runtime error in " .. name .. ": " .. tostring(ret)) return nil end
    return ret
end

local Library = load('https://raw.githubusercontent.com/ziannebanoragy/ONYXENHANCEMENTS/main/Source.lua', 'Source')
assert(Library, "Failed to load Source.lua - check console/output for details")

local ThemeManager = load('https://raw.githubusercontent.com/ziannebanoragy/ONYXENHANCEMENTS/main/ThemeManager.lua', 'ThemeManager')
local SaveManager = load('https://raw.githubusercontent.com/ziannebanoragy/ONYXENHANCEMENTS/main/Settings.lua', 'Settings')

local Window = Library:CreateWindow({
    Title = 'onyxenhancements',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
})

local Tabs = {
    Aiming     = Window:AddTab('Aiming'),
    Triggerbot = Window:AddTab('Triggerbot'),
    Visuals    = Window:AddTab('Visuals'),
    Performance= Window:AddTab('Performance'),
    Skin       = Window:AddTab('Skin'),
    Misc       = Window:AddTab('Misc'),
    ['Ui']     = Window:AddTab('Ui'),
}

-- Aiming
local AimbotGroup = Tabs.Aiming:AddLeftGroupbox('Aimbot')
local AimbotSettings = Tabs.Aiming:AddRightGroupbox('Settings')

AimbotGroup:AddToggle('AimbotEnabled', { Text = 'Enabled', Default = false })
 :AddKeyPicker('AimbotKey', { Default = 'None', Mode = 'Hold', Text = 'Aimbot', NoUI = false })
AimbotGroup:AddToggle('AimbotWallcheck', { Text = 'Wallcheck', Default = false })
AimbotGroup:AddToggle('AimbotPrediction', { Text = 'Prediction', Default = false })
AimbotGroup:AddToggle('AimbotSticky', { Text = 'Sticky Aim', Default = false })
AimbotGroup:AddToggle('FOVEnabled', { Text = 'FOV', Default = false })
AimbotGroup:AddToggle('TeamCheck', { Text = 'Team Check', Default = false })
AimbotGroup:AddDropdown('AimbotBone', {
    Text = 'Target Bone', Default = 1, Multi = true,
    Values = { 'Head','UpperTorso','LowerTorso','LeftUpperArm','LeftLowerArm','LeftHand','RightUpperArm','RightLowerArm','RightHand','LeftUpperLeg','LeftLowerLeg','LeftFoot','RightUpperLeg','RightLowerLeg','RightFoot' },
})

AimbotSettings:AddSlider('AimbotFOV', { Text = 'FOV', Default = 120, Min = 30, Max = 500, Rounding = 0, Suffix = ' px' })
AimbotSettings:AddSlider('AimbotSmoothing', { Text = 'Smoothing', Default = 15, Min = 1, Max = 100, Rounding = 0 })
AimbotSettings:AddSlider('AimbotSensitivity', { Text = 'Sensitivity', Default = 1, Min = 0.1, Max = 2, Rounding = 1 })
AimbotSettings:AddSlider('AimbotMaxDistance', { Text = 'Max Distance', Default = 300, Min = 50, Max = 1000, Rounding = 0, Suffix = ' studs' })
AimbotSettings:AddSlider('AimbotPredictScale', { Text = 'Predict Strength', Default = 8, Min = 1, Max = 30, Rounding = 0 })
AimbotSettings:AddLabel('FOV Outline Color'):AddColorPicker('FOVColor', { Default = Color3.new(1,1,1) })
AimbotSettings:AddLabel('FOV Fill Color'):AddColorPicker('FOVFillColor', { Default = Color3.fromRGB(0,200,255) })
AimbotSettings:AddSlider('FOVThickness', { Text = 'FOV Thickness', Default = 2, Min = 1, Max = 10, Rounding = 0 })
AimbotSettings:AddSlider('FOVTransparency', { Text = 'FOV Transparency', Default = 85, Min = 0, Max = 100, Rounding = 0 })
AimbotSettings:AddToggle('FOVFilled', { Text = 'FOV Filled', Default = false })

-- Triggerbot
local TriggerGroup = Tabs.Triggerbot:AddLeftGroupbox('Triggerbot')
local TriggerSettings = Tabs.Triggerbot:AddRightGroupbox('Settings')

TriggerGroup:AddToggle('TriggerbotEnabled', { Text = 'Enabled', Default = false })
  :AddKeyPicker('TriggerbotKey', { Default = 'None', Mode = 'Hold', Text = 'Triggerbot', NoUI = false })
TriggerGroup:AddToggle('TriggerbotFOVEnabled', { Text = 'FOV', Default = false })
TriggerGroup:AddToggle('TriggerbotScopeCheck', { Text = 'Scope Check', Default = false })
TriggerGroup:AddToggle('KatanaCheck', { Text = 'Anti Katana', Default = false })

TriggerSettings:AddSlider('TriggerbotRadius', { Text = 'Radius', Default = 25, Min = 1, Max = 100, Rounding = 0, Suffix = ' px' })
TriggerSettings:AddSlider('TriggerbotMinDelay', { Text = 'Min Delay', Default = 50, Min = 0, Max = 500, Rounding = 0, Suffix = ' ms' })
TriggerSettings:AddSlider('TriggerbotMaxDelay', { Text = 'Max Delay', Default = 120, Min = 0, Max = 500, Rounding = 0, Suffix = ' ms' })

-- Visuals
local ESPGroup = Tabs.Visuals:AddLeftGroupbox('ESP')
local ESPSettings = Tabs.Visuals:AddRightGroupbox('Settings')

ESPGroup:AddToggle('ESPEnabled', { Text = 'ESP Enabled', Default = false })
ESPGroup:AddToggle('ESPBox', { Text = 'Box', Default = false })
ESPGroup:AddToggle('ESPCornerBox', { Text = 'Corner Box', Default = false })
ESPGroup:AddToggle('ESPFilled', { Text = 'Filled Box', Default = false })
ESPGroup:AddToggle('ESPDistance', { Text = 'Distance', Default = false })
ESPGroup:AddToggle('ESPSkeleton', { Text = 'Skeleton', Default = false })
ESPGroup:AddDropdown('ESPAnimMode', {
    Text = 'Animation Mode', Default = 'Spinning Gradient',
    Values = { 'Static','Rainbow','Spinning Gradient','Pulse' },
})

ESPSettings:AddSlider('ESPMaxDistance', { Text = 'Max Distance', Default = 300, Min = 50, Max = 1000, Rounding = 0, Suffix = ' studs' })
ESPSettings:AddSlider('ESPBoxThickness', { Text = 'Box Thickness', Default = 1, Min = 1, Max = 5, Rounding = 0 })
ESPSettings:AddLabel('Visible Color'):AddColorPicker('ESPVisibleColor', { Default = Color3.new(0,1,0) })
ESPSettings:AddLabel('Hidden Color'):AddColorPicker('ESPInvisibleColor', { Default = Color3.new(1,0,0) })

-- Weapon Chams
local ChamsGroup = Tabs.Visuals:AddRightGroupbox('Weapon Chams')
ChamsGroup:AddToggle('WeaponChamsEnabled', { Text = 'Enabled', Default = false })
ChamsGroup:AddDropdown('WeaponChamsMaterial', {
    Text = 'Material', Default = 'ForceField',
    Values = { 'ForceField','Neon','Glass','SmoothPlastic','Metal','Wood' },
})
ChamsGroup:AddSlider('WeaponChamsTransparency', { Text = 'Transparency', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
ChamsGroup:AddLabel('Color'):AddColorPicker('WeaponChamsColor', { Default = Color3.new(1,1,1) })

-- Performance
local PerfGroup = Tabs.Performance:AddLeftGroupbox('Performance')
PerfGroup:AddSlider('RaycastUpdateRate', {
    Text = 'Raycast Delay', Default = 50, Min = 0, Max = 500, Rounding = 0,
    Suffix = ' ms', Tooltip = 'Higher = better FPS, lower = more accurate',
})

-- Skin
local SkinGroup = Tabs.Skin:AddLeftGroupbox('Skin Changer')
SkinGroup:AddToggle('UseUnlockAll', { Text = 'Use Unlock All', Default = false })
SkinGroup:AddDropdown('SkinCategory', {
    Text = 'Category', Default = 1,
    Values = { 'assault_rifle','sniper_rifle','shotgun','pistol','launcher' },
})
SkinGroup:AddDropdown('SkinWeapon', { Text = 'Weapon', Default = 1, Values = { 'ak47' } })
SkinGroup:AddDropdown('SkinName', { Text = 'Skin', Default = 1, Values = { '' } })
SkinGroup:AddButton('Apply Skin', function() end)

-- Misc
local MiscGroup = Tabs.Misc:AddLeftGroupbox('Hitsounds')
local soundList = { 'Normal','Neverlose','Gamesense','Fatality','Splash','Cowbell','Slap' }
MiscGroup:AddDropdown('HitSoundHead', { Text = 'Head', Default = 'Normal', Values = soundList })
MiscGroup:AddSlider('HitSoundHeadVolume', { Text = 'Head Volume', Default = 1, Min = 0, Max = 10, Rounding = 1 })
MiscGroup:AddDropdown('HitSoundBody', { Text = 'Body', Default = 'Normal', Values = soundList })
MiscGroup:AddSlider('HitSoundBodyVolume', { Text = 'Body Volume', Default = 1, Min = 0, Max = 10, Rounding = 1 })
MiscGroup:AddDropdown('HitSoundKill', { Text = 'Kill', Default = 'Normal', Values = soundList })
MiscGroup:AddSlider('HitSoundKillVolume', { Text = 'Kill Volume', Default = 1, Min = 0, Max = 10, Rounding = 1 })

-- UI
local MenuGroup = Tabs['Ui']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })
MenuGroup:AddToggle('ShowKeybinds', { Text = 'Show Keybinds', Default = false, Callback = function(v) Library.KeybindFrame.Visible = v end })
MenuGroup:AddToggle('ShowWatermark', { Text = 'Show Watermark', Default = true, Callback = function(v) Library:SetWatermarkVisibility(v) end })

local NotifGroup = Tabs['Ui']:AddRightGroupbox('Notifications')
NotifGroup:AddDropdown('NotifAlignment', {
    Text = 'Alignment', Default = 'Center',
    Values = { 'Left', 'Center', 'Right' },
    Callback = function(v) Library:ConfigureNotifications({ Alignment = v }) end,
})
NotifGroup:AddDropdown('NotifBarSide', {
    Text = 'Bar Side', Default = 'Top',
    Values = { 'Top', 'Bottom', 'Left', 'Right' },
    Callback = function(v) Library:ConfigureNotifications({ BarSide = v }) end,
})
NotifGroup:AddSlider('NotifPosY', {
    Text = 'Position Y', Default = 55, Min = 0, Max = 100, Rounding = 0, Suffix = '%',
    Callback = function(v) Library:ConfigureNotifications({ PositionY = v }) end,
})
NotifGroup:AddSlider('NotifMaxHeight', {
    Text = 'Max Visible Height', Default = 200, Min = 50, Max = 600, Rounding = 0,
    Callback = function(v) Library:ConfigureNotifications({ MaxHeight = v }) end,
})
NotifGroup:AddSlider('NotifTransparency', {
    Text = 'Transparency', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%',
    Callback = function(v) Library:ConfigureNotifications({ Transparency = v }) end,
})
NotifGroup:AddToggle('NotifClip', {
    Text = 'Clip Descendants', Default = false,
    Callback = function(v) Library:ConfigureNotifications({ ClipDescendants = v }) end,
})
NotifGroup:AddDropdown('NotifSortOrder', {
    Text = 'Sort Order', Default = 'Time',
    Values = { 'Time', 'Text Length' },
    Callback = function(v) Library:ConfigureNotifications({ SortOrder = v }) end,
})
NotifGroup:AddButton('Test Notification', function()
    Library:Notify('This is a test notification!', 3)
end)

-- Theme and Config Manager
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

ThemeManager:SetFolder('onyxenhancements')
ThemeManager.DefaultTheme = 'UE'
SaveManager:SetFolder('onyxenhancements/configs')

SaveManager:BuildConfigSection(Tabs['Ui'])
ThemeManager:ApplyToTab(Tabs['Ui'])

ThemeManager:ApplyTheme('UE')

Library.ToggleKeybind = Options.MenuKeybind
Library.KeybindFrame.Visible = false
Library:SetWatermarkVisibility(true)
Library:SetWatermark('onyxenhancements')

Library:OnUnload(function()
    Library.Unloaded = true
end)
