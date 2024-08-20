--[[
	Loaded Check
--]]
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
local waitplayer = game.Players.LocalPlayer;
local character = waitplayer.Character or waitplayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

--[[
	Roblox Services & Variables
--]]
local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local virtualinput = game:GetService("VirtualInputManager")
local virtualuser = game:GetService("VirtualUser")
local guiservice = game:GetService("GuiService")
local userinputservice = game:GetService("UserInputService")
local replicatedstorage = game:GetService("ReplicatedStorage")
local remotes = replicatedstorage:WaitForChild("Remotes")
local teleportservice = game:GetService("TeleportService")
local textchatservice = game:GetService("TextChatService")
local textchannel = textchatservice.TextChannels:WaitForChild("RBXGeneral")
local http = game:GetService("HttpService")
local proximitypromptservice = game:GetService("ProximityPromptService")

local player = players.LocalPlayer
local playerid = player.UserId
local character = player.Character
local username = player.Name
local displayname = player.DisplayName
local playerage = player.AccountAge

local placeid = game.PlaceId
local creatorid = game.CreatorId
local creatortype = game.CreatorType
local jobid = game.JobId
local api = "https://games.roblox.com/v1/games/"

local stats = player:WaitForChild("Stats")
local playergui = player:WaitForChild("PlayerGui")
local gamenpcs = workspace:WaitForChild("NPCs")

--[[
	Libraries
--]]
local Fluent = (loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")))();
local InterfaceManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua")))();
local SaveManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua")))();

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
	-- ["MintedAv"] = 164011583,
	["psuw"] = 417954849,
	["impeders"] = 35955366,
	["aqreement"] = 1607510152,
	["hari2789"] = 85087803,
};
local function isDeveloper(userid)
	for _, id in pairs(devid) do
		if id == userid then
			return true
		end
		task.wait(0.1);
	end
	return nil
end
local isdeveloper = isDeveloper(playerid);

--[[
	Library Variables
--]]
local statsParagraph, codesParagraph, updateLogParagraph, extraParagraph, informationParagraph;
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
	"15KLIKES!",
	"20KLIKES!",
	"UPDATE2!",
	"5MVISITS!",
	"SORRYFORALLTHESHUTDOWNS!",
};

