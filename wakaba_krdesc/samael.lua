if SamaelMod then

EID._currentMod = "Samael"

local bargainingChipDesc = "거래의 영혼이 제시하는 3가지 품목 중 하나를 선택할 수 있습니다."
		.."#아이템, 픽업, 특수 이벤트(ex:{{Collectible105}}) 등이 제시되며 거래 가격도 다양하게 설정됩니다."
local ferrymanDesc = "#차원의 틈새에서는 각 포탈마다 영혼이 존재하며 영혼을 적으로부터 보호하면 여러 픽업 보상을 얻을 수 있습니다."
local BirthrightDesc = {
  [SamaelMod.lib.SamaelId] = {
    Name = "Samael",
    Description = "#↑ 이동속도 +0.29#비행 능력을 얻습니다.#Malakh Mot의 충전속도가 빨라지며 사거리가 25% 증가합니다.#Malakh Mot 발동 중 적을 추적하여 공격하는 꼬마 사신을 3마리 소환합니다.", 
    QuoteDesc = "",
  },
  [SamaelMod.lib.TaintedSamaelId] = {
    Name = "Tainted Samael",
    Description = "#적 처치 시 영혼이 모입니다.#Memento Mori로 공격 시 영혼을 소모하여 연옥의 유령을 소환합니다.", 
    QuoteDesc = "",
  },
}


