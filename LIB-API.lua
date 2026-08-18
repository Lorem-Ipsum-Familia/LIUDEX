--report to our community if you find an error
--https://discord.gg/WmsssRkgd2
if getgenv().liudex and getgenv().ex  then
  warn("liudex env is already attached")
  return
end

getgenv().import = {
  packages = {
    ["Overrider"] = "https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/packages/Override.lua",
    ["Waypoint"] = "https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/packages/Waypoint.lua",
    ["Socket"] = "https://raw.githubusercontent.com/Asepthegoat/LoremIpsum/refs/heads/main/LIEX/main.lua"
  }
} 
setmetatable(import, {
    __index = function(self, name)
        local success, cache = pcall(function()
            return cloneref(game:GetService(name))
        end)
        if success then
            rawset(self, name, cache)
            return cache
        else
            warn("Invalid Service: " .. tostring(name))
        end
    end
})
local TweenService = import.TweenService
local gameVar8 = import.Debris
local LDXZSet = {
  players = import.Players,
  player = import.Players.LocalPlayer,
  UIS = import.UserInputService,
  TS = import.TweenService,
  Http = import.HttpService,
  Replicated = import.ReplicatedStorage,
}

local olderrPromptbackground = Color3.fromRGB(57, 59, 61)
local olderrOverlaybackground = Color3.fromRGB(0, 0, 0)
local olderrButtonColor = Color3.fromRGB(255, 255, 255)
--new error data
local newerrPromptbackground = Color3.fromRGB(40, 0, 77)
local newerrOverlaybackground = Color3.fromRGB(25, 5, 55)
local newerrButtonColor = Color3.fromRGB(150, 60, 255)

function getchar()
  return import.Players.LocalPlayer.Character
end

function getplayer(p)
  if typeof(p):lower() == "number" then
    return LDXZSet.players:GetPlayerByUserId(p)
  elseif typeof(p):lower() == "string" then
    return LDXZSet.players[p]
  end
  return LDXZSet.player
end

function getclosurecallargs(closure, waitfor)
    local called = false
    local args
    local old;old = hookfunction(closure,function(...)
        if not called then
            args = table.pack(...)
            called = true

            task.defer(function()
                pcall(restorefunction,closure)
            end)
        end
        return old(...)
    end)
    if typeof(waitfor) == "function" then
        return task.spawn(function()  
            repeat task.wait(0.1) until called 
            task.wait()
            waitfor(unpack(args)) 
        end)
    elseif waitfor then
        repeat task.wait(0.1) until called
        return args
    end
end

function getaddress(obj)
  return tostring(obj):split(": ")[2]
end

function waitrandom(mindelay,maxdelay)
  local min = mindelay or 0
  local max = maxdelay or 1
  return task.wait(math.random(min,max))
end

function isprivateserver()
  return import.RobloxReplicatedStorage.GetServerType:InvokeServer() == "VIPServer"
end

function waituntil(condition,time) --use like this waituntil(function() return var end)
    local count = 0
    local ftime = time or 10
    repeat
      task.wait(0.1)
      count = count + 0.1
    until condition() or count >= ftime
    return true
end

function taskcount(target) -- like task.count(67,0.1)
  local total = target or 9e9 --dont use math.huge
  local tabl = {}
  local count = 0 
  while count <= total do
    task.wait(0.1)
    count = count + 0.1 --this should be like count + 0.1
  end
  tabl["time"] = total
  tabl["status"] = true
  return tabl
end

function run_on_func(func, run)
    local oldfunc
    oldfunc = hookfunction(func, function(self,...)
    local args = {...}
        task.spawn(function()
            run(self,args)
        end)
        return oldfunc(self, ...)
    end)
end

function run_on_method(methodname, run, selv)
    local oldmethod
    local h = selv or game
    oldmethod = hookmetamethod(h, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == methodname then
            task.spawn(function()
                run(self,args)
            end)
        end
        return oldmethod(self, ...)
    end)
end

function setoffline() --lite version of liudex:StopGame()
  getplayer():Kick("Wait a Second for Set Offline...")
  task.wait(1)
  import.GuiService:ClearError()
end 

function limitsendkbps(int)
  import.NetworkClient:SetOutgoingKBPSLimit(int)
end

function isoffline()
if not getplayer():FindFirstChild("PlayerScripts") then
  return true
end
return false
end

function setcamfocus(Instance)
  workspace.Camera.CameraSubject = Instance
end

function clonechar() --used to move while offline
local Players = game:GetService("Players")
local oldChar = getchar()
local animate = oldChar:FindFirstChild("Animate")

local userId = getplayer().UserId
local characterModel = Players:CreateHumanoidModelFromUserId(userId)

characterModel.Parent = game.Workspace
characterModel:MoveTo(getchar().HumanoidRootPart.Position)
getplayer().Character= characterModel
setcamfocus(characterModel.Humanoid)
local h = characterModel.Humanoid
loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/assets/animator.lua"))()
h.Died:Connect(function() clonechar() task.wait(1) h.Parent:Destroy() end)
return characterModel, oldChar
end

function setnewchar(instance)
  getplayer().Character = instance
  setcamfocus(instance:FindFirstChild("Humanoid") or instance)
end

function isnewclient()
   local cid = getrawmetatable(import.RbxAnalyticsService)
    if isfunctionhooked(cid.__namecall) or isfunctionhooked(gethwid) then
        return true
    end
    return false
end

function insertasset(assetid,i,bool)
local index = i or 1
if bool then
	local obj = import.InsertService:LoadLocalAsset(assetid)
	return obj
end
local objects = game:GetObjects(assetid)
local model = objects[index]
return model
end

function insertrbxmx(file,i,bool)
local index = i or 1
if bool then
  local obj = import.InsertService:LoadLocalAsset(getcustomasset(file))
  return obj
end
local objects = game:GetObjects(getcustomasset(file))
local model = objects[index]
return model
end

function insertobjrbxmx(file,bool,i)
  local index = i or 1
  if bool then
	local obj = import.InsertService:LoadLocalAsset(getcustomasset(file))
	return obj
	end
  local obj = game:GetObjects(getcustomasset(file))
  return obj
end

function getclientid()
return import.RbxAnalyticsService:GetClientId()
end

if not getgenv().gethwid or gethwid then --just in case if its a new executor that has no gethwid function
  getgenv().gethwid = getclientid 
end

function getsessionid()
  return import.RbxAnalyticsService:GetSessionId()
end

function getdeviceid()
  local key = 5
  local str = import.DeviceIdService:GetDeviceId()
    local result = ""

    for l = 1, #str do

        local s = string.byte(str, l)
        local t = ((s + l) % 26) + 97
        local r = string.char(t)
        local i = string.char(((s + l) % 26) + 97)
        local n = (s + key) % 10
        local g = tostring(n) 

      if (l % 2 == 1) then
      result = result .. r:upper() .. i .. g .. l
      else
      result = result .. r .. i .. g .. l
      end
    end

    return string.reverse(result)
end

function getrootpart()
  return getchar().HumanoidRootPart
end