--[[
	Teleport Tables
--]]
local otherLocations = {
	"Sword",
	"Old Position Sword",
	"Old Position"
};
local otherCoordinates = {
	["Sword"] = Vector3.new(-7714.85205078125, 211.64096069335938, -9588.51953125),
	["Old Position Sword"] = Vector3.new(0, 0, 0),
	["Old Position Chest"] = Vector3.new(0, 0, 0)
};
local npcTeleports = {
	"Heaven Infinite",
	"Heaven Tower",
	"Charm Merchant",
	"Potion Shop",
	"Card Fusion",
	"Daily Chest",
	"Card Index",
	"Strange Trader",
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
	"Bald Hero",
};
local bossTeleports = {
	"Cifer",
	"King Of Curses",
	"Shinobi God",
	"Galactic Tyrant",
	"Wicked Weaver",
	"Cosmic Menace"
}
local areaTeleports = {
	"Heavens Arena",
	"Roll Leaderboard",
	"Card Leaderboard",
	"Spawn",
};
local npcTeleportsCoordinates = {
	["Heaven Infinite"] = Vector3.new(454.615417, 260.529327,5928.994629),
	["Heaven Tower"] = Vector3.new(451.595367, 247.374268, 5980.721191),
	["Charm Merchant"] = Vector3.new(-7764.36572265625, 179.71200561523438, -9194.859375),
	["Potion Shop"] = Vector3.new(-7744.11376953125, 180.14158630371094, -9369.5908203125),
	["Card Fusion"] = Vector3.new(13131.391602, 84.905922, 11281.490234),
	["Card Index"] = Vector3.new(-7846.603515625, 180.50991821289062, -9371.1884765625),
	["Daily Chest"] = Vector3.new(-7785.53173828125, 180.8318634033203, -9339.9423828125),
	["Strange Trader"] = Vector3.new(523.097717, 247.374268, 6017.144531),
	["Card Packs"] = Vector3.new(-7708.05810546875, 180.46566772460938, -9310.736328125),
	["Luck Fountain"] = Vector3.new(-7811.5751953125, 180.41331481933594, -9278.078125)
};
local mobsTeleportsCoordinates = {
	["Earth's Mightiest"] = Vector3.new(10939.111328, 340.554169, -5141.633789),
	["Prince"] = Vector3.new(10987.201172, 344.049896, -5241.321777),
	["Knucklehead Ninja"] = Vector3.new(4219.748535, 31.724997, 7506.525391),
	["Rogue Ninja"] = Vector3.new(4306.954102, 31.724993, 7506.855469),
	["Limitless"] = Vector3.new(-12.537902, 272.422241, 5996.07666),
	["Substitute Reaper"] = Vector3.new(-7901.751465, 734.372009, 6714.296875),
	["Rubber Boy"] = Vector3.new(13150.526367, 84.124977, 11365.570312),
	["Bald Hero"] = Vector3.new(-11790.704102, 152.171967, -8566.525391),
};
local bossTeleportsCoordinates = {
	["Cosmic Menace (Boss)"] = Vector3.new(-11721.826172, 156.702225, -8551.984375),
	["Wicked Weaver (Boss)"] = Vector3.new(13107.546875, 84.274979, 11333.648438),
	["Cifer (Boss)"] = Vector3.new(-7899.03418, 734.354736, 6741.601562),
	["King Of Curses (Boss)"] = Vector3.new(-25.217384, 256.795135, 5882.467773),
	["Shinobi God (Boss)"] = Vector3.new(4258.674805, 31.874994, 7444.705078),
	["Galactic Tyrant (Boss)"] = Vector3.new(10927.65918, 352.19986, -5072.885254),
}
local areaTeleportCoordinates = {
	["Heavens Arena"] = Vector3.new(461.994751, 247.374268, 5954.683105),
	["Roll Leaderboard"] = Vector3.new(-7920.541015625, 186.38790893554688, -9144.70703125),
	["Card Leaderboard"] = Vector3.new(-7920.541015625, 186.38800048828125, -9170.8369140625),
	["Spawn"] = Vector3.new(-7921.300781, 177.836029,-9143.949219),
};

