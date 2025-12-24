--[[ 
    GRAVITY HUB - PHIÊN BẢN CẬP NHẬT AVATAR
    ID Asset: 138538611015843
    Key: SCRIPTGRAVITY10K
--]]

local CorrectKey = "SCRIPTGRAVITY10K"
-- Sử dụng link asset bạn cung cấp để làm ảnh đại diện
local MyAvatar = "http://www.roblox.com/asset/?id=138538611015843"

local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Tạo cửa sổ Menu
local Window = Library:MakeWindow({
    Name = "GRAVITY HUB | VIP SYSTEM", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Welcome to Gravity Hub",
    IntroIcon = MyAvatar -- Hiển thị ảnh của bạn khi mở script
})

-- TAB CHÍNH
local MainTab = Window:MakeTab({
    Name = "Kích Hoạt Key",
    Icon = MyAvatar, -- Icon nhỏ ở Tab
    PremiumOnly = false
})

-- Hiển thị ảnh Avatar lớn trong Menu cho đẹp
MainTab:AddLabel("SỞ HỮU BỞI GRAVITY")

MainTab:AddTextbox({
    Name = "Nhập Key tại đây:",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        _G.KeyInput = Value
    end
})

MainTab:AddButton({
    Name = "Xác Nhận & Load Script",
    Callback = function()
        if _G.KeyInput == CorrectKey then
            Library:MakeNotification({
                Name = "THÀNH CÔNG",
                Content = "Đang tải dữ liệu Gravity...",
                Image = MyAvatar,
                Time = 5
            })
            
            -- Đóng menu key
            Library:Destroy()
            
            -- Chạy Script chính của bạn
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))()
        else
            Library:MakeNotification({
                Name = "THẤT BẠI",
                Content = "Key không đúng, hãy kiểm tra lại trên Web!",
                Time = 5
            })
        end
    end
})

Library:Init()