function gethumanoid()
  return getchar().Humanoid
end

function getmethods(instance)
  local tbl = {}
  for i,v in pairs(import.ReflectionService:GetMethodsOfClass(instance.className)) do
    pcall(function() tbl[v.Name] = instance[v.Name] or nil end)
  end
  return tbl
end

function getevents(instance)
  local tbl = {}
  for i,v in pairs(import.ReflectionService:GetEventsOfClass(instance.className)) do
    pcall(function() tbl[v.Name] = instance[v.Name] or nil end)
  end
  return tbl
end

local oldclientid
local clientidhooked = false
local clientnewid = nil
function setclientid(newid)
 local newclientid = newid
 clientnewid = newclientid
 if not clientidhooked then
	oldclientid =  nil
    oldclientid = hookmetamethod(import.RbxAnalyticsService,"__namecall",newcclosure(function(...)
     if getnamecallmethod() == "GetClientId" then
    	return newclientid
    end
    return oldclientid(...)
    end))
  end
  clientidhooked = true
end

getgenv().newclient = function()
  local id = uid()
  setclientid(id)
  return id
end

function onspawn(func)
	local player = getplayer()

	player.CharacterAdded:Connect(function()
		func()
	end)
end

function gototarget(to,tween,speed)
	if tween then
    local RunService = import.RunService
    local rootPart = getchar():WaitForChild("HumanoidRootPart")

    local startCFrame = rootPart.CFrame
    local duration = (rootPart.Position - to).Magnitude / speed
    local elapsed = 0 

    tween = RunService.Heartbeat:Connect(function(deltaTime)
        if tween then
            elapsed = elapsed + deltaTime
            local alpha = math.clamp(elapsed / duration, 0, 1)
            rootPart.CFrame = startCFrame:Lerp(CFrame.new(to), alpha)
            duration = (rootPart.Position - to).Magnitude / 250
            elapsed = 0 
            startCFrame = rootPart.CFrame
            if alpha >= 1 then
                tween:Disconnect()
                ldx:Notify("Done")
            end
        end
    end)
  else
    local char = getchar()
	  local hrp = char.HumanoidRootPart
	  hrp.CFrame = to.CFrame
  end
end

function dohttpscript(sc)
   loadstring(game:HttpGet(sc))()
end

function formatLuaString() --skided from moon
	local string = string
	local gsub = string.gsub
	local format = string.format
	local char = string.char
	local cleanTable = {['"'] = '\\"', ['\\'] = '\\\\'}
	for i = 0,31 do
		cleanTable[char(i)] = "\\"..format("%03d",i)
	end
	for i = 127,255 do
		cleanTable[char(i)] = "\\"..format("%03d",i)
	end

	return function(str)
		return gsub(str,"[\"\\\0-\31\127-\255]",cleanTable)
	end
end

function isservice(ins)
    return game:GetService(ins.ClassName) ~= nil
end


function safefullname(ins)
    local gch,cins,path = false,ins,""
    while true do
        if cins == game then
            path = "game" .. path
            break
        end
        if cins.Parent:FindFirstChild(cins.Name) ~= cins then
            for i,v in ipairs(cins.Parent:GetChildren()) do
                if v == cins then
                    cins = cins.Parent
                    path = ":GetChildren()" .. "[" .. i .. "]" .. path
                    break
                end
            end
        elseif isservice(cins) then
            indexName = ':GetService("'..cins.Name..'")'
            path = indexName .. path
            cins = cins.Parent
        else
            local indexName = ""
            if string.match(cins.Name,"^[%a_][%w_]*$") then
                indexName = "." .. cins.Name
            else
                local cleanName = formatLuaString()(cins.Name)
                indexName = '["'..cleanName..'"]'
            end

            path = indexName .. path
            cins = cins.Parent
        end
    end
    return path
end

function download(file,url)
  writefile(file,game:HttpGet(url))
end

function filterstring(text, patterns)
	local result = text
	
	for i,v in ipairs(patterns) do
		result = string.gsub(result, v, "")
	end
	
	return result
end