--[[
	Variables
--]]
local swordCooldown = stats:WaitForChild("SwordObbyCD").Value;
local potionCount = 0;
local autoPotionsActive = false;
local autoSwordActive = false;
local canGoBack = false;
local grabbedSword = false;
local tickCount, uptimeInSeconds, hours, minutes, seconds
local uptimeText = "00 hours\n00 minutes\n00 seconds";

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
	self.getOldPositionChest = function()
		if character and humanoidRootPart then
			local position = humanoidRootPart.Position;
			otherCoordinates["Old Position Chest"] = Vector3.new(position.X, (position.Y + 5), position.Z);
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
	self.claimSword = function()
		self.getOldPositionSword();
		local swordProximityPrompt = workspace.ObbySwordPrompt.SwordBlock.ProximityPrompt
		if swordProximityPrompt then
			self.characterTeleport(otherCoordinates["Sword"]);
			task.wait(0.25);
			fireproximityprompt(swordProximityPrompt);
			task.wait(0.5);
			canGoBack = true;
		end;
	end;
	self.claimDailyChest = function()
		self.getOldPositionChest();
		local dailyChestProximityPrompt = workspace.DailyChestPrompt.ProximityPrompt
		self.characterTeleport(npcTeleportsCoordinates["Daily Chest"]);
		task.wait(0.5);
		if dailyChestProximityPrompt then
			fireproximityprompt(dailyChestProximityPrompt);
			task.wait(0.5);
		end
		self.characterTeleport(otherCoordinates["Old Position Chest"]);
	end;
	self.autoInfinite = function()
		repeat
			task.wait(0.1)
		until grabbedSword == true
		self.characterTeleport(npcTeleportsCoordinates["Heaven Infinite"])
		
		while self.autoInfiniteToggle.Value do
			repeat 
				local inBattle = stats:WaitForChild("InBattle").Value
				task.wait(0.1)
			until inBattle == false

			local davidNPC, davidHRP, davidProximityPrompt, dialogueOption
			local npcDialogue, dialogueFrame, responseFrame
	
			repeat
				davidNPC = gamenpcs:WaitForChild("David")
				davidHRP = davidNPC:FindFirstChild("HumanoidRootPart")
				task.wait(0.1)
			until davidHRP and davidHRP:FindFirstChild("ProximityPrompt")
	
			repeat 
				davidProximityPrompt = davidHRP.ProximityPrompt
				fireproximityprompt(davidProximityPrompt)
				npcDialogue = playergui:WaitForChild("NPCDialogue")
			until npcDialogue

			repeat
				dialogueFrame = npcDialogue:WaitForChild("DialogueFrame")
				responseFrame = dialogueFrame:WaitForChild("ResponseFrame")
				dialogueOption = responseFrame:FindFirstChild("DialogueOption")
				guiservice.SelectedObject = dialogueOption
				task.wait(0.1)
			until guiservice.SelectedObject == dialogueOption
	
			virtualinput:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
			task.wait(0.1)
			virtualinput:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
			task.wait(0.5)
			guiservice.SelectedObject = nil
			task.wait(0.1)
		end
	end
	self.closeResultScreen = function()
		local davidNPC, davidHRP, inBattle
		local function getDavidHRP()
			davidNPC = gamenpcs:WaitForChild("David")
			return davidNPC:WaitForChild("HumanoidRootPart")
		end
		davidHRP = getDavidHRP()
		while self.closeResultScreenToggle.Value do
			inBattle = stats:WaitForChild("InBattle")
			repeat
				task.wait(0.25)
			until not inBattle.Value
			for _, instantroll in ipairs(playergui:GetChildren()) do
				if instantroll.Name == "InstantRoll" then
					instantroll:Destroy()
				end
			end
			task.wait(0.25)
			if not davidHRP then
				davidHRP = getDavidHRP()
			end
		end
	end	
	self.autoHideBattle = function()
		local hideBattle = stats:WaitForChild("HideBattle")
		if hideBattle then
			hideBattle.Value = self.autoHideBattleToggle.Value
		end
		task.wait(1)
	end;
	
	--[[
		Auto Loop Functions
	--]]
	self.autoPotionsLoop = function()
		while self.autoPotionsToggle.Value do
			self.grabPotions();
			task.wait(0.25);
		end;
	end;
	self.autoSwordLoop = function()
		while self.autoSwordToggle.Value do
			local swordObbyCD = swordCooldown;
			if swordObbyCD == 0 then
				grabbedSword = false;
				self.claimSword();
				grabbedSword = true;
				if canGoBack then
					self.characterTeleport(otherCoordinates["Old Position Sword"]);
					canGoBack = false;
				end;
			elseif swordObbyCD > 0 and grabbedSword == false then
				grabbedSword = true;
			end;
			task.wait(0.25);
		end;
	end;
	
	--[[
		Paragraph Functions
	--]]
	self.updateParagraph = function()
		while self.autoPotionsToggle.Value or self.autoSwordToggle.Value do
			swordCooldown = (stats:WaitForChild("SwordObbyCD")).Value;
			local totalPotions = potionCount;
			local timeLeft = swordCooldown;

			uptimeInSeconds = tick() - tickCount
			hours = math.floor(uptimeInSeconds / 3600)
			minutes = math.floor((uptimeInSeconds % 3600) / 60)
			seconds = uptimeInSeconds % 60
			uptimeText = string.format("%02d hours\n%02d minutes\n%02d seconds", hours, minutes, seconds)

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
		Size = UDim2.fromOffset(500, 350),
		Acrylic = true,
		Theme = "Dark",
		MinimizeKey = Enum.KeyCode.LeftControl
	});
	local Tabs = {
		Main = guiWindow[randomKey]:AddTab({
			Title = "Main",
			Icon = "home"
		}),
		Farm = guiWindow[randomKey]:AddTab({
			Title = "Farm",
			Icon = "repeat"
		}),
		Battle = guiWindow[randomKey]:AddTab({
			Title = "Battle",
			Icon = "sword"
		}),
		Teleports = guiWindow[randomKey]:AddTab({
			Title = "Teleports",
			Icon = "navigation"
		}),
		Codes = guiWindow[randomKey]:AddTab({
			Title = "Codes",
			Icon = "file-text"
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
	Tabs.Interface = guiWindow[randomKey]:AddTab({
		Title = "Interface",
		Icon = "paintbrush"
	})
	Tabs.Configs = guiWindow[randomKey]:AddTab({
		Title = "Configs",
		Icon = "save"
	})
	
	local Options = Fluent.Options;
	local version = "v_1.0.2";
	local devs = "Av & Hari";

	--[[
		Main Tab
	--]]
	updateLogParagraph = Tabs.Main:AddParagraph({
		Title = "Update Log\n",
		Content = "*Added"
		-- .. "\n->\t" .. "~"
		.. "\n->\t" .. "Auto Infinite fully working!!"
		.. "\n->\t" .. "Added Configs"
		-- .. "\n*Removed"
		-- .. "\n->\t" .. "~"
		-- .. "\n*Changed"
		-- .. "\n->\t" .. "~"
		-- .. "\n*Notes"
		-- .. "\n->\t" .. "~"
	});
	informationParagraph = Tabs.Main:AddParagraph({
		Title = "Information\n",
		Content = "*Version" 
		.. "\n->\t" .. version
		.. "\n" .. "*Made By" 
		.. "\n->\t" .. devs
	});
	extraParagraph = Tabs.Main:AddParagraph({
		Title = "Extra\n",
		Content = "*Upcoming"
		.. "\n->\t" .. "Working on Auto Repeatable Bosses"
	});

	--[[
		Auto Tab
	--]]
	statsParagraph = Tabs.Farm:AddParagraph({
		Title = "Stats\n",
		Content = "Total Potions: " .. potionCount 
		.. "\n" .. "Sword Timer: " .. swordCooldown 
		.. "\n" .. uptimeText
	});
	self.autoPotionsToggle = Tabs.Farm:AddToggle("AutoPotions", {
		Title = "Auto Potions",
		Default = false
	});
	self.autoSwordToggle = Tabs.Farm:AddToggle("AutoSword", {
		Title = "Auto Sword",
		Default = false
	});
	self.claimChestButton = Tabs.Farm:AddButton({
		Title = "Claim Daily Chest",
		Callback = function()
			task.spawn(self.claimDailyChest);
		end
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

	--[[
		Battle Tab
	--]]
	self.autoInfiniteToggle = Tabs.Battle:AddToggle("AutoInfinite", {
		Title = "Auto Infinite",
		Default = false
	});
	self.closeResultScreenToggle = Tabs.Battle:AddToggle("CloseResultScreen", {
		Title = "Auto Close Result",
		Default = false
	});
	self.autoHideBattleToggle = Tabs.Battle:AddToggle("AutoHideBattle", {
		Title = "Auto Hide Battle",
		Description = "Toggles Hide Battle",
		Default = false
	});
	self.autoInfiniteToggle:OnChanged(function()
		if self.autoInfiniteToggle.Value then
			task.spawn(self.autoInfinite);
		end;
	end);
	self.closeResultScreenToggle:OnChanged(function()
		if self.closeResultScreenToggle.Value then
			task.spawn(self.closeResultScreen);
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
	local bossTeleportsDropdown = Tabs.Teleports:AddDropdown("Dropdown", {
		Title = "Bosses",
		Values = bossTeleports,
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
	bossTeleportsDropdown:OnChanged(function(Value)
		local destination = bossTeleportsCoordinates[Value];
		if destination then
			self.characterTeleport(destination);
			bossTeleportsDropdown:SetValue(nil);
		end;
	end);
	areaTeleportDropdown:OnChanged(function(Value)
		local destination = areaTeleportCoordinates[Value];
		if destination then
			self.characterTeleport(destination);
			areaTeleportDropdown:SetValue(nil);
		end;
	end);

	--[[
		Codes Tab
	--]]
	self.claimCodesButton = Tabs.Codes:AddButton({
		Title = "Claim All Codes",
		Callback = function()
			self.useCodes();
		end
	});
	self.copyCodesButton = Tabs.Codes:AddButton({
		Title = "Copy All Codes",
		Callback = function()
			setclipboard(self.reverseCodesCopy());
		end
	});
	codesParagraph = Tabs.Codes:AddParagraph({
		Title = "Codes\n",
		Content = "*Disclaimer" 
		.. "\n->\t" .. "Not all codes are shown, use the copy button" 
		.. "\n->\t" .. "Top code is the newest"
		.. "\n" .. self.reverseCodes()
	});

	--[[
		Misc Tab
	--]]
	self.miscRejoinGameButton = Tabs.Misc:AddButton({
		Title = "Rejoin game",
		Callback = function()
			rejoinGame();
		end
	});
	self.miscJoinRandomServerButton = Tabs.Misc:AddButton({
		Title = "Join Random Public Server",
		Callback = function()
			self.joinPublicServer();
		end
	});

	--[[
		Interface Tab
	--]]
	InterfaceManager:SetLibrary(Fluent);
	InterfaceManager:SetFolder("UK1");
	InterfaceManager:BuildInterfaceSection(Tabs.Interface);

	--[[
		Configs Tab
	--]]
	SaveManager:SetLibrary(Fluent);
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetFolder("UK1/acb");
	SaveManager:BuildConfigSection(Tabs.Configs);
	
	guiWindow[randomKey]:SelectTab(1);

	if isdeveloper then
		--[[
			Developer Tab
		--]]
		self.toolsRemoteSpyButton = Tabs.Tools:AddButton({
			Title = "Remote Spy",
			Callback = function()
				local remoteSpyLink = "https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua";
				(loadstring(game:HttpGet(remoteSpyLink)))();
			end
		});
		self.toolsDexButton = Tabs.Tools:AddButton({
			Title = "Dex",
			Callback = function()
				local dexLink = "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua";
				(loadstring(game:HttpGet(dexLink)))();
			end
		});
		self.toolsInfiniteYieldButton = Tabs.Tools:AddButton({
			Title = "Infinite Yield",
			Callback = function()
				local infiniteYieldLink = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source";
				(loadstring(game:HttpGet(infiniteYieldLink)))();
			end
		});
		self.toolsJoinPublicServerButton = Tabs.Tools:AddButton({
			Title = "Join Public Server",
			Callback = function()
				task.spawn(self.joinPublicServer);
			end
		});
		self.toolsRejoinGameButton = Tabs.Tools:AddButton({
			Title = "Rejoin Game",
			Callback = function()
				rejoinGame();
			end
		});
		self.toolsGetPositionButton = Tabs.Tools:AddButton({
			Title = "Get Position",
			Callback = function()
				task.spawn(self.getPosition);
			end
		});
		self.toolsTeleportToPositionButton = Tabs.Tools:AddButton({
			Title = "Teleport to Logged Position",
			Callback = function()
				task.spawn(self.teleportToLoggedPosition);
			end
		});
		self.toolsCopyPlayerIdButton = Tabs.Tools:AddButton({
			Title = "Copy Player Id",
			Callback = function()
				setclipboard(tostring(playerid));
			end
		});
		self.toolsCopyPlaceIdButton = Tabs.Tools:AddButton({
			Title = "Copy Place Id",
			Callback = function()
				setclipboard(tostring(placeid));
			end
		});
		self.toolsCopyJobIdButton = Tabs.Tools:AddButton({
			Title = "Copy Job Id",
			Callback = function()
				setclipboard(tostring(jobid));
			end
		});
		self.toolsCopyCreatorIdButton = Tabs.Tools:AddButton({
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
		self.toolsTestFunctionButton1 = Tabs.Test:AddButton({
			Title = "Test Function 1",
			Description = "Current Function:\n" .. testdesc1,
			Callback = function()
				self.testFunction1();
			end
		});
		local testdesc2 = "Iterate through ResponseFrame children";
		self.toolsTestFunctionButton2 = Tabs.Test:AddButton({
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
			local instantroll = playergui:WaitForChild("InstantRoll")
			local inBattle = stats:WaitForChild("InBattle").Value
			if not inBattle and instantroll then
				instantroll:Destroy()
			end
		end
		self.testFunction2 = function()
			local npcDialogue = playergui.NPCDialogue
			
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
SaveManager:LoadAutoloadConfig()