local CollectibleDesc = {
	[SamaelMod.ITEMS.REAPER_BUM] = {
		Description = "일정 수의 적 처치마다 뼛조각, 불꽃, 카드, 룬, 혹은 뼈하트를 드랍합니다.",
		Name = "사신 거지",
		QuoteDesc = "게으른 사신",
	},
	[SamaelMod.ITEMS.PUNISHMENT_OF_THE_GRAVE] = {
		Description = "↑ 목숨 +1#사망 시 전 방에서 체력 4칸으로 부활하며;#악마 거래를 했을 경우: 천사 보스를 소환하며 처치 시 악마방 아이템 2개를 드랍합니다.#악마 거래를 하지 않았을 경우: 천사방 아이템 하나를 소환합니다.",
		Name = "무덤의 형벌",
		QuoteDesc = "죽음 이후의 심판",
	},
	
	[SamaelMod.ITEMS.DENIAL] = {
		Description = "↓ 행운 -1#Blind 저주에 걸리지 않으며 추가 스테이지의 가려진 아이템을 보여줍니다.#방 입장 시 그 방 한정으로 아이템, 픽업, 슬롯류를 바꿀 수 있는 Denial Dice를 소환합니다.",
		Name = "부정의 정령",
		QuoteDesc = "운명을 거부하다",
	},
	[SamaelMod.ITEMS.ANGER] = {
		Description = "↑ 아래 항목, 등 이외의 부정적 효과 발생 시 공격력 +0.5:#"
		.."#{{Blank}} - {{Quality0}}등급 아이템 등장"
		.."#{{Blank}} - 현재 소지 중인 아이템과 같거나 낮은 등급의 액티브 아이템 등장"
		.."#{{Blank}} - 슬롯/거지가 보상을 주지 않을 때"
		.."#{{Blank}} - 폭탄으로 비밀방 발견 실패",
		Name = "분노",
		QuoteDesc = "운명에 분노하다",
	},
	[SamaelMod.ITEMS.BARGAINING] = {
		Description = "스테이지의 시작방 및 특수방 입장 시 {{Card" .. Isaac.GetCardIdByName("Bargaining's Chip") .. "}}Bargaining's Chip을 소환합니다.#"..bargainingChipDesc,
		Name = "거래의 정령",
		QuoteDesc = "운명을 거래하다",
	},
	[SamaelMod.ITEMS.DEPRESSION] = {
		Description = "↑ 연사 +0.7#피격 시 캐릭터가 일정 시간동안 누우며 여러 방향으로 눈물을 발사합니다.#캐릭터가 눕고 있는 도중에는 피해를 받지 않습니다.",
		Name = "우울의 정령",
		QuoteDesc = "운명을 비탄하다",
	},
	[SamaelMod.ITEMS.ACCEPTANCE] = {
		Description = "↑ {{LuckSmall}}행운 +1"
		.."#{{CurseBlindSmall}} {{ColorOrange}}항상 Blind 저주에 걸립니다.{{CR}}"
		.."#해당 게임에서 최초 획득 시 {{TreasureRoom}}보물방 배열의 아이템 하나를 소환합니다."
		.."#아이템 등장 혹은 구매 시 50%의 확률로 아이템이 하나 더 소환됩니다."
		.."#!!! {{Collectible249}}/{{Collectible414}}/{{Collectible670}}/{{Collectible665}} 아이템이 제거됩니다.",
		Name = "긍정의 정령",
		QuoteDesc = "운명을 받아들이다",
	},
	[SamaelMod.ITEMS.THANATOPHOBIA] = {
		Description = "전체 체력이 6칸 이하인 상태에서 피격 시 주변의 적 및 탄환을 밀쳐내며 그 방에서 현재 체력에 반비례하여 공격력이 증가합니다."
		.."#!!! {{HolyMantleSmall}}Holy Mantle의 보호막으로 방어 시 공격력이 증가하지 않으나 넉백은 그대로 발동됩니다.",
		Name = "타나토포비아",
		QuoteDesc = "죽음에 공포를 뜨리라",
	},
	[SamaelMod.ITEMS.MALAKH_MOT] = {
		Description = "사용 시 일시적으로 무적이 되며 낫을 마구 휘두릅니다."
		.."#적에게 피해를 주면 충전됩니다.",
		Name = "말라크 모트",
		QuoteDesc = "죽음이 되다",
	},
	[SamaelMod.ITEMS.REMEMBRANCE_OF_THE_FORGOTTEN] = {
		Description = "방 입장 시 해골 더미가 등장합니다."
		.."#해골 더미를 집으면 캐릭터의 눈물 공격을 같이 발사하는 영혼이 달립니다."
		.."#영혼이 사라지면 해골 더미가 다시 등장합니다.",
		Name = "잊혀진 자의 전언",
		QuoteDesc = "잊지 마...",
	},
	[SamaelMod.ITEMS.MEMENTO_MORI] = {
		Description = "사용 시 최대 5개까지 연결 지점을 설치합니다."
		.."#2번 연속 사용 시 연결 지점의 역순으로 적에게 피해를 주는 낫 공격을 하며 낫 공격 중에는 무적입니다."
		.."#적에게 주는 피해량은 직전에 설치한 연결 지점 수에 비례합니다."
		Name = "메멘토 모리",
		QuoteDesc = "죽음의 기억",
	},
	[SamaelMod.ITEMS.THANATOPHILIA] = {
		Description = "적 처치 시 25%의 확률로 해골 계열의 아군 적을 소환합니다."
		.."#아군 적이 없을 경우 주기적으로 소환합니다.",
		Name = "타나토필리아",
		QuoteDesc = "죽은 자들의 친구",
	},
	[SamaelMod.ITEMS.REMEMBRANCE_OF_DEATH] = {
		Description = "공격 키를 누르는 동안 그 자리에 고정 위치의 사신이 소환됩니다."
		.."#사신이 소환된 상태에서 공격 키를 떼면 사신이 캐릭터를 향해 공격하며 사신 주변의 적에게 피해를 줍니다."
		.."#캐릭터는 사신의 공격에 피해를 받지 않으며 적에게 주는 피해량은 {{DamageSmall}}/{{TearsSmall}} 수치에 비례합니다.",
		Name = "죽음의 전언",
		QuoteDesc = "그대를 잊지 않으리라",
	},
	[SamaelMod.ITEMS.THANATOS] = {
		Description = "캐릭터를 따라다니며 적의 탄환을 막아주는 관을 3개 소환합니다."
		.."#각 관 당 적 탄환을 10회 막으면 부서지며 부서지는 동안 푸른 불꽃을 발사하며 작은 캐릭터를 하나 소환합니다."
		.."#방 입장 시, 혹은 일정 시간이 지나면 관이 재생성됩니다.",
		Name = "타나토스의 가면",
		QuoteDesc = "사신의 보호",
	},
}

