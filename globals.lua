FiendFolio = {}
Sheriff = {}
SheriffRepentogon = {}
EID = {}
InventoryDescriptions = {}
InvDescEIDType = {}
InvDescEIDVariant = {}

--#region Luadoc definitions

---@alias EID_PillClass "3-"|"2-"|"1-"|"0"|"1+"|"2+"|"3+"

---@alias EID_TypeVariantAlias
---| "collectible" @ "5.100"
---| "collectibles" @ "5.100"
---| "trinket" @ "5.350"
---| "trinkets" @ "5.350"
---| "card" @ "5.300"
---| "cards" @ "5.300"
---| "pill" @ "5.70"
---| "pills" @ "5.70"
---| "horsepills" @ "5.70"
---| "horsepill" @ "5.70"
---| "dice" @ "1000.76"
---| "entity" @ Indicates that a full entity identifier is used

---@alias EID_Dimension
---| 0 @Normal dimension
---| 1 @Secondary dimension, used by Downpour mirror dimension and Mines escape sequence
---| 2 @Death Certificate dimension

---@class EID_GoldenTrinketData
---@field t number[]? @The numbers inside the text that should be multiplied
---@field mult number? @Max multiplier applied. assumed to be 3.
---@field mults number[]? @Custom multipliers. A Missing Page's damage goes from 80 to 120 to 160; so its multipliers are 1.5 and 2, instead of 2 and 3
---@field append boolean? @If true, text is added to the description
---@field findReplace boolean? @If true, the text is replaced
---@field fullReplace boolean? @If true, description is fully replaced
---@field goldenOnly boolean? @If true, the description is modified only when the trinket is golden
---@field additions number? @Add a value to the number in the text, similar to multiplier. Expects a table of 3 values, 1: double, 2: triple, 3: quadruple effect

---@class EID_Icon
---@field [1] string @Animation name
---@field [2] integer @Animation frame
---@field [3] integer @Width
---@field [4] integer @Height
---@field [5] integer? @Left offset
---@field [6] integer? @Top offset
---@field [7] Sprite @Sprite object

---@class EID_DescObj
---@field ObjType integer
---@field ObjVariant integer
---@field ObjSubType integer
---@field fullItemString string @String in `Type.Variant.SubType` format
---@field Name string
---@field Description string
---@field Transformation string
---@field ModName string
---@field Quality integer
---@field Icon EID_Icon
---@field Entity Entity?
---@field ShowWhenUnidentified boolean?
---@field IgnoreBulletPointIconConfig boolean?
---@field ItemType integer?
---@field ChargeType integer?
---@field Charges integer? @Max charges

---@alias EID_Anchor "TOP"|"BOTTOM"|"LEFT"|"RIGHT"

---@class EID_HudElement
---@field x number
---@field y number
---@field width number
---@field height number
---@field anchors EID_Anchor[]
---@field descriptionObj fun(): EID_DescObj

--#endregion