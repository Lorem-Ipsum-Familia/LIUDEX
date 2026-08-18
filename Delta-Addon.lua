loadstring(game:HttpGet("https://raw.githubusercontent.com/Lorem-Ipsum-Familia/LIUDEX/refs/heads/main/LIB-API.lua"))() --function LIB
task.wait(0.1)
local hts = import.HttpService
if not isfolder("LIUDEX API") then
	makefolder("LIUDEX API")
	makefolder("LIUDEX API/Auto Execute")
	makefolder("LIUDEX API/Data")
    makefolder("LIUDEX API/Scripts")
end

local function getexecutescript(path)
	local Place = game.PlaceId
	if isfolder(path)  then
		for i, v in ipairs (listfiles(path))do
			if v == (path.. "/" .. Place) then
				for u,n in ipairs(listfiles(v)) do
					dofile(n)
                    print("Executed")
				end
			end
		end
	end
end

local file = "LIUDEX API/AutoExecute"
--additional api
local maindir = "LIUDEX API"

if not getgenv().LIUDEXLoaded then
	getexecutescript(file)
end

local Place = game.PlaceId

if not isfile("LIUDEX API/Data/UI.json") or not isfolder("LIUDEX API/Data") then
    writefile("new_logo.png",game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/assets/icon/new_logo.png"))
    writefile("background.png",game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/assets/icon/background.png"))
    local data = {
        version = "1.0.2",
        button = {30,30,30},
        background = {0,0,0},
        backgroundlight = {10,10,10},
        placeholder = "Welcome Place Your Script Here Dont Forget To Join Our Community at https://discord.gg/SshP7wVS - Mod By CecepLoremIpsum\n use getldxfenv to get additional function",
        border = {15,15,15},
        imgColor = {255,255,255},
        sendData = getgenv().ldxSendData or ""
    }
    writefile("LIUDEX API/Data/UI.json",hts:JSONEncode(data))
    repeat task.wait()
    until isfile("new_logo.png") and isfile("background.png")
    task.wait()
end

getgenv().LIUDEXLoaded = true
local uis = import.UserInputService
local theme = hts:JSONDecode(readfile("LIUDEX API/Data/UI.json"))
if theme.sendData ~= "" then
    getgenv().LDXWebHookData = theme.sendData
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/tools/user-data.lua"))()
end

local buttonColor = Color3.fromRGB(theme.button[1],theme.button[2],theme.button[3]) or getgenv().ButtonColor or Color3.fromRGB(50,10,100)
local bgColor = Color3.fromRGB(theme.background[1],theme.background[2],theme.background[3]) or getgenv().bgColor or Color3.fromRGB(25,5,50)
local placeHolder = theme.placeholder or getgenv().placeHolder or "Welcome Place Your Script Here Dont Forget To Join Our Community at https://discord.gg/SshP7wVS - Mod By CecepLoremIpsum"
local borderColor = Color3.fromRGB(theme.border[1],theme.border[2],theme.border[3]) or getgenv().borderColor or Color3.fromRGB(100,15,150)
local imageColor = Color3.fromRGB(theme.imgColor[1],theme.imgColor[2],theme.imgColor[3]) or getgenv().imageColor or Color3.fromRGB(255,255,255)

local dksja
local iconLogo
local upvrL
-- clear console
local Players = import.Players
local plr = Players.LocalPlayer
local theex
-- fungsi utama untuk set warna dll
local function mod() --old version but we still used
    local main = gethui()
    for _, v in pairs(main:GetChildren()) do
        -- Sidebar

        -- Executor
        local executor = v:FindFirstChild("Executor")
        theex = executor
        if executor and executor:FindFirstChild("Executor") then
            executor.Executor.Image = getcustomasset("background.png")
            executor.Executor.ImageColor3 = imageColor
            executor.Executor.Overlay.Tabs.BackgroundTransparency = 1
            executor.Executor.Overlay.Tabs.AddTab.BackgroundColor3 = buttonColor
            executor.Executor.Overlay.Tabs["script1.lua"].BackgroundColor3 = buttonColor
            executor.Executor.Overlay.Menu.BackgroundColor3 = buttonColor
            executor.Executor.Overlay.Image = "rbxasset://669f6047d7ef752dacfb0bc2192f8e50/"
            executor.Executor.Overlay.Tabs.BackgroundColor3 = bgColor
            local var = executor.Executor.Overlay.Code
            local var1 = executor.Executor.Overlay.Buttons
            local var2 = executor.Sidemenu
            var2.Network.BackgroundColor3 = bgColor
            var2.Script.BackgroundColor3 = bgColor
            for _, code in ipairs(var:GetChildren()) do
                code.PlaceholderText = placeHolder
            end
            for _, exe in ipairs(var1:GetChildren()) do
                if exe:IsA("ImageButton") then
                    exe.BackgroundColor3 = bgColor
                    exe.BackgroundTransparency = 0
                end
            end
        end
        -- settings
        if executor then
            local place = executor.Parent
            local stng = place.Settings
            local holder = place.Settings.Holder
            local bt = stng.Sort
            stng.Searchbar.BackgroundColor3 = bgColor
            bt.BackgroundColor3 = bgColor
            bt.All.BackgroundColor3 = buttonColor
            bt.Disabled.BackgroundColor3 = buttonColor
            bt.Enabled.BackgroundColor3 = buttonColor
            for _, v in ipairs(holder:GetChildren()) do
                if v:IsA("Frame") then
                    v.BackgroundColor3 = bgColor
                    for i, t in ipairs(v:GetChildren()) do
                        if t:IsA("ImageButton") then
                            t.BackgroundColor3 = buttonColor
                        end
                        if t:IsA("Frame") then
                            t.BackgroundColor3 = bgColor
                        end
                    end
                end
            end
        end

        -- Home
        local home = v:FindFirstChild("Home")
        
        if home then
            upvrL = home
            dksja = home.Popup
            local var3 = home.Holder
            local var4 = home.Searchbar
            var4.Button.BackgroundColor3 = buttonColor
            var4.BackgroundColor3 = bgColor
            for _, sc in ipairs(var3:GetChildren()) do
                if sc:IsA("ImageLabel") then
                    sc.BackgroundColor3 = bgColor
                    if sc:FindFirstChild("Button") then sc.Button.BackgroundColor3 = buttonColor end
                    if sc:FindFirstChild("Button1") then sc.Button1.BackgroundColor3 = buttonColor end
                end
            end
        end
    end
end
getgenv().ldxplugindata = {
    ispc = true,
    executoronly = true,
    scripthubEnabled = true
}
local path = ""
local askljf
local pc = getgenv().ldxplugindata.ispc or false
local executoronly = getgenv().ldxplugindata.executoronly or false
local scripthubEnabled = getgenv().ldxplugindata.scripthubEnabled or false
local developermode = getgenv().ldxdevmode or false
local function onece_change()
    for i,v in ipairs(gethui():GetChildren()) do

        if v:FindFirstChild("Scripthub") then
            local sh = v:WaitForChild("Scripthub")
            local holder = sh:FindFirstChild("Holder")
            local popup = sh:FindFirstChild("Popup")
            local searchbar = sh:FindFirstChild("Searchbar")
            searchbar.BackgroundColor3 = bgColor
            popup.BackgroundColor3 = bgColor
            holder.Reserved.OldThumbnail.Overlay.BackgroundColor3 = bgColor
            v.DarkOverlay.BackgroundColor3 = bgColor
            askljf = v
        end

        if v:FindFirstChild("Executor") and v.Executor:FindFirstChild("Executor") and executoronly then
            v.Executor.Executor.Size = UDim2.new(0.95,0,1.3,0)
            v.Executor.Executor.Position = UDim2.new(1,0,0.42,0)
            v.Executor.Sidemenu.Visible = false
            v.Executor.Sidemenu.Active = false
            local text = v.Executor.Executor.Overlay.Code:FindFirstChildOfClass("TextBox")
            text.TextWrapped = true
            
            local oldtextpos = text.Position
            local oldtextsize = text.Size
            if not pc then
                text.Focused:Connect(function()
                    text.Size = UDim2.new(0.988,0,0.495)
                    text.Position = UDim2.new(0.011,0,0.4,0) 
                end)
            end
            text.FocusLost:Connect(function(ePress)
                text.Size = oldtextsize
                text.Position = oldtextpos
                if ePress then
                    loadstring(text.Text)()
                end
            end)
        end

        local sidebar = v:FindFirstChild("Sidebar")
        if sidebar then
            path = sidebar:FindFirstChild("Home").ImageLabel.Image
            print(path)
            sidebar.BackgroundColor3 = bgColor
            sidebar.ActiveColor.Value = borderColor
            sidebar.InactiveColor.Value = buttonColor
            if scripthubEnabled then
                sidebar.Scripthub:Destroy()
            end
            if developermode then 
                local newtab = sidebar:FindFirstChild("Home"):Clone()
                newtab.Parent = sidebar
                newtab.Name = "Developer Tools"
                newtab.ImageLabel.Image = "Devs Tool"
                local t = false
                newtab.MouseButton1Click:Connect(function()
                    t = not t
                    if t then
                        newtab.BackgroundColor3 = sidebar.ActiveColor.Value
                    end
                end)
            end
            for i,v in ipairs(sidebar:GetChildren()) do
                if v:IsA("ImageButton") then
                    v.BackgroundColor3 = buttonColor
                end
            end
        end
    end
end

function findexecutorfile(p)
    local f = p:split("/")
    return f[#f - 1]
end

local function additional()
    if dksja then
        local hm = upvrL
        local holders = hm.Holder
        local sc = holders:FindFirstChild("Script")
        local upvb = sc:Clone()
        upvb.Parent = sc.Parent
        upvb.Name = "LIUDEX"
        upvb.Title.Text = "LIUDEX Z"
        upvb.Frame.Visible = true
        upvb.Frame.Title.Text = "Addon"
        upvb.Button1.Title.Text = "DISCORD"
        upvb.Button1.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/WmsssRkgd2")
        end)
        upvb.Button.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/loadscript.lua"))()
        end)
        local upvb1 = sc:Clone()
        upvb1.Parent = sc.Parent
        upvb1.Name = "LIUDEX"
        upvb1.Title.Text = "Setting Theme"
        upvb1.Frame.Visible = true
        upvb1.Frame.Title.Text = "Edit Mod"
        upvb1.Button1.Title.Text = "DISCORD"
        upvb1.Button1.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/WmsssRkgd2")
        end)
        upvb1.Button.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/tools/editorMOD.lua"))()
        end)
        local upvb2 = sc:Clone()
        upvb2.Parent = sc.Parent
        upvb2.Name = "LIEX"
        upvb2.Title.Text = "LIEX"
        upvb2.Frame.Visible = true
        upvb2.Frame.Title.Text = "Botting Tools"
        upvb2.Button1.Title.Text = "DISCORD"
        upvb2.Button1.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/WmsssRkgd2")
        end)
        upvb.Button.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("print('wip')"))()
        end)
        local consl = dksja.Parent.Parent.Console
        dksja.BackgroundColor3 = bgColor
        dksja.Title.BackgroundColor3 = bgColor
        dksja.Source.BackgroundColor3 = bgColor
        dksja.Add.BackgroundColor3 = buttonColor
        if upvrL then
            local main = upvrL.Parent
            local consoleElement = main.Console.ConsoleElements
            local mainconsole = main.Console.RobloxConsole.Console.ScrollingFrame
            local success = consoleElement.Output:Clone()
            success.Content.TextColor3 = Color3.fromRGB(0,255,0)
            success.Name = "Success"
            success.Parent = consoleElement
            local lxprint = consoleElement.Output:Clone()
            lxprint.Content.TextColor3 = Color3.fromRGB(66, 23, 176)
            lxprint.Name = "Print"
            lxprint.Parent = consoleElement
            local suc = 1
            local prt = 1
            getgenv().Success = function(...)
                local f = success:Clone()
                f.Parent = mainconsole.Header
                f.Visible = true
                f.Name = suc .. "Success"
                local args = {...}
                local fsrt = table.concat(args," ")
                f.Content.Text = tostring(fsrt)
                suc = suc + 1
            end
            getgenv().lprint = function(...)
                local f = lxprint:Clone()
                f.Parent = mainconsole.Header
                f.Name = prt .. "Print"
                f.Visible = true
                local args = {...}
                local fsrt = table.concat(args," ")
                f.Content.Text = tostring(fsrt)
                prt = prt + 1
            end
            getgenv().fetchprint = function(tbl)
                for i,v in pairs(tbl) do
                    print(i,v)
                end
            end
        end
        if consl then
            consl.RobloxConsole.BackgroundColor3 = buttonColor
            consl.RobloxConsole.Console.BackgroundColor3 = bgColor
            consl.RConsole.BackgroundColor3 = buttonColor
            consl.RConsole.Console.BackgroundColor3 = bgColor
        end
    end
