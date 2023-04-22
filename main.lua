
if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)
wakaba_krdesc = mod

-- did this just in case, doesn't include anything yet
wakaba_krdesc.FIENDFOLIO = include("wakaba_krdesc.fiendfolio")
wakaba_krdesc.RETRIBUTION = include("wakaba_krdesc.retribution")
wakaba_krdesc.REVEL = include("wakaba_krdesc.revelations")
wakaba_krdesc.GODMODE = include("wakaba_krdesc.godmode")
wakaba_krdesc.SAMAEL = include("wakaba_krdesc.samael")
wakaba_krdesc.DELIVERANCE = include("wakaba_krdesc.deliverance")

-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"