local TrinketDesc = {
	[SamaelMod.ITEMS.SIGIL_OF_SAMAEL] = {
		Description = "적 처치 시 적 처치 시의 효과를 추가로 발동합니다."
		Name = "사마엘의 인장",
		QuoteDesc = "죽음을 부르는 자",
	},
	[SamaelMod.ITEMS.SIGIL_OF_LILITH] = {
		Description = "작은 아이작 패밀리어를 하나 소환합니다."
		.."#패밀리어가 죽지 않고 방 클리어 시 그 패밀리어가 성장합니다."
		.."#패밀리어가 죽으면 방 입장 시 새로운 패밀리어가 소환됩니다.",
		Name = "릴리스의 인장",
		QuoteDesc = "생명을 주는 자",
	},
	[SamaelMod.ITEMS.CHARON_CLUB_CARD] = {
		Description ="모든 스테이지에서 차원의 틈새로 이동하는 뱃시공이 등장합니다."
		.."#뱃시공의 가격을 절반만큼 할인합니다."
		..ferrymanDesc,
		Name = "카론 클럽 카드",
		QuoteDesc = "더 많은 뱃시공 + 입장 할인",
	},
}

local CardDesc = {
	[SamaelMod.ITEMS.XIII] = {
		Description = "사용 시 특수한 악마방으로 순간이동합니다."
		.."#특수한 악마방에서는 악마방/천사방/특수악마방 배열의 아이템이 등장하며 체력 거래가 아닌 소지 중인 아이템을 요구하며 하나를 선택 시 나머지는 사라집니다."
		.."#반드시 거래해야만 출구가 생깁니다.",
		Name = "XIII",
		QuoteDesc = "획득멘트",
	},
	[SamaelMod.ITEMS.SOUL_OF_SAMAEL] = {
		Description = "그 방에서 적 처치 시 영혼이 생깁니다."
		.."#영혼을 모을 때마다 확률적으로 픽업을 생성합니다.",
		Name = "사마엘의 영혼",
		QuoteDesc = "획득멘트",
	},
	[SamaelMod.ITEMS.XIII_REVERSED] = {
		Description = "!!! 클리어한 방에서만 사용 가능#피격 시까지 적이 무한정 소환됩니다."
		.."#피격 후 방 클리어 시 적에게 준 피해량에 비례한 보상을 소환합니다.",
		Name = "XIII?",
		QuoteDesc = "획득멘트",
	},
	[SamaelMod.ITEMS.FERRYMANS_OBOLS] = {
		Description = "사용 시 차원의 틈새로 이동하는 뱃시공을 소환합니다.#{{Blank}} (거래 불필요)"..ferrymanDesc,
		Name = "뱃시공의 오볼",
		QuoteDesc = "획득멘트",
	},
	[SamaelMod.ITEMS.BARGAINING_CHIP] = {
		Description = bargainingChipDesc,
		Name = "거래 칩",
		QuoteDesc = "획득멘트",
	},
	[SamaelMod.ITEMS.DENIAL_DICE] = {
		Description = "사용 시 가장 가까이에 있는 아이템 및 픽업 하나를 같은 종류의 항목으로 바꿉니다."
		.."#!!! 다른 방으로 갖고 갈 수 없습니다.",
		Name = "부정의 9면 주사위",
		QuoteDesc = "획득멘트",
	},
	--[[ [SamaelMod.ITEMS.SAMAELS_FEATHER] = {
		Description = "아이템설명",
		Name = "아이템이름",
		QuoteDesc = "획득멘트",
	}, ]]
}

