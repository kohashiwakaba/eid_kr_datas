
if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)
wakaba_krdesc = mod

wakaba_krdesc.FIENDFOLIO = include("wakaba_krdesc.fiendfolio")
wakaba_krdesc.RETRIBUTION = include("wakaba_krdesc.retribution")
wakaba_krdesc.REVEL = include("wakaba_krdesc.revelations")
wakaba_krdesc.GODMODE = include("wakaba_krdesc.godmode")
wakaba_krdesc.SAMAEL = include("wakaba_krdesc.samael")

-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"

