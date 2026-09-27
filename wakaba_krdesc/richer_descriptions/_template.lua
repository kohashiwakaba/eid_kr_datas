if not TBOI_RETUNED then return end

local mod = TBOI_RETUNED

local CHAR = "-997.-1."
local ITEM = "5.100."
local TRINKET = "5.350."
local CARD = "5.300."
local PILL = "5.70."
local CURSE ="-998.-1."

EID._currentMod = "TBoI: Retuned"

---@type table<string, WakabaDescriptionEntry>
local entries = {
	--#region APPENDS
	--#region MISC
	--#endregion
	--#endregion

	--#region PLAYERS
	[CHAR .. mod.Characters.CADENCE] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
			{{Collectible]]..1..[[}} 고유 능력 :
		]],
		Birthright = [[

		]],
		BirthrightQuote = "",
	},
	[CHAR .. mod.Characters.CADENCE] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
			{{Collectible]]..1..[[}} 고유 능력 :
		]],
		Birthright = [[

		]],
		BirthrightQuote = "",
	},
	--#endregion

	--#region COLLECTIBLES
	[ITEM..mod.Items.RELOAD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[

		]],
	},
	--#endregion

	--#region TRINKETS
	[TRINKET..mod.Trinkets.HARMONY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[

		]],
	},
	--#endregion

	--#region CARDS
	[CARD..mod.Cards.DAGGER] = {
		_descType = "card",
		Name = "",
		QuoteDesc = "",
		Description = [[

		]],
	},
	--#endregion

	--#region ENTITIES
	["6."..mod.Slots.BOSS_SHRINE..".-1"] = {
		_descType = "entity",
		Name = "",
		Description = [[
		]],
	},
	--#endregion
}

for _, entry in pairs(entries) do
	entry.Mod = "TBoI: Retuned"
end

return entries