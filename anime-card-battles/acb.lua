--[[
	Loaded Check
--]]
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
local waitplayer = game.Players.LocalPlayer;
if waitplayer.Character then
	local waithrp = waitplayer.Character:WaitForChild("HumanoidRootPart");
else
    waitplayer.CharacterAdded:Wait()
    local waithrp = waitplayer.Character:WaitForChild("HumanoidRootPart")
end

--[[
	Roblox Services & Variables
--]]
local workspace = game:GetService("Workspace");
local player = game.Players.LocalPlayer;
local placeid = game.PlaceId;
local playerid = player.UserId;
local character = player.Character;
local username = player.Name;
local displayname = player.DisplayName;
local playerage = player.AccountAge;
local creatorid = game.CreatorId;
local creatortype = game.CreatorType;
local jobid = game.JobId;
local humanoidRootPart = character:WaitForChild("HumanoidRootPart");
local virtualinput = game:GetService("VirtualInputManager");
local virtualuser = game:GetService("VirtualUser");
local userinputservice = game:GetService("UserInputService");
local replicatedstorage = game:GetService("ReplicatedStorage");
local remotes = replicatedstorage:WaitForChild("Remotes");
local teleportservice = game:GetService("TeleportService");
local textchatserivce = game:GetService("TextChatService");
local textchannel = textchatserivce.TextChannels:WaitForChild("RBXGeneral");
local api = "https://games.roblox.com/v1/games/";
local http = game:GetService("HttpService");
local proximitypromptservice = game:GetService("ProximityPromptService");