function stringfy(data,type)
	local result
	local cf = data
	if type == "CFrame" then
		result = string.format("CFrame.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "Vector3" then
		result = string.format("Vector3.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "Color3" then
		result = string.format("Vector3.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "table" then
		local t = {}
		for k,v in pairs(data) do
			t[#t+1] = "["..k.."]="..tostring(v)
		end
		result = "{"..table.concat(t,",").."}"
	else
		result = tostring(data)
	end
	return result
end

function serialize(data,type)
	local result
	local cf = data
	if type == "CFrame" then
		result = string.format("CFrame.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "Vector3" then
		result = string.format("Vector3.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "Color3" then
		result = string.format("Vector3.new(%f,%f,%f)", cf.X, cf.Y, cf.Z)
	elseif type == "table" then
		local t = {}
		for k,v in pairs(data) do
			t[#t+1] = "["..k.."]="..tostring(v)
		end
		result = "{"..table.concat(t,",").."}"
	else
		result = tostring(data)
	end
	return result
end

function uid(bol)
  if bol then
    local guid = LDXZSet.Http:GenerateGUID(false)
    local uuid = guid:gsub("-","")
    return uuid
  else
    return LDXZSet.Http:GenerateGUID(false)
  end
end

function JSONDecode(val)
  return LDXZSet.Http:JSONDecode(val)
end

function JSONEncode(val)
  return LDXZSet.Http:JSONEncode(val)
end

function getservices(cloneref)
local service = {}
    if cloneref then
        for i,v in pairs(import.ReflectionService:GetClasses()) do
            if v.Permits["GetService"] then
                table.insert(service,cloneref(game:GetService(v.Name)))
            end
        end
    return service
    end
    for i,v in pairs(import.ReflectionService:GetClasses()) do
        if v.Permits["GetService"] then
            table.insert(service,game:GetService(v.Name))
        end
    end
    return service
end

--[[function createlicense(identify,database,key) --identify must be include your script name such as ldx or liudex
  local data = identify .. "|" .. gethwid()
  local host = database or "https://loremipsumapps/datastore/" .. identify
  local success, response  = pcall(request({
    Url = host,
    Method = "POST",
    Headers = {["Content-Type"] = "text/plain"},
    Body = data
  }))
  warn("Body:",response.Body,"\nStatusCode:",response.StatusCode,"\nStatusMessage:",response.StatusMessage)
  setclipboard(data)
  return true
end

function checklicense(key)
  if key then
  local args = string.split(key,"|")
  local host = args[1]
  local userlicense = args[2]
    local success, response  = pcall(request,{
    Url = host,
    Method = "POST",
    Headers = {["Content-Type"] = "text/plain"},
    Body = data
  })
  warn("Body:",response.Body,"\nStatusCode:",response.StatusCode,"\nStatusMessage:",response.StatusMessage)
  if success then
    return true
  end
  return false
  end
end]]


function postjson(uri,json)
	request({
			Url = uri,
			Method = "POST",
			Headers = {["Content-type"] = "application/json"},
			Body = json or JSONEncode(json)
		})
end

function generatevarchar(length)
	local chars = "abcdefghijklmnopqrstuvwxyz♪♦♥♠♣§£¢€¥ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>/?†‡★·±\∆•~μΠΩ√÷×¶←↑↓→°∞≠≈✓àâåæãáääßöō"
	local result = ""

	for i = 1, length do
		local rand = math.random(1, #chars)
		result = result .. chars:sub(rand, rand)
	end

	return result
end

local function randomarray(tab)
local s = math.random(#tab)
return tab[s]
end

local scriptenv 
--setup liudex
local liudexex = Instance.new("Folder")
liudexex.Name = generatevarchar(20)
liudexex.Parent = nil
if not getgenv().LDXDATASERVICE then
    local CloudService = Instance.new("Smoke")
    CloudService.Parent = liudexex
    CloudService.Name = "Request"

    local ReplicatedIdSet = Instance.new("Folder")
    ReplicatedIdSet.Name = "Repository"
    ReplicatedIdSet.Parent = liudexex

    local values = Instance.new("Camera")
    values.Name = "Configuration"
    values.Parent = liudexex

    local trashbin = Instance.new("Folder")
    trashbin.Name = "TrashBin"
    trashbin.Parent = liudexex

    -- jangan parent script ke TerrainRegion
    local script = getfenv().script
    script.Name = "LIUDEX Environment"
    script.Parent = ReplicatedIdSet
    script.Source = ""
    scriptenv = script

    getgenv().LDXDATASERVICE = {
        Storage = ReplicatedIdSet,
        TrashService = trashbin,
        ConfigurationService = values
    }
end
print(liudexex.Name)

function isldxattached()
  return true
end

function isscriptclosure(script,func)
  if typeof(func) == "function" and typeof(script) == "Instance" then
    local scriptsrc = script:GetFullName()
    local fsrc = debug.info(func,"s")
    if fsrc:match(scriptsrc) then
      return true
    else
      return false
    end
  elseif typeof(func) == "function" and (script == "[C]" or script == "C") then
    local fsrc = debug.info(func,"s")
    if fsrc == script then
      return "C"
    end
  else
    liudex:Announcement("Warning","Something wrong went your func isn't type of function get the function first or use ex:GetFunction(func) to get the function")
  end
end

function getldxstorage()
   return getgenv().LDXDATASERVICE["Storage"]
end

function findPlayer(partialName) -- Asep skill isue
    local lowerPartial = string.lower(partialName)
    for _, plr in ipairs(import.Players:GetChildren()) do
        -- cek apakah substring ada di nama player
        if string.find(string.lower(plr.Name), lowerPartial, 1, true) then
            return plr
        end
    end
    return nil
end

local function backnormal()
    task.wait(0.2)
    local errorprompt = game:GetService("CoreGui").RobloxPromptGui.promptOverlay
    local prompterror = errorprompt.ErrorPrompt
    errorprompt.BackgroundColor3 = olderrOverlaybackground
    prompterror.BackgroundColor3 = olderrPromptbackground
    task.wait()
end
-- method 
local ex = {}
ex.__index = ex
function ex.new()
    local self = setmetatable({}, ex)
    return self
end

function ex:GetScriptThread(patr,callback)
  for i,v in next, getreg() do
    if typeof(v) == "thread" then
      local script = getscriptfromthread(v)
      if string.find(tostring(script),patr,1,true) then
        if callback then
          callback(v,script)
        end
        return script
      end
    end
  end
end

function ex:GetRegThread(key,callback)
  local threads = {}
  local index = 0
  if key then
    for i,v in next, getreg() do
    if typeof(v) == "thread" then
      local script = getscriptfromthread(v)
      if string.find(tostring(script):lower(),key:lower(),1,true) then
        index = index + 1
        if callback then
          callback(i,v)
        end
        table.insert(threads,index,{ script, v })        
      end
    end
  end
  else
    for i,v in next, getreg() do
      if typeof(v) == "thread" then
        local script = getscriptfromthread(v)
        index = index + 1
        if callback then
          callback(i,v)
        end
        table.insert(threads,index,{ script, v })        
      end
    end
  end
  return threads
end

function ex:GetAllTable(filter)
  local tble = {}
  if not filter or filter == "" then
    for _, tbl in next, getgc(true) do 
      if type(tbl) == "table" then 
        if table.isfrozen(tbl) then setreadonly(tbl, false) end 
           table.insert(tble,tbl)
        end
      end
    return tble
  else
    for _, tbl in next, getgc(true) do 
        if type(tbl) == "table" then 
            if string.match(tostring(tbl):lower(),filter:lower()) then
            if table.isfrozen(tbl) then setreadonly(tbl, false) end
                table.insert(tble,tbl) 
            end
            end
        end
    return tble
  end
end

function ex:GetTable(filter)
  for _, tbl in next, getgc(true) do 
    if type(tbl) == "table" then 
        if table.isfrozen(tbl) then setreadonly(tbl, false) end 
            if rawget(tbl, filter) then
              return tbl
            end
        end
    end
end

local function getfunctionrefid(func)
    if not func then return nil end
    local f = debug.getinfo(func)
    
    return debug.info(func,"s") .. f.name .. tostring(f.line) .. f.what
end

function ex:GetAllFunction(targetfunc,detail,once,runf,...)
  local tablef = {}
  local functions = {}
  if targetfunc == "" or not targetfunc then
    for i,v in next, getgc() do
	    if typeof(v) ~= "function" or functions[getfunctionrefid(v)] then continue end
      table.insert(tablef,v)
      functions[getfunctionrefid(v)] = true
      local info = debug.getinfo(v)
      if (info.name == "" or info.name == nil) and islclosure(v) then
        print(i,"Source: ",debug.info(v,"s"),"\nHash: ", getfunctionhash(v),"\nFunction: ",info.func,"\nType",info.what,"\nLine: ",debug.info(v,"l"),"\n")
        task.wait()
      else
        print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nFunction: ",info.func,"\nType",info.what,"\nLine: ",debug.info(v,"l"),"\n")
      end
    end
  else
    for i,v in next, getgc() do
	    if typeof(v) ~= "function" or functions[getfunctionrefid(v)] then continue end
      local deb = debug.info(v,"n")
      local info = debug.getinfo(v)
      if string.match(deb:lower(),targetfunc:lower()) then
        table.insert(tablef,v)
        functions[getfunctionrefid(v)] = true
        if detail then
          if (info.name == "" or not info.name) and islclosure(v) then
            print("Source: ",debug.info(v,"s"),"\nHash: ", getfunctionhash(v),"\nFunction: ",info.func,"\nType",info.what,"\nLine: ",debug.info(v,"l"),"\n")
          else
            print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nFunction: ",info.func,"\nType",info.what,"\nLine: ",debug.info(v,"l"),"\n")
          end
        end
        if runf then
          v(...)
        end
      end
    end
  end
  return tablef
end

ex.FindFunction = ex.GetAllFunction

function ex:getspecificfunction(target,ssrc,detail,runf,...)
  for i,v in next, getgc() do
	if typeof(v) ~= "function" then continue end
    local info = debug.getinfo(v)
    
    if debug.info(v,"n") == target and ssrc and ssrc ~= "" and debug.info(v,"s"):find(ssrc) then
      if detail then
        print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nFunc: ",info.func,"\nType",info.what,"\nCurrentLine: ",info.currentline,"\n")
      end
      if runf then
        v(...)
      end
	return v
    elseif debug.info(v,"n") == target and (ssrc == "" or not ssrc) then
      if detail then
        print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nFunc: ",info.func,"\nType",info.what,"\nCurrentLine: ",info.currentline,"\n")
      end
      if runf then
        v(...)
      end
	 return v
    end
  end
end

function ex:GetHashFunction(hashFunc,regorgc,detail)
  if regorgc then
    for i,v in next, getreg() do
      if typeof(v) == "function" then
        if getfunctionhash(v):match(hashFunc) then
          if detail then
            local info = debug.getinfo(v)
             print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nHash",getfunctionhash(v),"\nFunc: ",info.func,"\nType",info.what,"\nCurrentLine: ",info.currentline,"\n")
          end
          return v
        end
      end
    end
  else
    for i,v in next, getgc() do
      if typeof(v) == "function" then
        if getfunctionhash(v):match(hashFunc) then
          if detail then
            local info = debug.getinfo(v)
             print("Source: ",debug.info(v,"s"),"\nName: ", info.name,"\nHash",getfunctionhash(v),"\nFunc: ",info.func,"\nType",info.what,"\nCurrentLine: ",info.currentline,"\n")
          end
          return v
        end
      end
    end
  end
end

if not identifyexecutor or not identifyexecutor then
  getgenv().identifyexecutor = function(...)
    return "LIUDEX","Modified Executor","v 1.2"
  end
end

ex.GetFunction = ex.getspecificfunction

function ex:GetPlayTime(format)
  local t = math.floor(game.Workspace.DistributedGameTime)
  local tabl = {}
  if not format or format == "" then
    return t
  elseif format == "separate" then  
    tabl["Hour"] = t/3600
    tabl["Minutes"] = t/60
    tabl["Second"] = t/1
  elseif format == "clock" then
    tabl["Hour"] = math.floor(t / 3600)
    tabl["Minute"] = math.floor((t % 3600) / 60)
    tabl["Second"] = t % 60
  end
  return tabl
end

function ex:Respawn()
	LDXZSet.player.Character.Humanoid.Health = 0
end

function ex:ForceClose()
	game:Shutdown()
end

function ex:DisabledGamePlayPaused()
local COREGUI = import.CoreGui
local networkPaused = COREGUI.RobloxGui.ChildAdded:Connect(function(obj)
        if obj.Name == "CoreScripts/NetworkPause" then
            obj:Destroy()
        end
    end)
    COREGUI.RobloxGui["CoreScripts/NetworkPause"]:Destroy()
    import.GuiService:SetGameplayPausedNotificationEnabled(false)
end

ex.FC = ex.ForceClose
function ex:TriggerEvent(event,data)
	if event == "proximity" then
		fireproximityprompt(data)
	elseif event == "touch" then
		firetouchinterest(LDXZSet.player.Character.HumanoidRootPart,data,0)
		firetouchinterest(LDXZSet.player.Character.HumanoidRootPart,data,1)
	end
end

function ex:HttpScript(script)
  loadstring(game:HttpGet(script))()
end

local liudex = {}
liudex.__index = liudex

function liudex.new(name,prop)
	local self = setmetatable({}, liudex)
	self.Name = name
  	self.Property = prop
	return self
end
function liudex:SetProperty(prop)
  self.Property = prop
end
function liudex:GetName()
	print(self.Name)
end
function liudex:Respawn()
	LDXZSet.player.Character.Humanoid.Health = 0
end
function liudex:GetProperty()
	return self.Property
end
function liudex:Notify(title,text,icon,button1,button2,duration,callback)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
            Title = title,
            Icon = icon or nil, -- contoh ikon notifikasi default
            Text = text or "" or nil,
            Duration = 5,
            Callback = callback or nil,
            Button1 = button1 or nil,
            Button2 = button2 or nil,
})
end

--prompt stuff
local function corner(parent)
  local corners = Instance.new("UICorner")
  corners.CornerRadius = UDim.new(0,10)
  corners.Parent = parent
end

local function layout(par,pad)
    local s = Instance.new("UIListLayout")
    s.Parent = par
    s.SortOrder = Enum.SortOrder.LayoutOrder
    s.FillDirection = Enum.FillDirection.Vertical
    s.HorizontalAlignment = Enum.HorizontalAlignment.Center
    s.VerticalAlignment = Enum.VerticalAlignment.Top
    s.Padding = UDim.new(0,pad)
end

local function border(name,color,thickness,parrent)
	local border = Instance.new("UIStroke")
	border.Parent = parrent
	border.Name = name
	border.Color = color
	border.Thickness = thickness
	return border
end

local function padding(par,top,bot,left,rig)
    local b = Instance.new("UIPadding")
    b.Parent = par
    b.PaddingBottom = UDim.new(bot,0)
    b.PaddingTop = UDim.new(top,0)
    b.PaddingLeft = UDim.new(left,0)
    b.PaddingRight = UDim.new(rig,0)
end

function prompt(num,callback,tbl)
    local s = Instance.new("ScreenGui")
    s.Parent = gethui()
    s.Name = "LDXPrompt"
    if num == 1 then
        local base = Instance.new("Frame",s)
        base.Size = UDim2.new(0,250,0,330)
        base.Position = UDim2.new(0.5,-125,0.5,-190)
        base.BackgroundColor3 = Color3.fromRGB(15,0,45)
        corner(base)

        local close = Instance.new("TextButton",base)
        close.Size = UDim2.new(0,35,0,35)
        close.Position = UDim2.new(1,-45,0,5)
        close.BackgroundTransparency = 1
        close.Text = "X"
        close.TextSize = 17
        close.TextColor3 = Color3.new(0.5,0.5,0.5)
        corner(close)

        close.MouseButton1Click:Connect(function()
            s:Destroy()
        end)

        -- holder untuk auto layout
        local holder = Instance.new("Frame",base)
        holder.Size = UDim2.new(0.9,0,0.7,0)
        holder.Position = UDim2.new(0.05,0,0.08,0)
        holder.BackgroundTransparency = 1

        layout(holder,5)

        local Imagec = Instance.new("ImageLabel",holder)
        Imagec.Size = UDim2.new(0.55,0,0.55,0)
        Imagec.Image = tbl.logo or "rbxassetid://126569944133822"
        Imagec.BackgroundTransparency = 1
        corner(Imagec)

        local holder2 = Instance.new("Frame",holder)
        holder2.Size = UDim2.new(0.9,0,0.7,0)
        holder2.Position = UDim2.new(0.05,0,0.08,0)
        holder2.BackgroundTransparency = 1
        layout(holder2,1)

        local text = Instance.new("TextLabel",holder2)
        text.Size = UDim2.new(1,0,0,30)
        text.RichText = true
        text.Text = "<b>Join "..tbl.title.." Community Now</b>"
        text.TextColor3 = Color3.new(1,1,1)
        text.TextScaled = true
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left

        local text2 = Instance.new("TextLabel",holder2)
        text2.Size = UDim2.new(1,0,0,10)
        text2.RichText = true
        text2.Text = tbl.desc
        text2.TextXAlignment = Enum.TextXAlignment.Left
        text2.TextColor3 = Color3.new(1,1,1)
        text2.TextScaled = true
        text2.BackgroundTransparency = 1
        padding(text2,0,0,0.01,0)

        local space = Instance.new("TextLabel",holder2)
        space.Size = UDim2.new(1,0,0,5)
        space.Text = ""
        space.BackgroundTransparency = 1

        local text3 = Instance.new("TextLabel",holder2)
        text3.Size = UDim2.new(1,0,0,12)
        text3.RichText = true
        text3.Text = "By " .. tbl.founder
        text3.TextXAlignment = Enum.TextXAlignment.Left
        text3.TextColor3 = Color3.new(0.4,0.4,0.4)
        text3.TextScaled = true
        text3.BackgroundTransparency = 1
        padding(text3,0,0,0.01,0)
        border("S",Color3.fromRGB(45,0,160),1,Imagec)

        local Accept = Instance.new("TextButton",base)
        Accept.Size = UDim2.new(0.9,0,0,40)
        Accept.Position = UDim2.new(0.05,0,0.95,-40)
        Accept.Text = "<b><font color='rgb(255,255,255)'>Join Community</font></b>"
        Accept.RichText = true
        Accept.TextSize = 9
        Accept.BackgroundColor3 = Color3.fromRGB(68, 0, 234)
        corner(Accept)
        Imagec.LayoutOrder = 1
        holder2.LayoutOrder = 2
        Accept.MouseButton1Click:Connect(function()
            callback()
            task.wait()
            liudex:Notify(tbl.title,"Link copied place it on your browser to join",tbl.logo,"Close")
            s:Destroy()
        end)
    elseif num == 2 then
        local base = Instance.new("Frame",s)
        base.Size = UDim2.new(0,330,0,200)
        base.Position = UDim2.new(0.5,-160,0.5,-120)
        base.BackgroundColor3 = Color3.fromRGB(15,0,45)
        corner(base)
        layout(base,5)
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(1,0,0,30)

        local controls = require(getplayer().PlayerScripts:WaitForChild("PlayerModule")):GetControls()
        controls:Disable()

        box:CaptureFocus()
        local Overlay = Instance.new("Frame",s)
        Overlay.Size = UDim2.new(2,0,2,0)
        Overlay.Position = UDim2.new(-1,0,-1,0)
        Overlay.BackgroundColor3 = Color3.fromRGB(15,0,45)
        Overlay.BackgroundTransparency = 0.5
        Overlay.Active = true
        Overlay.ZIndex = -1

        -- holder untuk auto layout
        local holder = Instance.new("Frame",base)
        holder.Size = UDim2.new(0.9,0,0.2,0)
        holder.Position = UDim2.new(0.05,0,0.08,0)
        holder.BackgroundTransparency = 1

        local holder2 = Instance.new("Frame",base)
        holder2.Size = UDim2.new(0.9,0,0.4,0)
        holder2.Position = UDim2.new(0.05,0,0.08,0)
        holder2.BackgroundTransparency = 1

        local holder3 = Instance.new("Frame",base)
        holder3.Size = UDim2.new(0.9,0,0.02,0)
        holder3.BackgroundTransparency = 1

        local close = Instance.new("TextButton",holder)
        close.Size = UDim2.new(0,35,0,35)
        close.Position = UDim2.new(1,-20,0,5)
        close.BackgroundTransparency = 1
        close.Text = "X"
        close.TextSize = 17
        close.TextColor3 = Color3.new(0.9,0.9,0.9)
        corner(close)

        close.MouseButton1Click:Connect(function()
            controls:Enable()
            s:Destroy()
        end)

        local Imagec = Instance.new("ImageLabel",holder2)
        Imagec.Size = UDim2.new(0,55,0,55)
        Imagec.Position = UDim2.new(0.01,0,0,0)
        Imagec.Image = tbl.logo or "rbxassetid://126569944133822"
        Imagec.BackgroundTransparency = 1
        corner(Imagec)
        border("Storke",Color3.fromRGB(45,0,160),1,Imagec)

        local text = Instance.new("TextLabel",holder)
        text.Size = UDim2.new(0.9,0,0,15)
        text.RichText = true
        text.Position = UDim2.new(0,0,0,14)
        text.Text = "<b>"..tbl.title.."</b>"
        text.TextColor3 = Color3.new(1,1,1)
        text.TextScaled = true
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left

        local text2 = Instance.new("TextLabel",holder2)
        text2.Size = UDim2.new(0.8,0,0,40)
        text2.RichText = true
        text2.Position = UDim2.new(0.2,10,0,6)
        text2.Text = "<b>" .. tbl.desc .. "</b>"
        text2.TextColor3 = Color3.new(1,1,1)
        text2.TextScaled = false
        text2.TextWrapped = true
        text2.BackgroundTransparency = 1
        text2.TextXAlignment = Enum.TextXAlignment.Left
        text2.TextYAlignment = Enum.TextYAlignment.Top
            
        local Accept = Instance.new("TextButton",base)
        Accept.Size = UDim2.new(0.9,0,0,34)
        Accept.Position = UDim2.new(0.05,0,0.95,-40)
        Accept.Text = "<b><font color='rgb(255,255,255)'>" .. tbl.button .. "</font></b>"
        Accept.RichText = true
        Accept.TextSize = 9
        Accept.BackgroundColor3 = Color3.fromRGB(68, 0, 234)
        corner(Accept)
        Imagec.LayoutOrder = 1
        
        Accept.MouseButton1Click:Connect(function()
            controls:Enable()
            callback()
            task.wait()
            liudex:Notify(tbl.title,"Link copied place it on your browser to join",tbl.logo,"Close")
            s:Destroy()
        end)
        local text3 = Instance.new("TextLabel",base)
        text3.Size = UDim2.new(0.8,0,0,10)
        text3.RichText = true
        text3.Position = UDim2.new(0.2,10,0,6)
        text3.Text = tbl.founder
        text3.TextColor3 = Color3.new(1,1,1)
        text3.TextScaled = true
        text3.BackgroundTransparency = 1
        text3.TextXAlignment = Enum.TextXAlignment.Center
    end
    return s
end

function joinCommunity(tab)
    prompt(1,function() setclipboard(tab.url) end,tab)
end

function getPrompt(tab)
    prompt(2,function() setclipboard(tab.url) end,tab)
end

function liudex:RunScript(script,line)
  if line and line ~= "" then
    local var = string.split(script.Source,"\n")
    loadstring(var[line])()
  else
    loadstring(script.Source)()
  end
end

local delayannounce = 0.1
function liudex:Announcement(title,message)
	local tp = game:GetService("TeleportService") 
    local player = getplayer()
    tp:TeleportToPlaceInstance(game.PlaceId,"421151", player)
    task.wait(delayannounce)
    --prompt data
    local errorprompt = game:GetService("CoreGui").RobloxPromptGui.promptOverlay
    repeat
      task.wait(0.01)
    until errorprompt:FindFirstChild("ErrorPrompt")
    local prompterror = errorprompt:WaitForChild("ErrorPrompt")
    repeat
      task.wait(0.01)
    until prompterror.MessageArea.ErrorFrame.ButtonArea:FindFirstChild("OkButton")
    local okbutton = prompterror.MessageArea.ErrorFrame.ButtonArea:WaitForChild("OkButton")
    local BtnText = prompterror.MessageArea.ErrorFrame.ButtonArea.OkButton.ButtonText
    local Message = prompterror.MessageArea.ErrorFrame.ErrorMessage
    local Title =prompterror.TitleFrame.ErrorTitle
    errorprompt.BackgroundColor3 = newerrOverlaybackground
    prompterror.BackgroundColor3 = newerrPromptbackground
    task.wait()
    okbutton.ImageColor3 = newerrButtonColor
    okbutton.ButtonText.TextColor3 = olderrButtonColor
    delayannounce = 0.1
    if prompterror.BackgroundColor3 == newerrPromptbackground then
      errorprompt.BackgroundColor3 = newerrOverlaybackground
      prompterror.BackgroundColor3 = newerrPromptbackground
      okbutton.ImageColor3 = newerrButtonColor
      okbutton.ButtonText.TextColor3 = olderrButtonColor
    end
    task.wait(0.15)
	Title.Text = title or "LIUDEX Announcement"
    Message.Text = message or ""
    okbutton.MouseButton1Click:Connect(function()
    backnormal()
    end)
end

liudex.Announce = liudex.Announcement

function closeremote(remote)
  local rem
  rem = hookmetamethod(remote,"__namecall",function(self,...)
    local method = getnamecallmethod()
    if method == "Fire" or method == "FireServer" or method == "InvokeServer" or method == "Invoke" then
      return task.wait(9e9) --yield wait
    else
      return rem(self,...)
    end
  end)
end

function closeonclientevent(remote)
  local event = remote
  
  for _, Connection in getconnections(event.OnClientEvent) do
	  local old; old = hookfunction(Connection.Function, function(...)
		  return task.wait(9e9)
	  end)
  end
end

function disconnect_all_signal(sig)
    for _, conn in ipairs(getconnections(sig)) do
        conn:Disconnect()
    end
end

function liudex:StopGame(value)
    liudex:Announcement("LIUDEX","Stopping Game")
    if value == "Safe" then --safe but kinda laggy if your console Active
      getplayer():Remove()
	  liudex:Announcement("LIUDEX","Success Secure Player")
    else
      getplayer():Kick()
    end
	liudex:Announcement("LIUDEX","Game Stopped")
    for i,v in ipairs(game.Workspace:GetDescendants()) do
      if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        task.spawn(function()
          closeonclientevent(v)
        end)
        task.spawn(function()
          closeremote(v)
        end)
      elseif v:IsA("LocalScript") then
        v.Enabled = false
      end
    end
    for i,v in pairs(getreg()) do
      if typeof(v) == "thread" then
        pcall(function()
          coroutine.close(v)
          task.cancel(v)
        end)
      end
    end
	liudex:Announcement("LIUDEX","Game Stopped")
	disconnect_all_signal(game:GetService("ScriptContext").Error) -- stop report error
    disconnect_all_signal(getplayer().Character.Humanoid.Changed) --stop send Changed signal
    disconnect_all_signal(getplayer().Character.HumanoidRootPart.Changed)
    disconnect_all_signal(getchar().Humanoid.ChildAdded) -- stop send ChildAdded sig
    disconnect_all_signal(getchar().HumanoidRootPart.ChildAdded)
	task.wait(1.5)
	game:GetService("GuiService"):ClearError()
end

function liudex:RequestNgrok(uri)
    local response = request({
    Url = uri,
    Method = "GET",
    Headers = {
        ["ngrok-skip-browser-warning"] = "true"
    }
    })
    return response.Body
end
local services = {
  ["Override"] = "https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/packages/Override.lua",
  ["Waypoint"] = "https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/packages/Waypoint.lua"
}
function liudex:GetService(service)
  local path = getgenv().LDXDATASERVICE
  if service == "Repository" or service == "Storage" then
    return path["Storage"]
  elseif services[service] then return loadstring(game:HttpGet(services[service]))()
  end
end

--env signal dari aai gpt and for now this still useless
local ldxEnabled = false
local liudexEnv = {}
liudexEnv.__index = liudexEnv
function liudexEnv.new(instance)
	local self = setmetatable({}, LDXSignal)
	self.Name = instance
	self._connections = {} -- tempat simpan callback
	return self
end

function liudexEnv:Fire(...)
	for _, conn in ipairs(self._connections) do
		if conn.Connected then
			conn.Callback(...)
		end
	end
end

function liudexEnv:Read(func,...)
  ldxEnabled = true
  func(...)
  ldxEnabled = false
end

function liudexEnv:Recive(callback)
	local connection = {
		Callback = callback,
		Connected = true
	}

	function connection:Disconnect()
		self.Connected = false
	end

	table.insert(self._connections, connection)
	return connection
end

function liudexEnv:Wait()
	local thread = coroutine.running()
	local connection

	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(thread, ...)
	end)

	return coroutine.yield()
end

function formatValue(val)
	if typeof(val) == "string" then
		return "[[" .. val .. "]]"

  elseif typeof(val) == "ColorSequence" then
   return "ColorSequence.new(" .. val .. ")"

  elseif typeof(val) == "NumberSequence" then
	  local str = "NumberSequence.new({"
	
	  for i, v in ipairs(val.Keypoints) do
	  	str = str .. "NumberSequenceKeypoint.new(" .. v.Time .. "," .. v.Value .. ")"
      
	  	if i < #val.Keypoints then
	  		str = str .. ","
	  	end
	  end
	
	  str = str .. "})"
	  return str

  elseif typeof(val) == "BrickColor" then
    return 'BrickColor.new("' .. tostring(val) .. '")'

	elseif typeof(val) == "number" or typeof(val) == "boolean" then
		return tostring(val)

	elseif typeof(val) == "UDim2" then
		return "UDim2.new(" 
			.. val.X.Scale .. "," .. val.X.Offset .. "," 
			.. val.Y.Scale .. "," .. val.Y.Offset .. ")"
  
  elseif typeof(val) == "UDim" then
		return "UDim.new(" .. val.Scale .. "," .. val.Offset .. ")"

  elseif typeof(val) == "CFrame" then
    local pos = val.Position
    local rv = val.RightVector
    local uv = val.UpVector
    local lv = val.LookVector
		return "CFrame.new(" 
			.. pos.X .. "," .. pos.Y .. "," .. pos.Z .. "," 
      .. rv.X .. "," .. rv.Y .. "," .. rv.Z .. ","
      .. uv.X .. "," .. uv.Y .. "," .. uv.Z .. ","
      .. lv.X .. "," .. lv.Y .. "," .. lv.Z .. ")"

  elseif typeof(val) == "Vector3" then
    return "Vector3.new(" .. val.X .. "," .. val.Y .. "," .. val.Z .. ")"
  
  elseif typeof(val) == "Vector2" then
    return "Vector2.new(" .. val.X .. "," .. val.Y .. ")"

	elseif typeof(val) == "Color3" then
		return "Color3.fromRGB(" 
			.. math.floor(val.R*255) .. "," 
			.. math.floor(val.G*255) .. "," 
			.. math.floor(val.B*255) .. ")"

  elseif typeof(val) == "Rect" then
    return "Rect.new(" .. val.Min.X .. "," .. val.Min.Y .. "," .. val.Max.X .. "," .. val.Max.Y .. ")"

	elseif typeof(val) == "EnumItem" then
		return tostring(val)
	end

	return tostring(val)
end

local proptable = {
  "Name","Parent","Orientation",
  "Rotation","Size","AnchorPoint","CanCollide","CanTouch","CanQuery",
  "Anchored","Massless","Locked","LocalTransparencyModifier","Reflectance",
  "Material","Color","BrickColor","CastShadow","CollisionGroupId","AssemblyLinearVelocity",
  "AssemblyAngularVelocity","CustomPhysicalProperties","RootPriority",
  "Shape","TopSurface","BottomSurface","LeftSurface","RightSurface","FrontSurface",
  "BackSurface",

  "MeshId","TextureId","Scale","Offset","VertexColor","MeshType",
  "Velocity","MaxForce","P","AngularVelocity","MaxTorque","CFrame",
  "Attachment0","Attachment1","LightEmission","LightInfluence","Texture",
  "TextureLength","TextureSpeed","Transparency",
  "CurveSize0","CurveSize1","Segments","Width0","Width1","FaceCamera",
  "Brightness","Enabled","Range","Shadows","Angle",

  "Text","TextColor3","TextTransparency","TextSize","TextScaled","TextWrapped","Font","RichText","LineHeight",
  "PlaceholderText","PlaceholderColor3","ApplyStrokeMode","CornerRadius",
  "HoldDuration","KeyboardKeyCode","ObjectText","Value","Disabled","Source","LinkedSource","RunContext",
  "TextXAlignment","TextYAlignment",

  "Image","ImageColor3","ImageTransparency","ScaleType","SliceCenter","SliceScale",
  "BackgroundColor3","BackgroundTransparency","BorderSizePixel",
  "Position","Visible","ZIndex","ClipsDescendants","LayoutOrder",
  "ResetOnSpawn",
  "CanvasSize","CanvasPosition","ScrollBarThickness","Draggable",
  "ScrollingEnabled","ElasticBehavior","AutomaticCanvasSize","Padding",
  "PaddingBottom","PaddingLeft","PaddingRight","PaddingTop","AutomaticSize",
  "ShortOrder","VerticalFlex","HorizontalFlex","HorizontalAlignment",
  "VerticalAlignment","ItemLineAlignment","Wraps","Interactable","VerticalScrollBarPosition",
  "VerticalScrollBarInset","ScrollingDirection","TopImage","ScrollBarImageColor3",
  "ScrollBarImageTransparency","MidImage","HorizontalScrollBarInset","ElasticBehavior",
  "BottomImage","AutomaticCanvasSize"
} -- not all Property cuz im kinda lazy

local propthatcannil = {
  HoldDuration = true, Reflectance = true, ScrollingEnabled = true,
  Name = true, Image = true, CanCollide = true,
  CanTouch = true, CanQuery = true, Attachment0 = true,
  Attachment1 = true, Anchored = true, Value = true,
  LinkedSource = true, Massless = true, Locked = true,
  Enabled = true, BorderSizePixel = true,
  MeshId = true, Scale = true, ImageTransparency = true,
  TextSize = true, TextScaled = true, TextWrapped = true,
  RichText = true, Disabled = true, Source = true,
  Draggable = true, Position = true, Size = true,
  AnchorPoint = true, ResetOnSpawn = true,
  ZIndex = true, ClipsDescendants = true, LayoutOrder = true,
  BackgroundTransparency = true, PlaceholderText = true, Rotation = true,
  Transparency = true
}
function ispropempty(prop,type)
  type = typeof(prop)
  if type == "UDim2" then
    return prop == UDim2.new(0,0,0,0)
  elseif type == "UDim" then
    return prop == UDim.new(0,0)
  elseif type == "BrickColor" then
    return prop == BrickColor.new("White")
  elseif type == "number" then
    return prop == 0
  elseif type == "CFrame" then
    return prop == CFrame.new(0,0,0)
  elseif type == "Vector3" then
    return prop == Vector3.new(0,0,0)
  elseif type == "Vector2" then
    return prop == Vector2.new(0,0)
  elseif type == "string" then
    return prop == "" or prop == "rbxassetid://"
  end
end

local scrptststs = {}
local function GetInstanceInfo(instance,name,parent)
  local tabl = {}
  table.insert(tabl,name .. ' = Instance.new("' .. instance.ClassName .. '")')
      for u,prop in pairs(proptable) do
        pcall(function()
          local isempty = ispropempty(instance[prop])
          if prop ~= "Parent" and instance[prop] ~= nil and prop ~= "Source" then
            if propthatcannil[prop] and isempty then
                return
            end
           table.insert(tabl,name .. '.' .. prop .. " = " .. formatValue(instance[prop]))
          elseif prop == "Source" and instance[prop] and instance[prop] ~= "" then
            if instance[prop]:find("script.Parent") then
              local filt = instance[prop]:gsub("script.Parent",safefullname(instance) .. ".Parent")
              table.insert(scrptststs,"loadstring(" .. formatValue(filt) .. ")()\n")
              print(filt)
            else
              table.insert(scrptststs,formatValue(instance[prop]))
              print(instance[prop])
            end
          elseif instance[prop] ~= nil and prop == "Parent" then
            if propthatcannil[prop] and isempty then
                return
            end
            table.insert(tabl,name .. '.' .. prop .. " = " .. tostring(parent))
          end
        end)
      end
      if typeof(tabl) ~= "table" then
        warn("Error table got nil value")
      end
      local s = table.concat(tabl,"\n",1)
      return s
end

local function scangetinstance(obj,tab,parentname)
	for i, child in ipairs(obj:GetChildren()) do
    local parname = "ldxinstance['var" .. child.Name .. i .. "']"
		local var = GetInstanceInfo(child,parname,parentname)
		if var ~= nil then
			table.insert(tab,var)
		end
		scangetinstance(child,tab,parname)
	end
end

function liudex:SetInstanceAsClipboard(instance,parent) --a bit buggy you need to reparent sometime
  local tabl = {}
  scrptststs = {}
  local sl = GetInstanceInfo(instance,instance.Name,parent or "getldxstorage()")
  table.insert(tabl,"--This Code Generate by ldx SetInstanceAsClipboard\n--Thanks for using ldx SetInstanceAsClipboard we will improving this feature even more in the furture\n--join ldx community at https://discord.gg/WmsssRkgd2\nlocal ldxinstance = {}")
  table.insert(tabl,sl)
  scangetinstance(instance,tabl,instance)
  table.insert(tabl,table.concat(scrptststs,"\n",1))
  local s = table.concat(tabl,"\n\n",1)
  setclipboard(s)
  liudex:Announcement("LIUDEX","Instance copied to your clipboard")
end

function liudex:SetInstanceAsScript(filename,instance,parent) --a bit buggy you need to reparent sometime
  local tabl = {}
  scrptststs = {}
  local sl = GetInstanceInfo(instance,instance.Name,parent or "getldxstorage()")
  table.insert(tabl,"--This Code Generate by ldx SetInstanceAsScript\n--Thanks for using ldx SetInstanceAsClipboard we will improving this feature even more in the furture\n--join ldx community at https://discord.gg/WmsssRkgd2\nlocal ldxinstance = {}")
  table.insert(tabl,sl)
  scangetinstance(instance,tabl,instance)
  table.insert(tabl,table.concat(scrptststs,"\n",1))
  local s = table.concat(tabl,"\n\n",1)
  writefile(filename,s)
  liudex:Announcement("LIUDEX","Instance copied to your clipboard")
end

function checkfunction(f)
  if f then
    return true
  end
  return false
end

function callwithc(func,...)
  newcclosure(function(...)
    func(...)
  end)
end

function safecall(func,reffunc) 
  local old; old = hookfunction(debug.info, newcclosure(function(selffunc,info)
  if selffunc == func and not checkcaller() then
    return old(reffunc,info) --ini biar si kontol ngereturn function reference atau rial func
  end
  return old(selffunc,info)
end))
end

function ex:SpoofIndex(target,keyval,value)
  local old
  local t = target or game
    old = hookmetamethod(t,"__index",newcclosure(function(self,key)
    if self == target and key == keyval and not checkcaller() then
      return value
    end
    return old(self,key)
  end))
end
local ldxinfo = {
  imported = {},
  bypassed = {
    "Adonis","gcinfo"
  },
  version = "V 1.8.21"
}
function liudex:GetInfo(target)  
  for i,v in pairs(ldxinfo.imported) do
    if v then
      table.insert(tabl.imported,i)
    end
  end
  return tabl
end

getgenv().LDXSignal = LDXSignal 
getgenv().ex = ex
getgenv().liudex = liudex
getgenv().ldx = liudex

getgenv().getclientgithash = function()
  return import.RunService.ClientGitHash
end

local currentATrack
function loadanim(id,speed,timestamp,stopat)
    local exat = tick()
    local humanoid = gethumanoid()
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
      track:Stop()
    end
    
    if not id then return end

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. tostring(id)

    local ok, track = pcall(function()
        return animator:LoadAnimation(animation)
    end)

    if ok and track then
        currentATrack = track
        track.Priority = Enum.AnimationPriority.Action
        track:Play()
        if timestamp then
          track.TimePosition = timestamp
        end
        track:AdjustSpeed(speed or 1)

        task.spawn(function()
          while task.wait() do
            if stopat ~= 0 and stopat then
              if track.TimePosition >= stopat then
                print(track.TimePosition)
                track:Stop()
                break
              end
            end
          end
        end)
    end
    return track
end

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
return ftbl
end 

local signalhook = {}

getgenv().hooksignal = function(event,func)
  local con = {}
  for i,v in ipairs(getconnections(event)) do
    v:Disable()
    table.insert(con,v)
  end
  local newsignal = event:Connect(function(...)
    for i,v in ipairs(con) do
      local args = table.pack(func(...))
      if args[1] then 
        v:Enable()
        v:Fire(unpack(args,2,args.n))
        v:Disable()
      end
    end
    signalhook[event] = newsignal
    return newsignal
  end)
end

getgenv().restoresignal = function(event)
  signalhook[event]:Disconnect()
  for i,v in getconnections(event) do
    if v == signalhook[event] then continue end
    v:Enable()
  end
end

getgenv().hookconnection = function(connection,func)
  connection:Disable()
  event:Connect(function(...)
      local args = table.pack(func(connection,...))
      if args[1] then 
        connection:Enable()
        connection:Fire(unpack(args))
        connection:Disable()
      end
  end)
end

getgenv().isvipserver = isprivateserver

local scriptchunk = debug.getinfo(1).short_src

function isliudexcaller()
    local level = 0
    while level <= 500 do
        if not debug.isvalidlevel(level) then
            break
        end
        level = level + 1
    end
    local chunkname = debug.getinfo(level - 1).short_src
    return (scriptchunk == chunkname or string.find(chunkname,"ldx"))
end

setreadonly(debug,false)
debug.getvalidlevel = newcclosure(function()
    local level = 0
    if debug.isvalidlevel then
        while level <= 9e9 do
            if not debug.isvalidlevel(level) then
                break
            end
            level = level + 1
        end
        return level - 3
    end
    local yield = 0

    while level <= 9e9 do
        local a,b = pcall(function() getfenv(level + 1) end)
        if not a then break end
        level += 1
        if yield >= 100 then tas.wait(0.2) yield = 0 end
    end
return level - 4
end)
setreadonly(debug,true)

local ldxfenv = {
		"uid","generatevarchar",
		"run_on_func","run_on_method",
		"insertasset","insertrbxmx",
		"getchar","getplayer",
		"getldxstorage","dohttpscript",
		"prompt","joinCommunity",
		"getPrompt","closeremotefunction",
		"closeremoteevent","findPlayer",
    "disconnect_all_signal","isldxattached",
    "isscriptclosure","waituntil","checkfunction",
    "dohttpscript","safefullname","download",
    "gototarget","waitrandom","GetInstanceInfo",
	  "safecall","callwithc","clonechar","setoffline",
    "insertobjrbxmx","setclientid","gethumanoid",
    "getrootpart","getdeviceid","getsessionid",
    "getclientid","isoffline","setnewchar","isnewclient","setcamfocus",
    "loadanim","limitsendkbps","isprivateserver","formatValue",
    "getclosurecallargs","getmethods","getevents","getservices",
	"getaddress"
	} --regist to genv
for g,j in ipairs(ldxfenv) do
  getgenv()[j] = getfenv()[j]
end

--setup stuff
local parallel = Instance.new("Actor")
parallel.Name = "Safe Actor"
Instance.new("LocalScript",parallel).Name = "Dummy"
hooksignal(import.ReplicatedFirst.ChildAdded,function(child)
  if child == parallel then return false end
  return true, child
end)

parallel.Parent = import.ReplicatedFirst
run_on_actor(parallel,[[
task.desynchronize()
task.spawn(function()
  task.wait(9e9)
  print("Session End")
end)
]])

task.wait()
task.spawn(function()
  while task.wait(5) do
    getldxstorage().Parent.Name = generatevarchar(20)
  end
end)
task.defer(function()
  parallel.Parent = getldxstorage().Parent
  task.wait(0.1)
  liudex:Notify("LIB LOADED","https://asepthegoat.github.io/","rbxassetid://137460521289679")
end)

return true
