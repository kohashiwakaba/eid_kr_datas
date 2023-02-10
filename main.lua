

if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)
wakaba_krdesc = mod

include("wakaba_krdesc.fiendfolio")
include("wakaba_krdesc.retribution")
include("wakaba_krdesc.revelations")


EID._currentMod = "Wakaba_translation_reserved"