local PillDesc = {
	[SamaelMod.ITEMS.THANATOSIS] = {
		Description = "사용 시 캐릭터가 사망, 피격 시 효과를 발동하며 그 방의 적을 혼란시킵니다.#사용 후 움직이거나 공격하기 전까진 어떠한 피해를 받지 않습니다.",
		Name = "죽음",
		QuoteDesc = "",
	},
}

local MementoMoriItemDesc = {}
local SamaelItemDesc = {}


MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_INNER_EYE] = {"+2 hits per slash"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_SPOON_BENDER] = {"Homing slashes"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MY_REFLECTION] = {"Return to starting point after slashes"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_NUMBER_ONE] = {"↑Pee up"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_HALO_OF_FLIES] = {"Sigils get an orbital fly"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_DR_FETUS] = {"Places bombs on sigils that detonate on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TECHNOLOGY] = {"Sigils are replaced by technology eyes that shoot lasers at enemies"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_CHOCOLATE_MILK] = {"↓DMG (First slash)", "↑↑DMG (Third slash onwards)"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_PARASITE] = {"Emit split tears while slashing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BRIMSTONE] = {"Replaces slashes with brimstone lasers"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_LUMP_OF_COAL] = {"Slash damage increased on enemies further from sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TOUGH_LOVE] = {"Slashes may knock teeth out of enemies"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TECHNOLOGY_2] = {"Sigils are connected by damaging lasers"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MUTANT_SPIDER] = {"+3 hits per slash"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BLACK_BEAN] = {"Sigils fart on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_SACRED_HEART] = {"Homing slashes"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_EPIC_FETUS] = {"Slashing attack replaced with carpet bombing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_LOST_CONTACT] = {"Sigils can block projectiles"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_ANTI_GRAVITY] = {"Activation no longer moves you along the sigils", "Slashes still occur independently of you"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_CRICKETS_BODY] = {"Sigils fire tears on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MONSTROS_LUNG] = {"Sigils spew tears on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TINY_PLANET] = {"Slashes orbit the origin point before traveling to the next sigil"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TECH_5] = {"Lasers will randomly fire between sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_20_20] = {"+1 hits per slash"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BLOOD_CLOT] = {"Alternating +1/+0 damage for each slash"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_FIRE_MIND] = {"Sigils have flames on them", "Slashes leave a trail of fire jets"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_DARK_MATTER] = {"Sigils may inflict fear on enemies"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_PROPTOSIS] = {"Slash damage increased on enemies close to sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_CURSED_EYE] = {"Slashes have a chance to teleport enemies"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MYSTERIOUS_LIQUID] = {"Sigils and slashes leave green creep"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE] = {"Sigils can be moved"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_GODHEAD] = {"Sigils have a damaging aura"}

MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_CONTINUUM] = {"Slashes go all the way across the screen"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_HOLY_LIGHT] = {"Leave a trail of holy light beams while slashing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MARKED] = {"Sigils are placed at the target instead of at your position"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TECH_X] = {"Sigils are surrounded by laser rings"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TRACTOR_BEAM] = {"Tears will periodically travel between sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BLACK_POWDER] = {"Creates a pentagram if you draw a pentagram shape with your sigils"}

MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_APPLE] = {"Places delicious apples onto sigils (may or may not contain razor blades)"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_COMPOUND_FRACTURE] = {"Sigils emit bones on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_EYE_OF_BELIAL] = {"Eye of Belial tears appear out of enemies hit by slashes"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_JACOBS_LADDER] = {"Emit electricity during slashes"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_GHOST_PEPPER] = {"Chance to emit flame from sigil on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BIRDS_EYE] = {"Chance to emit flame from sigil on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_LARGE_ZIT] = {"May shoot pus while slashing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_BACKSTABBER] = {"Slashes may inflict bleeding"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TECHNOLOGY_ZERO] = {"When you attack, electricity connects you and your sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_POP] = {"Samael would play pool"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_HAEMOLACRIA] = {"Sigils spew tears on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_LACHRYPHAGY] = {"No synergy implemented"} -- Sigils may bite or eat enemies?
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TRISAGION] = {"Trisagion lasers will periodically travel between sigils"}

MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_MUCORMYCOSIS] = {"Sigils emit spores on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE] = {"Random trail effects while slashing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_EYE_OF_THE_OCCULT] = {"(With {{Collectible118}} Brimstone): Slashes pass through your target"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_JUPITER] = {"Leave fart trails while slashing"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_TERRA] = {"Sigils trigger shockwaves on activation"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_OCULAR_RIFT] = {"Rifts will occasionally appear on sigils"}
MementoMoriItemDescriptions[CollectibleType.COLLECTIBLE_STRANGE_ATTRACTOR] = {"Sigils attract enemies and pickups"}


SamaelItemDescriptions[CollectibleType.COLLECTIBLE_20_20] = {"2개의 낫을 동시에 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_THE_WIZ] = {"2개의 낫을 동시에 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_INNER_EYE] = {"3개의 낫을 동시에 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_MUTANT_SPIDER] = {"4개의 낫을 동시에 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_TECHNOLOGY] = {"낫을 휘두를 때 레이저 고리를 두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_CHOCOLATE_MILK] = {"낫의 충전 단계에 비례하여 발사체의 공격력이 증가합니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_BRIMSTONE] = {"공격 시 적에게 피해를 주는 검기를 남깁니다.", "충전 공격 시 검기에서 혈사포가 나갑니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_TECHNOLOGY_2] = {"낫을 휘두를 때 레이저 고리를 두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_TECH_5] = {"낫을 휘두를 때 레이저 고리를 두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_MOMS_EYE] = {"확률적으로 낫을 뒤에서 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_LOKIS_HORNS] = {"확률적으로 낫을 4방향으로 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_TECH_X] = {"낫을 휘두를 때 레이저 고리를 두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_BACKSTABBER] = {"낫으로 적 명중 시 확률적으로 출혈을 겁니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_SULFURIC_ACID] = {"낫이 장애물을 부숩니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE] = {"충전 공격 시 낫을 조종할 수 있습니다.", "캐릭터와 낫과 접촉, 혹은 {{ButtonRT}} 버튼을 누르면 낫이 되돌아옵니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_MONSTROS_LUNG] = {"낫을 휘두를 때 여러 개의 눈물을 흩뿌립니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_SPIN_TO_WIN] = {"아이템 사용 중일 때 낫을 같이 휘두릅니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_TERRA] = {"낫이 장애물을 부숩니다.", "낫이 적 명중 시 짧은 지진파를 발산합니다."}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_BERSERK] = {"!!! 주의 : 낫으로 적 처치 시 지속시간이 연장되지 않음"}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_C_SECTION] = {"!!! 주의 : 태아가 정상적으로 공격하지 않음"}
SamaelItemDescriptions[CollectibleType.COLLECTIBLE_CURSED_EYE] = {"낫으로 적 명중 시 그 적을 방 안의 랜덤 위치로 순간이동 시킵니다."}



for playerType, birthrightdesc in pairs(BirthrightDesc) do
  EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
end
for itemID, itemdesc in pairs(CollectibleDesc) do
  local desc = itemdesc.Description
  if itemdesc.StatusEffects then
    for _, eff in ipairs(itemdesc.StatusEffects) do
      desc = desc .. eff
    end
  end
  EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
  if itemdesc.Wisps then
    EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
  end
  if itemdesc.Belial and itemdesc.Belial ~= "" then
    EID.descriptions["ko_kr"].bookOfBelialBuffs[itemID] = itemdesc.Belial
  end
end
for itemID, itemdesc in pairs(TrinketDesc) do
  local desc = itemdesc.Description
  if itemdesc.StatusEffects then
    for _, eff in ipairs(itemdesc.StatusEffects) do
      desc = desc .. eff
    end
  end
  EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
end
for itemID, itemdesc in pairs(CardDesc) do
  EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
end

end

