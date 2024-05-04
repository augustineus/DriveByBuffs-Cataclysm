DriveByBuffs = LibStub("AceAddon-3.0"):NewAddon("DriveByBuffs", "AceConsole-3.0", "AceEvent-3.0")

function DriveByBuffs:OnInitialize()
	self:Print("Thanks for using DriveByBuffs!")
end

function DriveByBuffs:OnEnable()
	self:Print("DriveByBuffs RP Started")
end

function DriveByBuffs:OnDisable()
	self:Print("DriveByBuffs RP Stopped")
end

local function locate(table, value)
	for i = 1, #table do
		if table[i] == value then 
		 return true 
		end
	end
end

local emotes = {"is amazed by ", "blushes at ", "bows before ", "cheers for ", "claps for ", "is happy with ", "hugs ", "blows a kiss at ", "salutes ", "thanks ", 
								"cuddles up to ", "highly praises ", "gives many commendations to ", "flirts with "}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

local validBuffs = {"Arcane Intellect", "Arcane Brilliance", "Focus Magic", "Power Word: Fortitude", "Mark of the Wild", "Blessing of Might", "Blessing of Kings", "Unending Breath",
										"Dark Intent", "Divine Hymn", "Power Infusion", "Thorns", "Innervate", "Tricks of the Trade", "Unholy Frenzy", "Misdirection",
										"Hand of Sacrifice", "Hand of Freedom", "Hand of Protection", "Divine Guardian", "Hand of Salvation"}

local function createBuffString(name, buff)
	e = randEmote()
	return e .. name .. " for their " .. buff .. "."
end

local playerGUID = UnitGUID("player")

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)

	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
	
	if locate(validBuffs, buff) then 
		if destGUID == playerGUID and sourceGUID ~= playerGUID and subevent == "SPELL_CAST_SUCCESS" then
			SendChatMessage(createBuffString(sourceName, buff), "EMOTE")
		end
	end
end)