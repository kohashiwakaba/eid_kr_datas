
if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)
wakaba_krdesc = mod

wakaba_krdesc.FIENDFOLIO = include("wakaba_krdesc.fiendfolio")
wakaba_krdesc.RETRIBUTION = include("wakaba_krdesc.retribution")
wakaba_krdesc.REVEL = include("wakaba_krdesc.revelations")
wakaba_krdesc.GODMODE = include("wakaba_krdesc.godmode")
wakaba_krdesc.SAMAEL = include("wakaba_krdesc.samael")
wakaba_krdesc.DELIVERANCE = include("wakaba_krdesc.deliverance")

--[[
  Each included objects returns as specific format
  {
    birthright = {insert birthright desc here},
    collectibles = {insert collectibles desc here},
    trinkets = {insert trinkets desc here},
    cards = {insert cards desc here},
    pills = {insert pills desc here},
  }

  each item descriptions in table consists of certain entries:
  [ItemID] = {
  		Name = Item Name. Character name for Birthright,
  		QuoteDesc = Item Descriptions when picked up,
  		Description = Item Descriptions for EID. Follows EID Format,
			Wisps = Synergies for Book of Virtues. Follows EID Format,
			Belial = Synergies for Book of Belial Birthright. Follows EID Format,
  }
]]

-- TODO : Library Expanded
--wakaba_krdesc.LIBRARY_EXPANDED = include("wakaba_krdesc.library_expanded")

-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"