end

local function fixButton(btn)
    if btn:IsA("ImageButton") then
        btn.BackgroundColor3 = buttonColor
        btn.Changed:Connect(function(prop)
            if prop == "BackgroundColor3" and btn.BackgroundColor3 ~= buttonColor then
                btn.BackgroundColor3 = buttonColor
            end
        end)
    end
end

local main = gethui()
task.spawn(function()
    for i,v in ipairs(main:GetChildren()) do
        if v:IsA("ScreenGui") then
            if #v:GetChildren() == 1 then
                for l,n in ipairs(v:GetChildren()) do
                if n:IsA("ImageButton") and string.match(tostring(n.Image),"logo.png") and #n:GetChildren() == 2 then
                    iconLogo = n
                    for b,m in ipairs(n:GetChildren()) do
                        if m:IsA("UIStroke") then
                            m.Color = borderColor
                        end
                    end
                end
            end
            end
       end
    end
end)
-- run
mod()

task.wait()
additional()
local s,err = pcall(function()
    onece_change()
end)
if iconLogo then
    iconLogo.Image = getcustomasset("new_logo.png")
end

for _, gui in ipairs(main:GetChildren()) do
    if gui:IsA("ScreenGui") then
        -- Executor
        local executor = gui:FindFirstChild("Executor")
        if executor then
            executor.DescendantAdded:Connect(function(obj) mod() end)
            executor.DescendantRemoving:Connect(function(obj) mod() end)
        end
         if executor then
        executor.Executor.Overlay.Tabs.ChildAdded:Connect(function(child)
            if child:IsA("ImageButton") then
                child.BackgroundColor3 = buttonColor
            end
        end)
            local console = executor.Parent.Console.RobloxConsole.Console.ScrollingFrame.Header
        end
        if executor then
        local place = executor.Parent
        local setting = place.Settings
        if setting then
            setting.DescendantAdded:Connect(function(obj) mod() end)
            setting.DescendantRemoving:Connect(function(obj) mod() end)
            if setting.Holder then
                for u,n in ipairs(setting.Holder:GetChildren()) do
                    if n:IsA("Frame") then
                        n.Changed:Connect(function(prop)
                            if prop == "BackgroundColor3" and n.BackgroundColor3 ~= bgColor then
                                n.BackgroundColor3 = bgColor
                            end
                        end)
                    end
                end
            end
        end
            -- set in frame
            for _, child in ipairs(setting:GetDescendants()) do
                fixButton(child)
            end
            setting.DescendantAdded:Connect(function(obj) fixButton(obj) end)
        end
        -- Home
        local home = gui:FindFirstChild("Home")
        if home then
            home.Holder.ChildAdded:Connect(function(obj) mod() end)
            home.DescendantRemoving:Connect(function(obj) mod() end)
        end
    end