--[[
	Libraries
--]]
local Fluent = (loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")))();
local InterfaceManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua")))();

--[[
	Helper Functions
--]]
local function generateRandomKey(length)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	local key = "";
	for i = 1, length do
		local randIndex = math.random(1, #chars);
		key = key .. string.sub(chars, randIndex, randIndex);
		task.wait(0.1);
	end;
	return key;
end;
local function antiAfk()
	player.Idled:Connect(function()
		virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(0.1);
		virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end);
	print("Anti Afk enabled");
end;
local function rejoinGame()
	task.wait(1);
	teleportservice:Teleport(placeid, player);
end;
local devid = {
	164011583,
	85087803,
	1607510152,
	417954849
};
local isdeveloper = table.find(devid, playerid) ~= nil;

--[[
	Library Variables
--]]
local statsParagraph, disclaimerParagraph, codesParagraph, updateLogParagraph, notesParagraph, informationParagraph;
local updatingParagraph = false;
local randomKey = generateRandomKey(9);
_G[randomKey] = {};
_G.ahKey = randomKey;
local guiWindow = {};
local Hub = _G[randomKey];

--[[
	Tables
--]]
local codes = {
	"RELEASE!",
	"THANKS4PLAYING!",
	"1KLIKES!",
	"2KLIKES!",
	"SUB2VALK!",
	"4KLIKES!",
	"5KLIKES!",
	"6KLIKES!",
	"500KVISITS!",
	"SORRYFORSHUTDOWN!",
	"SUB2TOADBOI!",
	"SUB2RIJORO!",
	"SUB2WIRY!",
	"SUB2CONSUME!",
	"SUB2D1SGUISED!",
	"SUB2ItsHappyYT1!",
	"SUB2Joltzy!",
	"1MVISITS!",
	"FOLLOWEXVAR1",
	"10KLIKES!",
};

--[[
	Teleport Tables
--]]
local otherLocations = {
	"Sword",
	"Lucky Spot",
	"Old Position Sword",
	"Old Position Infinite"
};
local otherCoordinates = {
	["Sword"] = Vector3.new(-5922.752930, 100.682877,-8288.595703),
	["Lucky Spot"] = Vector3.new(-5872.769531, 965.790771, -9323.985352),
	["Old Position Sword"] = Vector3.new(0, 0, 0),
	["Old Position Infinite"] = Vector3.new(0, 0, 0)
};
local npcTeleports = {
	"Heaven Infinite",
	"Heaven Tower",
	"Charm Merchant",
	"Potion Shop",
	"Strange Trader",
	"Card Fusion",
	"Card Packs",
	"Luck Fountain"
};
local mobTeleports = {
	"Earth's Mightiest",
	"Prince",
	"Knucklehead Ninja",
	"Rogue Ninja",
	"Limitless",
	"Substitute Reaper",
	"Rubber Boy",
	"Bald Hero"
};
local areaTeleports = {
	"Heavens Arena",
	"Obby Sword",
	"Spawn",
	"Cosmic Menace (Boss)",
	"Wicked Weaver (Boss)",
	"Cifer (Boss)",
	"King Of Curses (Boss)",
	"Shinobi God (Boss)",
	"Galactic Tyrant (Boss)"
};
local npcTeleportsCoordinates = {
	["Heaven Infinite"] = Vector3.new(454.615417, 250.529327,5928.994629),
	["Heaven Tower"] = Vector3.new(451.595367, 247.374268, 5980.721191),
	["Charm Merchant"] = Vector3.new(-5902.000977, 158.624985, -8741.383789),
	["Potion Shop"] = Vector3.new(-45.672028, 256.645111, 5976.190918),
	["Strange Trader"] = Vector3.new(523.097717, 247.374268, 6017.144531),
	["Card Fusion"] = Vector3.new(13131.391602, 84.905922, 11281.490234),
	["Card Packs"] = Vector3.new(-6024.296387, 152.574966, -8582.142578),
	["Luck Fountain"] = Vector3.new(-5971.769043, 156.174988, -8725.775391)
};
local mobsTeleportsCoordinates = {
	["Earth's Mightiest"] = Vector3.new(10939.111328, 340.554169, -5141.633789),
	["Prince"] = Vector3.new(10987.201172, 344.049896, -5241.321777),
	["Knucklehead Ninja"] = Vector3.new(4219.748535, 31.724997, 7506.525391),
	["Rogue Ninja"] = Vector3.new(4306.954102, 31.724993, 7506.855469),
	["Limitless"] = Vector3.new(-12.537902, 272.422241, 5996.07666),
	["Substitute Reaper"] = Vector3.new(-7901.751465, 734.372009, 6714.296875),
	["Rubber Boy"] = Vector3.new(13150.526367, 84.124977, 11365.570312),
	["Bald Hero"] = Vector3.new(-11790.704102, 152.171967, -8566.525391)
};
local areaTeleportCoordinates = {
	["Heavens Arena"] = Vector3.new(461.994751, 247.374268, 5954.683105),
	["Obby Sword"] = Vector3.new(-5922.752930, 100.682877,-8288.595703),
	["Spawn"] = Vector3.new(-5976.900391, 164.149963,-8885.563477),
	["Cosmic Menace (Boss)"] = Vector3.new(-11721.826172, 156.702225, -8551.984375),
	["Wicked Weaver (Boss)"] = Vector3.new(13107.546875, 84.274979, 11333.648438),
	["Cifer (Boss)"] = Vector3.new(-7899.03418, 734.354736, 6741.601562),
	["King Of Curses (Boss)"] = Vector3.new(-25.217384, 256.795135, 5882.467773),
	["Shinobi God (Boss)"] = Vector3.new(4258.674805, 31.874994, 7444.705078),
	["Galactic Tyrant (Boss)"] = Vector3.new(10927.65918, 352.19986, -5072.885254)
};

--[[
	Variables
--]]
local swordCooldown = player:WaitForChild("Stats"):WaitForChild("SwordObbyCD").Value;
local potionCount = 0;
local autoPotionsActive = false;
local autoSwordActive = false;
local canGoBack = false;
local tickCount

--[[
	Hub Functions
--]]
function Hub:Functions()
	--[[
		Character & Position Functions
	--]]
	self.setPrimaryPart = function()
		player = game.Players.LocalPlayer;
		character = player.Character;
		if character:FindFirstChild("HumanoidRootPart") then
			character.PrimaryPart = character.HumanoidRootPart;
		end;
	end;
	self.getOldPositionSword = function()
		if character and humanoidRootPart then
			local position = humanoidRootPart.Position;
			otherCoordinates["Old Position Sword"] = Vector3.new(position.X, (position.Y + 5), position.Z);
		end;
	end;
	self.getOldPositionInfinite = function()
		if character and humanoidRootPart then
			local position = humanoidRootPart.Position;
			otherCoordinates["Old Position Infinite"] = Vector3.new(position.X, (position.Y + 5), position.Z);
		end;
	end;
	self.characterTeleport = function(destination)
		if character and character.PrimaryPart then
			character:SetPrimaryPartCFrame(CFrame.new(destination));
			task.wait(0.1);
		else
			character = player.Character;
			self.setPrimaryPart();
		end;
	end;
	self.setPrimaryPart();
	player.CharacterAdded:Connect(function(newCharacter)
		player = game.Players.LocalPlayer;
		character = newCharacter;
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10);
		if humanoidRootPart then
			character.PrimaryPart = humanoidRootPart;
		end;
	end);

	--[[
		Code Functions
	--]]
	self.sendMessage = function(message)
		if textchannel then
			local success, result = pcall(function()
				return textchannel:SendAsync(message);
			end);
		else
			warn("TextChannel not found.");
		end;
	end;
	self.useCodes = function()
		for i = #codes, 1, -1 do
			local message = "/code " .. codes[i];
			self.sendMessage(message);
			task.wait(2);
		end;
	end;
	self.reverseCodes = function()
		local reversedCodesString = "";
		for i = #codes, 1, -1 do
			reversedCodesString = reversedCodesString .. codes[i];
			if i > 1 then
				reversedCodesString = reversedCodesString .. "\n";
			end;
		end;
		return reversedCodesString;
	end;
	self.reverseCodesCopy = function()
		local reversedCodesStringCopy = "";
		for i = #codes, 1, -1 do
			reversedCodesStringCopy = reversedCodesStringCopy .. "/code " .. codes[i];
			if i > 1 then
				reversedCodesStringCopy = reversedCodesStringCopy .. "\n";
			end;
		end;
		return reversedCodesStringCopy;
	end;

	--[[
		Auto Functions
	--]]
	self.grabPotions = function()
		local activePotions = workspace:WaitForChild("ActivePotions");
		for _, potion in ipairs(activePotions:GetChildren()) do
			local base = potion:FindFirstChild("Base");
			if base and base:FindFirstChild("TouchInterest") then
				firetouchinterest(base, humanoidRootPart, 0);
				task.wait(0.1);
				firetouchinterest(base, humanoidRootPart, 1);
				potionCount = potionCount + 1;
			end;
		end;
	end;
	self.grabSword = function()
		self.getOldPositionSword();
		local swordProximityPrompt = workspace.ObbySwordPrompt.SwordBlock.ProximityPrompt
		if swordProximityPrompt then
			self.characterTeleport(otherCoordinates["Sword"]);
			task.wait(0.25);
			fireproximityprompt(swordProximityPrompt);
			task.wait(1);
			canGoBack = true;
		end;
	end;
	self.autoInfinite = function()
		while self.autoInfiniteToggle.Value do
			local npcDavid = workspace.NPCs.David;
			task.wait(0.25);
			local davidHRP = npcDavid:WaitForChild("HumanoidRootPart")
			task.wait(0.25);
			local npcProximityPrompt = davidHRP.ProximityPrompt
			if npcProximityPrompt then
				fireproximityprompt(npcProximityPrompt);
			end;
			task.wait(1)
		end;
	end;
	self.autoHideBattle = function()
		task.wait(0.5);
		local stats = player:WaitForChild("Stats")
		local hideBattle = stats:WaitForChild("HideBattle")
		while self.autoHideBattleToggle.Value do
			if hideBattle then
				hideBattle.Value = true
			end
			task.wait(0.5)
		end;
	end;

	--[[
		Auto Loop Functions
	--]]
	self.autoPotionsLoop = function()
		while self.autoPotionsToggle.Value do
			self.grabPotions();
			task.wait(0.5);
		end;
	end;
	self.autoSwordLoop = function()
		while self.autoSwordToggle.Value do
			local swordObbyCD = swordCooldown;
			if swordObbyCD == 0 then
				self.grabSword();
				if canGoBack then
					self.characterTeleport(otherCoordinates["Old Position Sword"]);
					canGoBack = false;
				end;
			end;
			task.wait(0.5);
		end;
	end;

	--[[
		Paragraph Functions
	--]]
	self.updateParagraph = function()
		while self.autoPotionsToggle.Value or self.autoSwordToggle.Value do
			swordCooldown = (player.Stats:WaitForChild("SwordObbyCD")).Value;
			local totalPotions = potionCount;
			local timeLeft = swordCooldown;

			local uptimeInSeconds = tick() - tickCount
			local hours = math.floor(uptimeInSeconds / 3600)
			local minutes = math.floor((uptimeInSeconds % 3600) / 60)
			local seconds = uptimeInSeconds % 60
			local uptimeText = string.format("%02d hours, %02d minutes, %02d seconds", hours, minutes, seconds)

			statsParagraph:SetDesc("Total Potions: " .. totalPotions 
				.. "\nSword Timer: " .. timeLeft 
				.. "\n" .. uptimeText);
			task.wait(0.2);
		end;
	end;
	self.updateParagraphStatus = function()
		if autoPotionsActive or autoSwordActive then
			if not updatingParagraph then
				updatingParagraph = true;
				task.spawn(self.updateParagraph);
			end;
		elseif updatingParagraph then
			updatingParagraph = false;
		end;
	end;
end;
function Hub:Gui()
	--[[
		Gui Init
	--]]
	guiWindow[randomKey] = Fluent:CreateWindow({
		Title = "UK1 Hub",
		SubTitle = "by Av",
		TabWidth = 100,
		Size = UDim2.fromOffset(450, 350),
		Acrylic = true,
		Theme = "Dark",
		MinimizeKey = Enum.KeyCode.LeftControl
	});
	local Tabs = {
		Main = guiWindow[randomKey]:AddTab({
			Title = "Main",
			Icon = "home"
		}),
		Auto = guiWindow[randomKey]:AddTab({
			Title = "Auto",
			Icon = "repeat"
		}),
		Teleports = guiWindow[randomKey]:AddTab({
			Title = "Teleports",
			Icon = "navigation"
		}),
		Misc = guiWindow[randomKey]:AddTab({
			Title = "Misc",
			Icon = "circle-ellipsis"
		}),
	};
	if isdeveloper then
		Tabs.Tools = guiWindow[randomKey]:AddTab({
			Title = "Tools",
			Icon = "wrench"
		});
		Tabs.Test = guiWindow[randomKey]:AddTab({
			Title = "Test",
			Icon = "code"
		});
	end
	Tabs.Settings = guiWindow[randomKey]:AddTab({
		Title = "Settings",
		Icon = "settings"
	})
	
	local Options = Fluent.Options;
	local version = "v_0.8.5";
	local devs = "Av & Hari";

	--[[
		Main Tab
	--]]
	informationParagraph = Tabs.Main:AddParagraph({
		Title = "Information\n",
		Content = "*Version" 
		.. "\n->\t" .. version
		.. "\n" .. "*Made By" 
		.. "\n->\t" .. devs
	});
	updateLogParagraph = Tabs.Main:AddParagraph({
		Title = "Update Log\n",
		Content = "*Added" 
		.. "\n->\t" .. "Auto Infinte (Read the ReadMe)"
		.. "\n->\t" .. "Script Uptime (in Stats)"
		.. "\n*Removed"
		.. "\n->\t" .. "Auto Roll (useless)"
		.. "\n*Changed"
		.. "\n->\t" .. "~"
	});
	notesParagraph = Tabs.Main:AddParagraph({
		Title = "Notes\n",
		Content = "*Coming Soon"
		.. "\n->\t" .. "Working on Auto Infinite"
		.. "\n->\t" .. "Working on Auto Repeatable Bosses"
		.. "\n->\t" .. "Working on Configs"
	});

	--[[
		Auto Tab
	--]]
	statsParagraph = Tabs.Auto:AddParagraph({
		Title = "Stats\n",
		Content = "Total Potions: " .. potionCount .. "\n" .. "Sword Timer: " .. swordCooldown .. "\n" .. tostring(tickCount)
	});
	self.autoInfiniteToggle = Tabs.Auto:AddToggle("AutoInfinite", {
		Title = "Auto Infinite (Experimental)",
		Description = "Scroll down for the ReadMe",
		Default = false
	});
	self.autoHideBattleToggle = Tabs.Auto:AddToggle("AutoHideBattle", {
		Title = "Auto Hide Battle",
		Default = false
	});
	self.autoPotionsToggle = Tabs.Auto:AddToggle("AutoPotions", {
		Title = "Auto Potions",
		Default = false
	});
	self.autoSwordToggle = Tabs.Auto:AddToggle("AutoSword", {
		Title = "Auto Sword",
		Default = false
	});
	disclaimerParagraph = Tabs.Auto:AddParagraph({
		Title = "Read Me\n",
		Content = "*Auto Infinite"
		.. "\n->\t" .. "teleports you once to the NPC"
		.. "\n->\t" .. "only triggers proximity prompt for now"
		.. "\n->\t" .. "need to be near the NPC"
		.. "\n->\t" .. "use macro to start battle"
	});
	self.autoPotionsToggle:OnChanged(function()
		autoPotionsActive = self.autoPotionsToggle.Value;
		if autoPotionsActive then
			task.spawn(self.autoPotionsLoop);
		end;
		self.updateParagraphStatus();
	end);
	self.autoSwordToggle:OnChanged(function()
		autoSwordActive = self.autoSwordToggle.Value;
		if autoSwordActive then
			task.spawn(self.autoSwordLoop);
		end;
		self.updateParagraphStatus();
	end);
	self.autoInfiniteToggle:OnChanged(function()
		if self.autoInfiniteToggle.Value then
			self.characterTeleport(npcTeleportsCoordinates["Heaven Infinite"]);
			task.wait(1);
			task.spawn(self.autoInfinite);
		end;
	end);
	self.autoHideBattleToggle:OnChanged(function()
		if self.autoHideBattleToggle.Value then
			task.spawn(self.autoHideBattle);
		end;
	end);

	--[[
		Teleports Tab
	--]]
	local npcTeleportDropdown = Tabs.Teleports:AddDropdown("Dropdown", {
		Title = "Npcs",
		Values = npcTeleports,
		Multi = false,
		Default = nil
	});
	local mobTeleportDropdown = Tabs.Teleports:AddDropdown("Dropdown", {
		Title = "Repeatable Bosses",
		Values = mobTeleports,
		Multi = false,
		Default = nil
	});
	local areaTeleportDropdown = Tabs.Teleports:AddDropdown("Dropdown", {
		Title = "Areas",
		Values = areaTeleports,
		Multi = false,
		Default = nil
	});
	npcTeleportDropdown:OnChanged(function(Value)
		local destination = npcTeleportsCoordinates[Value];
		if destination then
			self.characterTeleport(destination);
			npcTeleportDropdown:SetValue(nil);
		end;
	end);
	mobTeleportDropdown:OnChanged(function(Value)
		local destination = mobsTeleportsCoordinates[Value];
		if destination then
			self.characterTeleport(destination);
			mobTeleportDropdown:SetValue(nil);
		end;
	end);
	areaTeleportDropdown:OnChanged(function(Value)
		local destination = areaTeleportCoordinates[Value];
		if destination then
			self.characterTeleport(destination);
			areaTeleportDropdown:SetValue(nil);
		end;
	end);
	Tabs.Teleports:AddButton({
		Title = "God Spot",
		Callback = function()
			self.characterTeleport(otherCoordinates["Lucky Spot"]);
		end
	});

	--[[
		Misc Tab
	--]]
	Tabs.Misc:AddButton({
		Title = "Rejoin game",
		Callback = function()
			rejoinGame();
		end
	});
	Tabs.Misc:AddButton({
		Title = "Join Public Server",
		Callback = function()
			self.joinPublicServer();
		end
	});
	Tabs.Misc:AddButton({
		Title = "Claim All Codes",
		Callback = function()
			self.useCodes();
		end
	});
	Tabs.Misc:AddButton({
		Title = "Copy All Codes",
		Callback = function()
			setclipboard(self.reverseCodesCopy());
		end
	});
	codesParagraph = Tabs.Misc:AddParagraph({
		Title = "Codes\n",
		Content = "-->\tNot all codes are shown, use the button to copy all codes\n" 
		.. self.reverseCodes()
	});

	--[[
		Settings Tab
	--]]
	InterfaceManager:SetLibrary(Fluent);
	InterfaceManager:SetFolder("UK1");
	InterfaceManager:BuildInterfaceSection(Tabs.Settings);
	guiWindow[randomKey]:SelectTab(1);

	if isdeveloper then
		--[[
			Developer Tab
		--]]
		Tabs.Tools:AddButton({
			Title = "Remote Spy",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua")))();
			end
		});
		Tabs.Tools:AddButton({
			Title = "Dex",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")))();
			end
		});
		Tabs.Tools:AddButton({
			Title = "Infinite Yield",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")))();
			end
		});
		Tabs.Tools:AddButton({
			Title = "Join Public Server",
			Callback = function()
				task.spawn(self.joinPublicServer);
			end
		});
		Tabs.Tools:AddButton({
			Title = "Rejoin Game",
			Callback = function()
				rejoinGame();
			end
		});
		Tabs.Tools:AddButton({
			Title = "Get Position",
			Callback = function()
				task.spawn(self.getPosition);
			end
		});
		Tabs.Tools:AddButton({
			Title = "Teleport to Logged Position",
			Callback = function()
				task.spawn(self.teleportToLoggedPosition);
			end
		});
		Tabs.Tools:AddButton({
			Title = "Copy Player Id",
			Callback = function()
				setclipboard(tostring(playerid));
			end
		});
		Tabs.Tools:AddButton({
			Title = "Copy Place Id",
			Callback = function()
				setclipboard(tostring(placeid));
			end
		});
		Tabs.Tools:AddButton({
			Title = "Copy Job Id",
			Callback = function()
				setclipboard(tostring(jobid));
			end
		});
		Tabs.Tools:AddButton({
			Title = "Copy Creator Id",
			Callback = function()
				setclipboard(tostring(creatorid));
			end
		});
		local infodata = "User: " .. username .. " (" .. displayname .. ")" .. "\nPlayer Id: " .. playerid .. "\nAccount Age: " .. playerage .. "\nPlace Id: " .. placeid .. "\nJob Id: " .. jobid .. "\nCreator Id: " .. creatorid .. " (" .. tostring(creatortype) .. ")"
		Tabs.Tools:AddParagraph({
			Title = "Info",
			Content = infodata
		});
		local testdesc1 = "Fire signal on 'Yes please!' option";
		Tabs.Test:AddButton({
			Title = "Test Function 1",
			Description = "Current Function:\n" .. testdesc1,
			Callback = function()
				self.testFunction1();
			end
		});
		local testdesc2 = "Iterate through ResponseFrame children";
		Tabs.Test:AddButton({
			Title = "Test Function 2",
			Description = "Current Function:\n" .. testdesc2,
			Callback = function()
				self.testFunction2();
			end
		});
	end;
end;

if isdeveloper then
	function Hub:DevFunctions()
		--[[
			Developer Functions
		--]]
		self.teleportToPosition = function(x, y, z)
			if character and character.PrimaryPart then
				local pos = Vector3.new(x, y, z);
				character:SetPrimaryPartCFrame(CFrame.new(pos));
			else
				character = player.Character;
				self.setPrimaryPart();
			end;
		end;
		local loggedPositionX, loggedPositionY, loggedPositionZ;
		self.getPosition = function()
			if character and humanoidRootPart then
				local position = humanoidRootPart.Position;
				loggedPositionX, loggedPositionY, loggedPositionZ = position.X, position.Y, position.Z;
				local dataString = string.format("%.6f, %.6f,%.6f", position.X, position.Y, position.Z);
				setclipboard(dataString);
				return loggedPositionX, loggedPositionY, loggedPositionZ;
			else
				if not character then
					warn("Character not found for player:", player.Name);
				end;
				if not humanoidRootPart then
					warn("HumanoidRootPart not found for player:", player.Name);
				end;
				return nil, nil, nil;
			end;
		end;
		self.teleportToLoggedPosition = function()
			if loggedPositionX and loggedPositionY and loggedPositionZ then
				self.teleportToPosition(loggedPositionX, loggedPositionY, loggedPositionZ);
			else
				warn("Logged position is not set.");
			end;
		end;
		self.joinPublicServer = function()
			task.wait(1);
			local serversurl = api .. placeid .. "/servers/Public?sortOrder=Asc&limit=10";
			local function listServers(cursor)
				local raw = game:HttpGet(serversurl .. (cursor and "&cursor=" .. cursor or ""));
				return http:JSONDecode(raw);
			end;
			local servers = listServers();
			local server = servers.data[math.random(1, #servers.data)];
			teleportservice:TeleportToPlaceInstance(placeid, server.id, player);
		end;
		self.testFunction1 = function()
			local player = game:GetService("Players").LocalPlayer
			local npcDialogue = player.PlayerGui:FindFirstChild("NPCDialogue")
			if not npcDialogue then
				warn("NPCDialogue not found")
				return false
			end
			
			local dialogueFrame = npcDialogue:FindFirstChild("DialogueFrame")
			if not dialogueFrame then
				warn("DialogueFrame not found")
				return false
			end
			
			local responseFrame = dialogueFrame:FindFirstChild("ResponseFrame")
			if not responseFrame then
				warn("ResponseFrame not found")
				return false
			end
		
			while #responseFrame:GetChildren() < 3 do
				print("Waiting for at least 3 children in ResponseFrame...")
				responseFrame.ChildAdded:Wait()
			end

			local button = responseFrame:GetChildren()[2]
		
			if button:IsA("ImageButton") then
				print(tostring(button))
				print(button.Text.Text)
				print("Creating and firing signals")
		
				local signals = {
					"MouseButton1Click",
					"Activated",
					"MouseButton1Down",
					"MouseButton1Up",
					"InputBegan",
					"InputEnded",
					"TouchTap"
				}
		
				for _, signal in ipairs(signals) do
					local success, err = pcall(function()
						firesignal(button[signal])
						print("Fired signal: " .. signal)
					end)
					
					if not success then
						warn("Error during firesignal for " .. signal .. ": " .. tostring(err))
					end
				end
			else
				warn("Second child is not an ImageButton")
			end
		end
		self.testFunction2 = function()
			local player = game:GetService("Players").LocalPlayer
			local npcDialogue = player.PlayerGui.NPCDialogue
			
			if npcDialogue then
				local dialogueFrame = npcDialogue:WaitForChild("DialogueFrame")
				local responseFrame = dialogueFrame:WaitForChild("ResponseFrame")
				
				for _, child in pairs(responseFrame:GetChildren()) do
					print("Name: " .. child.Name .. ", Type: " .. child.ClassName)
					if child:IsA("TextLabel") or child:IsA("TextButton") then
						print("Text: " .. child.Text)
					elseif child:FindFirstChild("Text") then
						print("Text: " .. child.Text.Text)
					end
				end
			else
				print("NPCDialogue not found.")
			end
		end;
	end;
	Hub:DevFunctions();
end;

--[[
	Main
--]]
Hub:Functions();
Hub:Gui();
antiAfk();
tickCount = tick();