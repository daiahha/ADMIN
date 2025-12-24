--[[ 
    GRAVITY HUB - OBFUSCATED VERSION
    Mã hoá bởi Gravity Admin
--]]

local _0x5f2a = {"\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\115\104\108\101\120\119\97\114\101\47\79\114\105\111\110\47\109\97\105\110\47\115\111\117\114\99\101", "\83\67\82\73\80\84\71\82\65\86\73\84\89\49\48\75", "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\68\101\118\45\71\114\97\118\105\116\121\72\117\98\47\66\108\111\120\70\114\117\105\116\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\77\97\105\110\46\108\117\97"}
local _0x1a2b = _0x5f2a[1] -- Library link
local _0x3c4d = _0x5f2a[2] -- Correct Key
local _0x7e8f = _0x5f2a[3] -- Main Script link

local Library = loadstring(game:HttpGet(_0x1a2b))()
local MyAvatar = "http://www.roblox.com/asset/?id=138538611015843"

local Window = Library:MakeWindow({
    Name = "GRAVITY HUB | VIP", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Gravity Hub System",
    IntroIcon = MyAvatar
})

local MainTab = Window:MakeTab({
    Name = "Active Key",
    Icon = MyAvatar,
    PremiumOnly = false
})

MainTab:AddLabel("SỞ HỮU BỞI GRAVITY")

MainTab:AddTextbox({
    Name = "Nhập Key:",
    Default = "",
    TextDisappear = true,
    Callback = function(v) _G.KInput = v end
})

MainTab:AddButton({
    Name = "Xác Nhận",
    Callback = function()
        if _G.KInput == _0x3c4d then
            Library:MakeNotification({Name = "SUCCESS", Content = "Loading...", Image = MyAvatar, Time = 3})
            Library:Destroy()
            task.wait(1)
            loadstring(game:HttpGet(_0x7e8f))()
        else
            Library:MakeNotification({Name = "ERROR", Content = "Invalid Key!", Time = 3})
        end
    end
})

Library:Init()