end

uis.InputBegan:Connect(function(inpt, gp)
    if gp then return end

    if uis:IsKeyDown(Enum.KeyCode.K) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        game:Shutdown()
    end
    if uis:IsKeyDown(Enum.KeyCode.K) and uis:IsKeyDown(Enum.KeyCode.LeftShift) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        game:GetService("NetworkServer") --idk why but if you use delta it will close your roblox
    end
    if uis:IsKeyDown(Enum.KeyCode.J) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        setclipboard(game.JobId)
    end
    if uis:IsKeyDown(Enum.KeyCode.P) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        setclipboard(game.PlaceId)
    end
    if uis:IsKeyDown(Enum.KeyCode.Slash) and uis:IsKeyDown(Enum.KeyCode.C) and uis:IsKeyDown(Enum.KeyCode.Equals) then
        setclipboard("CFrame.new(" .. tostring(getchar().HumanoidRootPart.CFrame) .. ")")
    end
    if uis:IsKeyDown(Enum.KeyCode.N) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        local Http = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local count = maxCount or 10
        local servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
        for i, v in pairs(servers) do
            if v.playing < v.maxPlayers then
                TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
                break
            end
        end
    end 
    if uis:IsKeyDown(Enum.KeyCode.B) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
    end
    if uis:IsKeyDown(Enum.KeyCode.H) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/dex.lua"))()
    end
    if uis:IsKeyDown(Enum.KeyCode.L) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/loadscript.lua"))()
    end
    if uis:IsKeyDown(Enum.KeyCode.E) and uis:IsKeyDown(Enum.KeyCode.LeftControl) and uis:IsKeyDown(Enum.KeyCode.LeftAlt) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/tools/editorMOD.lua"))()
    end
end)
-- hidehui loader
loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/tools/cmd.lua"))()

getgenv().dumpsenv = function(scripts,advance,res) -- get script env from registry and garbage collection
    local ftbl = {
        func = {},
        thread = {},
        connection = {},
        RBXSignal = {},
        tbl = {},
        mtmethod = {},
        renv = {}
    }
    local filter = {
        func = {},
        thread = {},
        connection = {},
        RBXSignal = {},
        tbl = {},
        mtmethod = {},
    }
    local src = ""
    if typeof(scripts) ~= "string" then
        src = scripts:GetFullName()
    else
        src = scripts
    end
    local tfunc = 0
    local tthread = 0
    local tcon = 0
    local mtmth = 0
    local renvc = 0
    local rbxsig = 0
    local gr = false
    for i,v in next,getgc(true) do
        if typeof(v) == "function" then
            local info = debug.getinfo(v)
            tfunc = 1 + tfunc
            local id = tostring(v):match("function:%s(.-)$")
            if debug.info(v,"s"):match(src) and not (info.name == "__index" or info.name == "__tostring" or info.name == "__namecall" or info.name == "__newindex") and not filter.func[id] then
                table.insert(ftbl.func,v)
                filter.func[id] = true
            end
            if advance then
            if typeof(v) == "function" then
                if (info.name == "__index" or info.name == "__tostring" or info.name == "__namecall" or info.name == "__newindex") then
                    mtmth = mtmth + 1
                    if debug.info(v,"s"):match(src) then
                        print(debug.info(v,"sn"))
                        table.insert(ftbl.mtmethod,v)
                    end
                end
                if v == getrenv()[info] then
                    renvc = renvc + 1
                    table.insert(ftbl.renv,v)
                end
            end
            end
        end 

        if typeof(v) == "thread" then
            local id = tostring(v):match("thread:%s(.-)$")
            tthread = tthread + 1
            if getscriptfromthread(v) == scripts and not filter.thread[id] then
                table.insert(ftbl.thread,v)
                filter.thread[id] = true
            end
        end
        
        if typeof(v) == "Connection" then
            tcon = tcon + 1
            local f = v.Function
            if f then
                if debug.getinfo(f).source:match(src) then
                    table.insert(ftbl.connection,v)
                end
            end
        end
        if typeof(v) == "RBXScriptSignal" then
            tcon = tcon + 1
            local f = v.Connect
            rbxsig = rbxsig + 1
            local id = tostring(f):match("function:%s(.-)$")
            if debug.info(f,"s"):match(src) and not filter.RBXSignal[id] then
                table.insert(ftbl.RBXSignal,v)
                filter.RBXSignal[id] = true
            end
        end
    end
    for i,v in next, getreg() do
        local id = tostring(v):match("thread:%s(.-)$")
        if typeof(v) == "thread" then
            local id = tostring(v):match("thread:%s(.-)$")
            tthread = tthread + 1
            if getscriptfromthread(v) == scripts and not filter.thread[id] then
                table.insert(ftbl.thread,v)
                filter.thread[id] = true
            end
        end
    end
    if res then
        print("function found:", #ftbl.func, "of", tfunc, 
            "\nthread found:", #ftbl.thread, "of", tthread, 
            "\nconnection found:", #ftbl.connection, "of", tcon,
            "\nmetamethod found:",#ftbl.mtmethod,"of",mtmth,
            "\nRBXSignal found:",#ftbl.RBXSignal,"of",rbxsig)
    end
    repeat
        task.wait()
    until gr == true
return ftbl
end 

--[[local l = 1
print("hello")
for i,v in pairs(getgc()) do
    if not islclosure(v) and not isfunctionhooked(v) and not debug.info(v,"n") ~= "" then
        print(l,debug.info(v,"ns"))
        l = l + 1
    end
end

getgenv().gettabletype = function(tbl)
	local types = {}
	local result = {}
	
	for _, v in pairs(tbl) do
		local t = typeof(v)
		if not types[t] then
			types[t] = true
			table.insert(result, t)
		end
	end
	
	return result
end
]]
getgenv().setautoexecute = function(name,script,place)
if not isfile(maindir .. "/AutoExecute/" .. game.PlaceId) then
    makedir(maindir .. "/AutoExecute/" .. game.PlaceId)
end
if place then
writefile(maindir .. "/AutoExecute/" .. game.PlaceId .. name,script)
return
end
writefile(maindir .. "/AutoExecute/Universal/" .. name,script)
end

getgenv().savescript = function(name,script,place)
    if not isfile(maindir .. "/Scripts/" .. game.PlaceId) then
        makedir(maindir .. "/Scripts/" .. game.PlaceId)
    end
    if place then
        writefile(maindir .. "/Scripts/" .. game.PlaceId .. name,script)
        return
    end
    writefile(maindir .. "/Scripts/Universal/" .. name,script)
end
