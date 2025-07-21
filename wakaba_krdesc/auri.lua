
if Auriz then

	EID._currentMod = "Little Auri"

	local V_REPLACE = 0
	local V_APPEND = 1

	local PLAYER_AURI = Isaac.GetPlayerTypeByName("Auri")
	local PLAYER_AURIB = Isaac.GetPlayerTypeByName("Aurii", true)
	local PLAYER_DARK_AURI = Isaac.GetPlayerTypeByName("Dark Auri")
	local PLAYER_MAGE_AURI = Isaac.GetPlayerTypeByName("Mage Auri")
	local PLAYER_NAAMAH = Isaac.GetPlayerTypeByName("Naamah")
	local PLAYER_MILCAH = Isaac.GetPlayerTypeByName("Milcah")
	local PLAYER_QUEEN_AURI = Isaac.GetPlayerTypeByName("Queen Auri", true)

	--local Items = TrinketType
	local Trinkets = TrinketType

	local CharacterDesc = {
		[PLAYER_AURI] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
		[PLAYER_DARK_AURI] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
		[PLAYER_MAGE_AURI] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
		[PLAYER_NAAMAH] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
		[PLAYER_MILCAH] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
		[PLAYER_QUEEN_AURI] = {
			Name = "Auri",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "",
		},
	}

	local CollectibleDesc = {
		[COLLECTIBLE_BROKEN_GLOWING_HOURGLASS] = {
			Name = "부서진 모래시계",
			Description = ""
			.."#사용 시 11%의 확률로 모든 상태를 이전 방의 시점으로 시간을 되돌립니다."
			.."",
			QuoteDesc = "이거 아직도 작동하나?",
		},
		[COLLECTIBLE_DARK_GLOWING_HOURGLASS] = {
			Name = "어둠의 모래시계",
			-- Dark Item
			Description = ""
			.."#!!! {{ColorPurple}}소지 중 피격 시:"
			.."#>>> {{BrokenHeart}} {{ColorPurple}}부서진하트 +1"
			.."#>>> {{Collectible422}} {{ColorPurple}}모든 상태를 이전 방의 시점으로 시간을 되돌립니다."
			.."#{{ColorPurple}}사용 시 그 방에서 위의 효과를 방어합니다."
			.."",
			QuoteDesc = "아직도 조종할 수 있어",
		},
		[COLLECTIBLE_CORRUPTED_DATA] = {
			Name = "깨진 데이터",
			Description = ""
			.."#{{Collectible721}} 사용 시 오류 아이템을 소환합니다."
			.."",
			QuoteDesc = "게임이 깨지지 않기를 바래",
		},
		[COLLECTIBLE_THE_MEMORY] = {
			Name = "추억",
			Description = ""
			.."#↑ {{SoulHeart}}소울하트 +5"
			.."#↑ {{SpeedSmall}}이동속도 +0.4"
			.."#↑ {{TearsSmall}}연사 +1"
			.."#↑ {{DamageSmall}}공격력 +0.9"
			.."#↑ {{LuckSmall}}행운 +3"
			.."#{{Collectible658}} 10초마다 꼬마 아이작 패밀리어를 소환합니다."
			.."",
			QuoteDesc = "잊지 않을게...",
		},
		[COLLECTIBLE_ENCHANTED_BOOK] = {
			Name = "인챈트 책",
			Description = ""
			.."#{{Timer}} 사용 시 그 스테이지에서:"
			.."#>>> {{LuckSmall}}행운 +2"
			.."",
			QuoteDesc = "일시적 행운 증가",
		},
		[COLLECTIBLE_BLOODY_HOURGLASS] = {
			Name = "피의 모래시계",
			Description = ""
			.."#!!! 사용 시 빨간하트 1칸을 소모하여 그 방에서;"
			.."#>>> {{SpeedSmall}} 이동속도 +0.05"
			.."#>>> {{TearsSmall}} 연사 +0.9"
			.."#>>> !!! {{ColorOrange}}방의 속도가 빨라집니다."
			.."#{{Heart}} 사용 후 방 클리어 시 소모된 빨간하트의 50% 회복"
			.."",
			QuoteDesc = "가속",
		},
		[COLLECTIBLE_PRINCESS_BOX] = {
			Name = "프린세스 박스",
			Description = ""
			--.."#SINGLE USE {{Warning}}{{Warning}}{{Warning}} #80% chance to spawn Bloody Crown, Wicked Crown, Holy Crown #30% chance to spawn Cracked Crown#25% chance to spawn Devil's Crown#15% chance to spawn Pageant Boy#9% chance to spawn Auri's Crown, Dark Crown, Challenge Crown#5% chance to spawn Crown of Light, Dark Prince's Crown#3% chance to spawn Crown of Death#1% chance to spawn Glitched Crown"
			.."#!!! 일회용"
			.."#사용 시 각각 확률적으로 소환:"
			.."#>>> [80%] {{Trinket111}} {{Trinket161}} {{Trinket155}}"
			.."#>>> [30%] {{Trinket92}}"
			.."#>>> [25%] {{Trinket146}}"
			.."#>>> [15%] {{Collectible141}}"
			.."#>>> [9%] {{Trinket"..TrinketType.TRINKET_AURI_CROWN.."}} {{Trinket"..TrinketType.TRINKET_DARK_AURI_CROWN.."}} {{Trinket"..TrinketType.TRINKET_CHALLENGE_CROWN.."}}"
			.."#>>> [5%] {{Collectible415}} {{Collectible442}}"
			.."#>>> [3%] {{Trinket"..TrinketType.TRINKET_CROWN_OF_DEATH.."}}"
			.."#>>> [1%] {{Collectible689}}"
			.."",
			QuoteDesc = "왕관으로 가득 차있어!",
		},
		[COLLECTIBLE_MAGE_HAT] = {
			Name = "마법사 모자",
			Description = ""
			.."#↑ {{SoulHeart}}소울하트 +1"
			.."#↑ {{LuckSmall}}행운 +5"
			.."",
			QuoteDesc = "이거 쓰면 귀여워!",
		},
		[COLLECTIBLE_MAGE_ROBE] = {
			Name = "마법사 로브",
			Description = ""
			.."#↑ {{SoulHeart}}소울하트 +1"
			.."#↑ {{LuckSmall}}행운 +1"
			.."#{{DamageSmall}} 행운 2당 공격력 +1"
			.."",
			QuoteDesc = "행운이 힘을 주기를",
		},
		[COLLECTIBLE_WAIT_A_SEC] = {
			Name = "잠깐만!?",
			Description = ""
			.."#사용 시 아군 Dip을 하나 소환합니다."
			.."#소지 중인 똥 아이템에 따라 소환됩니다."
			.."",
			QuoteDesc = "똥이 아냐!",
		},
		[COLLECTIBLE_FIRE_SPELLBOOK] = {
			Name = "불의 마법서",
			Description = ""
			.."#{{Timer}} 사용 시 1초간:"
			.."#공격방향으로 공격력 x4의 불꽃을 여러 발 발사합니다."
			.."",
			QuoteDesc = "불마법 영창",
		},
		[COLLECTIBLE_CALM_MIND] = {
			Name = "차분한 마음",
			Description = ""
			.."#!!! 적이 있는 방에서:"
			.."#>>> {{DamageSmall}} 초당 공격력 +0.0045"
			.."#!!! 피격 시 30초간 발동 안함"
			.."",
			QuoteDesc = "진정하고 서서히 힘을 끌어와",
		},
		[COLLECTIBLE_OLD_ROPE] = {
			Name = "낡은 밧줄",
			Description = ""
			.."#!!! 사용 시 이하 중 하나 발동:"
			.."#>>> {{NoLB}}{{Card13}} 그 방에서 비행"
			.."#>>> {{NoLB}}{{Card68}} 30초간 3방향 공격 + 처치 시 {{Coin}}"
			.."#>>> {{NoLB}}{{Collectible186}} {{Heart}}1 소모 후 그 방의 적에 40 피해"
			.."",
			QuoteDesc = "이건 대체 뭘 위한 거야?",
		},
		[COLLECTIBLE_DYING] = {
			Name = "빈사",
			Description = ""
			--.."#When at only half a heart left:#\1 damage *1.5#↑ damage +3#\1 fire delay / 1.5#{{ColorRainbow}}\1 (2.5 as Milcah)#and shoot random tears effects"
			.."#!!! 전체 체력이 반칸일 때:"
			.."#>>> {{DamageSmall}} 공격력 배율 x1.5"
			.."#>>> {{TearsSmall}} 공격 딜레이 /1.5 (연사+)"
			.."#>>> 랜덤 효과 공격"
			.."",
			QuoteDesc = "올인",
		},
 		[COLLECTIBLE_GOLDEN_HOURGLASS] = {
			Name = "황금 모래시계",
			Description = ""
			--.."#Rewind time. #if the next room had collectibles and pickups, it will reroll them.#If the room had enemies, it will downgrade them#{{ColorRed}}has 50% chance to break after 3 use on current floor #{{ColorGreen}}reset on new floor if not break"
			.."#"
			.."#{{Collectible422}} 사용 시 모든 상태를 이전 방의 시점으로 시간을 되돌립니다."
			.."#!!! 되돌린 방 재입장 시:"
			.."#>>> {{Collectible105}} 그 방의 아이템을 바꾸며;"
			.."#>>> {{Collectible285}} 그 방의 적을 약화형 몬스터로 바꿉니다."
			.."#!!! {{Collectible"..COLLECTIBLE_BROKEN_GLOWING_HOURGLASS.."}} 3회 이상 사용 시 50%의 확률로 모래시계가 깨집니다."
			.."#>>> 깨지지 않은 경우 스테이지 진입 시 사용 회수 초기화"
			.."",
			QuoteDesc = "운명 바꾸기",
		},--Its just D10 and that's its effect now
		[COLLECTIBLE_SEDUCE] = {
			Name = "유혹",
			Description = ""
			--.."#Charm all enemies in the room#has a chance to permanently charm enemies#permanently charmed enemies follow character between rooms#{{ColorRainbow}}+5% chance for Naamah to shoot heart tears"
			.."#{{Charm}} 사용 시 그 방의 적을 매혹시키며;"
			.."#>>> 추가로 11%의 확률로 아군으로 만듭니다."
			.."",
			QuoteDesc = "내 사랑을 받으면 다쳐",
		},
		[COLLECTIBLE_RANDOMNESS] = {
			Name = "랜덤",
			Description = ""
			.."#{{Collectible488}} 클리어하지 않은 방 입장 시 랜덤 아이템을 발동합니다."
			.."",
			QuoteDesc = "저주걸린 줄 알았어!",
		},
		[COLLECTIBLE_WITCHS_BROOM] = {
			Name = "마녀의 빗자루",
			Description = ""
			--.."#Grants flight while held#↑ +3 luck up#↑ +0.1 speed#+1 Soul Heart#Using the item dashes in the direction of charcter's movement"
			.."#↑ {{SoulHeart}}소울하트 +1"
			.."#!!! 소지 시:"
			.."#↑ {{SpeedSmall}}이동속도 +0.1"
			.."#↑ {{LuckSmall}}행운 +3"
			.."#비행 능력을 얻습니다."
			.."#{{Collectible593}} 사용 시 바라보는 방향으로 돌진하여 접촉한 적에게 공격력 x4 +8의 피해를 줍니다."
			.."",
			QuoteDesc = "비행 + 행운 증가",
		},
		[COLLECTIBLE_WITCH_CAULDRON] = {
			Name = "마녀의 항아리",
			Description = ""
			--.."#Picking up trinkets will auto smelt them#After smelting 10 trinkets, spawns random item and removes this item#{{ColorRed}}has 25% chance to destroy the trinket#{{ColorGreen}}having more luck reduces the chance to destroy the trinket"
			.."#{{Collectible479}} !!! 장신구 획득 시:"
			.."#>>> 75%의 확률로 흡수하거나;"
			.."#>>> {{ColorRed}}실패 시 파괴됩니다."
			.."#{{LuckSmall}} 행운 25+일 때 100%"
			.."#!!! 10회 시도 이후 랜덤 아이템을 소환하며 아이템이 제거됩니다."
			.."",
			QuoteDesc = "마녀의 연금술",
		},
		[COLLECTIBLE_DARK_PRINCESS_CROWN] = {
			Name = "암흑 공주의 왕관",
			Description = ""
			--.."#+1.5 Range Up#+2.0 Tears Up#+0.20 Shot Speed Up"
			.."#↑ {{TearsSmall}}연사 +2"
			.."#↑ {{RangeSmall}}사거리 +1.5"
			.."#↑ {{ShotspeedSmall}}탄속 +0.2"
			.."",
			QuoteDesc = "희생이 곧 힘이다",
		},
		[COLLECTIBLE_LITTLE_AURI] = {
			Name = "리틀 아리",
			Description = ""
			.."#공격방향으로 공격력 5.4의 눈물을 발사합니다."
			.."#{{Charm}} 확률적으로 매혹 눈물을 발사합니다."
			.."",
			QuoteDesc = "내가 곁에 있을게!",
		},
		[COLLECTIBLE_PRINCESS_BABY] = {
			Name = "공주 아기",
			Description = ""
			.."#공격방향으로 공격력 3의 눈물을 발사합니다."
			.."#{{Fear}} 확률적으로 공포 눈물을 발사합니다."
			.."",
			QuoteDesc = "왕을 보좌하기",
		},
		[COLLECTIBLE_ENERGY_SHIELD] = {
			Name = "에너지 보호막",
			Description = ""
			--.."#Damage is negated when it fully charge#Do damage to near enemy when it negate damage or when character using it"
			.."#사용 시 캐릭터가 1.67초간 무적이 되며;"
			.."#>>> 캐릭터 근처의 적에게 공격력 x1.5의 짧은 전류를 방출합니다."
			.."#완충 상태에서 피격 시 자동 발동"
			.."",
			QuoteDesc = "쉴드 에너지",
		},
		[COLLECTIBLE_MAGE_STAFF] = {
			Name = "마법사 스태프",
			Description = ""
			--.."#{{Luck}} {{ColorGreen}}x 2 Luck Multiplier #Remove negative luck#{{ArrowUp}} +0.2 Tears Up#{{ArrowUp}} +0.5 Damage Up#{{ArrowUp}} +1.25 Range Up#{{ArrowDown}} -0.2 Shot Speed Down"
			.."#"
			.."#↑ {{TearsSmall}}연사 +0.2"
			.."#↑ {{DamageSmall}}공격력 +0.5"
			.."#↑ {{RangeSmall}}사거리 +1.25"
			.."#↓ {{ShotspeedSmall}}탄속 -0.2"
			.."#↑ {{LuckSmall}}행운 배율 x2"
			.."#{{LuckSmall}} 행운이 0 이상으로 고정됩니다."
			.."",
			QuoteDesc = "행운 증폭",
		},
		[COLLECTIBLE_CANDY] = {
			Name = "캔디",
			Description = ""
			--.."#+1 Eternal heart#gulp current trinket if you have one"
			.."#↑ {{EternalHeart}}이터널하트 +1"
			.."#획득 시 소지 중인 장신구를 흡수합니다."
			.."",
			QuoteDesc = "너무 많이 먹으면 안돼!",
		},
		[COLLECTIBLE_SELF_HARM] = {
			Name = "자해",
			Description = ""
			--.."#Deal damage to yourself without taking any health #not give character invincibility frame"
			.."#사용 시 피해를 입지 않고 피격 시 발동 효과를 발동합니다."
			.."#!!! 무적시간이 발생하지 않음"
			.."",
			QuoteDesc = "...",
		},
		[COLLECTIBLE_LIL_NAAMAH] = {
			Name = "리틀 나아마",
			Description = ""
			--.."#Spawns a familiar that shoots heart tears and charms enemies#has a very low tear rate"
			.."#{{Charm}} 공격방향으로 공격력 3.5의 매혹 눈물을 발사합니다."
			.."",
			QuoteDesc = "꼬마 서큐버스",
		},
		[COLLECTIBLE_LITTLE_PYROMANCER] = {
			Name = "리틀 파이로맨서",
			Description = ""
			--.."#Spawns a familiar that shoots flames#flames have a chance to explode and apply burn to enemies"
			.."#{{Burning}} 공격방향으로 공격력 3.5의 불꽃을 발사합니다."
			.."#{{Collectible257}} !!! 10%의 확률로 불꽃이 폭발합니다."
			.."",
			QuoteDesc = "꼬마 견습 마법사",
		},
		[COLLECTIBLE_PUNCHING_BABY] = {
			Name = "주먹 아기",
			Description = ""
			--.."#Spawns a familiar that shoots fist tears and knockback enemies#Tears deal 0 damage but enemies that are knocked back into wall or other enemies will take 10 damage"
			.."#{{Collectible637}} 공격방향으로 공격력 0의 펀치를 발사합니다."
			.."#밀쳐낸 적이 벽 및 장애물에 부딪히면 추가 피해를 받습니다."
			.."",
			QuoteDesc = "주먹이 나가는 친구",
		},
		[COLLECTIBLE_POCKET_BAG] = {
			Name = "주머니 가방",
			Description = ""
			--.."#Set characters starting active item to the pocket slot if character is still holding it#gulp characters starting trinket if character still holding it#Drops 2 random pickup"
			.."#랜덤 픽업을 2개 드랍합니다."
			.."#가능한 경우 캐릭터의 시작 액티브를 카드/알약 슬롯으로 옮깁니다."
			.."#캐릭터의 시작 장신구를 흡수합니다."
			.."",
			QuoteDesc = "소지품 챙기기",
		},
		[COLLECTIBLE_WITCHS_SOUP] = {
			Name = "마녀의 수프",
			Description = ""
			--.."#↑ {{Luck}} +30 Luck#The luck up wears off over time#Distort the screen upon pickup#The distortion effect disappears after clearing 5-6 rooms (5-6 waves in greed mode)"
			.."#"
			.."#↑ {{LuckSmall}}행운 +30"
			.."#증가한 행운은 1초마다 -0.xx씩 감소합니다."
			.."#!!! {{Collectible582}} 획득 시 Wavy Cap을 7회 발동합니다."
			.."#>>> {{ColorGray}}({{TearsSmall}}+2.1/{{SpeedSmall}}-0.42)"
			.."",
			QuoteDesc = "너무 수상해...",
		},
		[COLLECTIBLE_TECH_EYE] = {
			Name = "테크 아이",
			Description = ""
			--.."#The character's tears now create a laser ring upon hitting an enemy, dealing additional damage"
			.."#눈물 명중 시 작은 원형 레이저를 추가로 발생시킵니다."
			.."",
			QuoteDesc = "레이저와 눈물",
		},
		[COLLECTIBLE_ABUSE] = {
			Name = "학대",
			Description = ""
			--.."#Mom's foot constantly tries to stomp the character#When taking damage from Mom's foot, the character will get the berserk effect#Each time you take mom's foot damage, gain extra damage in berserk state and make mom's foot stomp more aggressively"
			.."#!!! 주기적으로 캐릭터의 위치에 엄마발이 떨어집니다."
			.."#{{Collectible704}} 엄마발에 피격 시 폭주 상태로 돌입합니다."
			.."#!!! 폭주 시마다 지속시간 증가 + 엄마발이 더 자주 등장"
			.."",
			QuoteDesc = "...",
		},
		[COLLECTIBLE_THE_FAT_ONION] = {
			Name = "뚱뚱한 양파",
			Description = ""
			--.."#Increase tears size#↑ +1 Damage#{{ArrowDown}} -0.3 Shot Speed Down#{{ArrowDown}} -0.2 Speed"
			.."#↓ {{SpeedSmall}}이동속도 -0.2"
			.."#↑ {{DamageSmall}}공격력 +1"
			.."#↓ {{ShotspeedSmall}}탄속 -0.3"
			.."#↑ {{TearsizeSmall}}눈물크기 x2"
			.."",
			QuoteDesc = "느려져",
		},
		[COLLECTIBLE_DRY_EYE] = {
			Name = "마른 눈",
			Description = ""
			--.."#↑ Shooting in one direction gradually increases damage up to 200% #As soon as character change firing direction or taking damage, characters damage is reset to its normal amount"
			.."#{{DamageSmall}} 눈물을 한 방향으로만 발사 시 공격력이 최대 2배까지 지속적으로 증가합니다."
			.."",
			QuoteDesc = "공격 강화",
		},
		[COLLECTIBLE_STARER_PACK] = {
			Name = "스타터 팩",
			Description = ""
			--.."#↑ +0.1 Damage#Grants various pickup at the start of the next run"
			.."#↑ {{DamageSmall}} 공격력 +0.1"
			.."# 다음 게임에서 랜덤 픽업 5개를 드랍합니다."
			.."",
			QuoteDesc = "초심자용",
		},
		[COLLECTIBLE_GIGANTIC_BOMB] = {
			Name = "기간틱 봄",
			Description = ""
			--.."#+10 Giga bomb"
			.."#{{Bomb}} 폭탄 +5"
			.."#{{Bomb}} 소지 중인 폭탄 중 최대 10개를 기가폭탄으로 바꿉니다."
			.."",
			QuoteDesc = "폭발할 시간이다!",
		},
		[COLLECTIBLE_DNA_REPLICATION] = {
			Name = "DNA 복제",
			Description = ""
			--.."#Counts as 1 item towards to all transformations while held#Except Adult and Stompy transformation"
			.."#모든 세트 효과 +1"
			.."",
			QuoteDesc = "이해하기 어려울 거야...",
		},
		[COLLECTIBLE_CLONING_TUBE] = {
			Name = "복제 튜브",
			Description = ""
			--.."#Generate mini Isaac/Auri"
			.."#사용 시 꼬마 아이작 패밀리어를 소환합니다."
			.."",
			QuoteDesc = "꼬마 아이작 생성기",
		},
	}

	local TrinketDesc = {
  	[TrinketType.TRINKET_AURI_CROWN] = {
			Name = "아리의 왕관",
			Description = ""
			--.."#Damage x 1.5#{{ColorRed}}Destroys itself when character take damage"
			.."#↑ {{DamageSmall}} 공격력 배율 +50%"
			.."#!!! {{ColorRed}}피격 시 사라집니다."
			.."",
			QuoteDesc = "굉장히 강해 보여!",
		},
		[TrinketType.TRINKET_CROWN_OF_DEATH] = {
			Name = "죽음의 왕관",
			Description = ""
			--.."#{{Warning}}{{Warning}}{{Warning}} #Gain damage *2.5#{{ColorRed}}Taking damage will kill character instantly#{{ColorRed}}Chance to gulp itself while held"
			.."#↑ {{DamageSmall}} 공격력 배율 x2.49"
			.."#!!! {{ColorRed}}피격 시 사망합니다."
			.."#!!! 1프레임 당 1/999의 확률로 강제흡수"
			.."",
			QuoteDesc = "하드코어",
		},
		[TrinketType.TRINKET_ENCHANT_PENNY] = {
			Name = "인챈트 페니",
			Description = ""
			--.."#25% Chance to get {{Luck}}+0.5 luck up when picking up a coin"
			.."#{{LuckSmall}} 동전 획득 시 25%의 확률로 행운 +0.5"
			.."",
			QuoteDesc = "행운 부자",
		},
		[TrinketType.TRINKET_AURI_HAIR_CLIP] = {
			Name = "아리의 헤어 클립",
			Description = ""
			--.."#Chance for enemies to get charmed when entering a room #{{ColorGreen}}The chance for this effect to activate is affected by characters Luck stat"
			.."#{{Charm}} 방 입장 시 16%의 확률로 적이 매혹에 걸립니다."
			.."#{{LuckSmall}} 행운 25+일 때 100%"
			.."",
			QuoteDesc = "귀여워!",
		},
		[TrinketType.TRINKET_FIRE_SPELL_SCROLL] = {
			Name = "불의 마법 주문서",
			Description = ""
			--.."#Chance to activate Fire spell book when entering a room"
			.."#{{Collectible"..COLLECTIBLE_FIRE_SPELLBOOK.."}} 방 입장 시 Fire Spell Book을 발동합니다."
			.."",
			QuoteDesc = "이걸로 주문을 외울 수 있어!",
		},
		[TrinketType.TRINKET_SOUL_PENNY] = {
			Name = "영혼 페니",
			Description = ""
			--.."#25% Chance to gain a wisp when picking up a coin"
			.."#{{Collectible584}} 동전 획득 시 25%의 확률로 위습을 하나 소환합니다."
			.."",
			QuoteDesc = "영혼 부자",
		},
		[TrinketType.TRINKET_MORPH_PENNY] = {
			Name = "변이 페니",
			Description = ""
			--.."#25% Chance to spawn mini isaac when picking up a coin"
			.."#{{Collectible658}} 동전 획득 시 25%의 확률로 꼬마 아이작을 하나 소환합니다."
			.."",
			QuoteDesc = "친구 부자",
		},
		[TrinketType.TRINKET_MINE_PENNY] = {
			Name = "지뢰 페니",
			Description = ""
			--.."#100% Chance to explode when picking up sticky nickel #50% Chance to explode when picking up a coin# 0% Chance with lucky penny and nickel"
			.."#{{Collectible40}} !!! 끈적한 니켈 접촉 시 100%의 확률로 자폭합니다."
			.."#{{Collectible40}} !!! 행운동전/니켈이 아닌 동전 접촉 시 50%의 확률로 자폭합니다."
			.."",
			QuoteDesc = "콰쾅!!!!!",
		},
		[TrinketType.TRINKET_LESSER_KEY] = {
			Name = "렛서 키",
			Description = ""
			--.."#12% Chance to get a lemegeton wisp when picking up a key# 50% Chance with golden key"
			.."#{{Collectible712}} 열쇠 획득 시 12%의 확률로 아이템 위습을 소환합니다."
			.."#>>> {{ColorGold}}(황금열쇠의 경우 50%)"
			.."",
			QuoteDesc = "솔로몬의 힘",
		},
		[TrinketType.TRINKET_CHALLENGE_CROWN] = {
			Name = "챌린지 왕관",
			Description = ""
			--.."#After start of a new floor, if character don't take damage for 2 stages it'll drop a reward#If character take damage you can take the challange again by going to a new floor#{{Warning}} {{ColorRed}}Character need to go to bossroom with this trinket, if character skip bossroom, it won't count"
			.."#{{BossRoom}} 피격을 받지 않고 보스방 2개 클리어 시:"
			.."#>>> 스테이지 진입 시 랜덤 아이템을 소환합니다."
			.."",
			QuoteDesc = "극복하라, 그리하면 얻어내리라",
		},
		[TrinketType.TRINKET_GLOWING_ORB] = {
			Name = "빛나는 오브",
			Description = ""
			--.."#↑ +3 luck up#Randomly show fortune text while holding this"
			.."#↑ {{LuckSmall}} 행운 +3"
			.."#!!! 주기적으로 운세가 등장합니다."
			.."",
			QuoteDesc = "뭔가 좋은 게 올 것 같아!",
		},
  	[TrinketType.TRINKET_AURIS_LOCK] = {
			Name = "아리의 머리카락",
			Description = ""
			--.."#If the characters damage is less than 5.50, keep increasing it until it reaches 5.50"
			.."#{{DamageSmall}} 공격력이 5.5 이하로 감소할 때;"
			.."#>>> 공격력을 서서히 5.5로 증가시킵니다."
			.."",
			QuoteDesc = "힘을 되찾자",
		},
  	[TrinketType.TRINKET_MILCAHS_FAITH] = {
			Name = "밀차의 축복",
			Description = ""
			--.."#After clearing a room, have a 25% chance to heal half a red heart if the character does not have soul or black hearts"
			.."#!!! 방 클리어 시 소울하트가 없을 때:"
			.."#>>> {{HalfHeart}} 25%의 확률로 빨간하트 반칸을 회복합니다."
			.."",
			QuoteDesc = "믿음이 날 강하게 해",
		},
  	[TrinketType.TRINKET_BRITTLE_PENNY] = {
			Name = "쇠약 페니",
			Description = ""
			--.."#25% Chance to get bone orbital when picking up a coin"
			.."#동전 획득 시 25%의 확률로 뼛조각을 소환합니다."
			.."",
			QuoteDesc = "뼈 부자",
		},
  	[TrinketType.TRINKET_HANSENS_PENNY] = {
			Name = "한센 페니",
			Description = ""
			--.."#20% Chance to get leprocy orbital when picking up a coin#a maximum of 3 leprocy orbitals can be active at one time"
			.."#{{Collectible525}} 동전 획득 시 20%의 확률로 문둥병 조각을 소환합니다. (최대 3)"
			.."",
			QuoteDesc = "질병 페니",
		},
  	[TrinketType.TRINKET_TECH_PENNY] = {
			Name = "테크 페니",
			Description = ""
			--.."#spawn laser ring when picking up a coin"
			.."#동전 획득 시 레이저 고리를 소환합니다."
			.."",
			QuoteDesc = "기술 페니",
		},
  	[TrinketType.TRINKET_MODED_CARTRIDGE] = {
			Name = "개조된 카트리지",
			Description = ""
			--.."#Grants 10% base chance to trigger The Gamekid effect upon enter a new room#Gain +0.5 Speed while in the Gamekid effect"
			.."#{{Collectible93}} 방 입장 시 10%의 확률로 Gamekid 효과를 발동합니다."
			.."#{{Collectible93}} {{SpeedSmall}} Gamekid 효과 발동 중 추가 이동속도 +0.5"
			.."",
			QuoteDesc = "1 / 99999",
		},
  	[TrinketType.TRINKET_NECRO_PENNY] = {
			Name = "네크로 페니",
			Description = ""
			--.."#15% Chance to summon a friendly Bony when picking up a coin"
			.."#{{Collectible545}} 동전 획득 시 10%의 확률로 아군 Bony를 소환합니다."
			.."",
			QuoteDesc = "군대 부자",
		},
		[TrinketType.TRINKET_POWER_PELLETS] = {
			Name = "파워 쿠키",
			Description = ""
			--.."#When enter a new room, this trinket will drop in random position in the room#When pickup trigger The Gamekid effect"
			.."#방 입장 시 랜덤 위치로 버려집니다."
			.."#{{Collectible93}} 장신구를 주으면 Gamekid 효과를 발동합니다."
			.."",
			QuoteDesc = "뻐끔뻐끔",
		},
		[TrinketType.TRINKET_POOPPY_PENNY] = {
			Name = "똥같은 페니",
			Description = ""
			--.."#25% Chance to spawn friendly dip when picking up a coin"
			.."#{{Collectible576}} 동전 획득 시 25%의 확률로 아군 Dip을 소환합니다."
			.."",
			QuoteDesc = "똥 부자",
		},
		[TrinketType.TRINKET_NAIL_PENNY] = {
			Name = "네일 페니",
			Description = ""
			--.."#When picking up a coin, have a chance to deal fake damage to yourself without losing any health#This does not provide the character invincibility"
			.."#{{Collectible486}} 동전 획득 시 50%의 확률로 피격 효과를 발동합니다. (무적시간 없음)"
			.."",
			QuoteDesc = "고통 부자",
		},
		[TrinketType.TRINKET_DARK_PENNY] = {
			Name = "어둠의 페니",
			-- Dark Item
			Description = ""
			--.."#{{ColorPurple}}{{Blank}} Dark item#{{ColorPurple}}Chance to get a broken heart or +0.1 damage up when picking up a coin#{{ColorPurple}}have a small chance to gulp itself when pickup a coin"
			.."#!!! {{ColorPurple}}동전 획득 시 아래 중 하나 발동:"
			.."#>>> {{DamageSmall}} {{ColorPurple}}공격력 +0.1"
			.."#>>> {{BrokenHeart}} {{ColorPurple}}부서진하트 +1"
			.."#>>> {{Collectible479}} {{ColorPurple}}장신구 흡수"
			.."",
			QuoteDesc = "어둠 부자",
		},
		[TrinketType.TRINKET_DARK_HEART] = {
			Name = "어둠의 심장",
			-- Dark Item
			Description = ""
			.."#!!! 스테이지 진입 시:"
			.."#>>> {{BrokenHeart}} {{ColorPurple}}부서진하트 +1"
			.."#>>> {{BrokenHeart}} {{ColorPurple}}{{DamageSmall}} 공격력 +0.5"
			.."",
			QuoteDesc = "뭔가 검게 보여",
		},
		[TrinketType.TRINKET_DARK_AURI_CROWN] = {
			Name = "다크 아리의 왕관",
			-- Dark Item
			Description = ""
			.."#{{BrokenHeart}} {{ColorPurple}}피격 시 부서진하트 +1"
			.."#{{BrokenHeart}} {{ColorPurple}}{{DamageSmall}} 부서진하트 당 공격력 +0.5"
			.."",
			QuoteDesc = "어둠의 힘을 얻었다... 그 대가는?",
		},
		-------------------------------
		[Trinkets.TRINKET_MUSHROOM_CAP] = {
			Name = "버섯 모자",
			Description = ""
			.."#소지 중일 때 Fun Guy 세트에 포함됩니다."
			.."",
			QuoteDesc = "버섯 +1",
		},
		[Trinkets.TRINKET_POCKET_BOOK] = {
			Name = "꼬마 책",
			Description = ""
			.."#소지 중일 때 Bookworm 세트에 포함됩니다."
			.."",
			QuoteDesc = "책 +1",
		},
		[Trinkets.TRINKET_POOP_NUGGET] = {
			Name = "똥 너겟",
			Description = ""
			.."#소지 중일 때 Oh Crap 세트에 포함됩니다."
			.."",
			QuoteDesc = "똥 +1",
		},
		[Trinkets.TRINKET_SPIDER_EYE] = {
			Name = "거미눈",
			Description = ""
			.."#소지 중일 때 Spider Baby 세트에 포함됩니다."
			.."",
			QuoteDesc = "거미 +1",
		},
		[Trinkets.TRINKET_TINY_CROSS] = {
			Name = "작은 십자가",
			Description = ""
			.."#소지 중일 때 Seraphim 세트에 포함됩니다."
			.."",
			QuoteDesc = "천사 +1",
		},
		[Trinkets.TRINKET_TINY_CROSZ] = {
			Name = "작은 십자가?",
			Description = ""
			.."#소지 중일 때 Leviathan 세트에 포함됩니다."
			.."",
			QuoteDesc = "악마 +1",
		},
		[Trinkets.TRINKET_BOB_TONGUE] = {
			Name = "밥의 혀",
			Description = ""
			.."#소지 중일 때 Bob 세트에 포함됩니다."
			.."",
			QuoteDesc = "밥 +1",
		},
		[Trinkets.TRINKET_FLY_WING] = {
			Name = "파리 날개",
			Description = ""
			.."#소지 중일 때 Beelzebub 세트에 포함됩니다."
			.."",
			QuoteDesc = "파리 +1",
		},
		[Trinkets.TRINKET_EMPTY_SYRINGE] = {
			Name = "빈 주사기",
			Description = ""
			.."#소지 중일 때 Spun 세트에 포함됩니다."
			.."",
			QuoteDesc = "주사기 +1",
		},
		[Trinkets.TRINKET_CONJOINED] = {
			Name = "샴쌍둥이",
			Description = ""
			.."#소지 중일 때 Conjoined 세트에 포함됩니다."
			.."",
			QuoteDesc = "쌍둥이 +1",
		},
	}

	local SynergyEntries = {
		["Auri Hourglass"] = {Description = "사망 시 시간을 되돌립니다.#{{Slow}} 피격 시 그 방의 적을 둔화시킵니다.", Item = {CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS}, PlayerType = {PLAYER_AURI},},
		--["Auri Lazarus"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURI},},
		--["Auri Judas"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURI},},
		--["Auri Ankh"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURI},},
		["Auri My Shadow"] = {Description = "{{DamageSmall}} 방 입장 시 11%의 확률로 공격력 배율 x2", Item = {CollectibleType.COLLECTIBLE_MY_SHADOW}, PlayerType = {PLAYER_AURI},},
		--["Auri Little Auri"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURI},},
		--["Auri Princess Baby"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURI},},
		["Aurii Satanic"] = {Description = "사용 시 {{Heart}}+1, {{BrokenHeart}}+1", Item = {CollectibleType.COLLECTIBLE_SATANIC_BIBLE}, PlayerType = {PLAYER_AURIB},},
		["Aurii Revelations"] = {Description = "사용 시 {{BrokenHeart}}-1", Item = {CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS}, PlayerType = {PLAYER_AURIB},},
		["Aurii Nail"] = {Description = "{{HalfHeart}} 빨간하트를 대신 회복", Item = {CollectibleType.COLLECTIBLE_THE_NAIL}, PlayerType = {PLAYER_AURIB},},
		["Aurii Hourglass"] = {Description = "!!! 무효과", Item = {CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, COLLECTIBLE_BROKEN_GLOWING_HOURGLASS}, PlayerType = {PLAYER_AURIB},},
		["Aurii Little Auri"] = {Description = "", Item = {111}, PlayerType = {PLAYER_AURIB},},
		["Naamah Seduce"] = {Description = "", Item = {COLLECTIBLE_SEDUCE}, PlayerType = {PLAYER_NAAMAH},},
		["Milcah Dying"] = {Description = "", Item = {COLLECTIBLE_DYING}, PlayerType = {PLAYER_MILCAH},},
	}

	-- TODO 생득권 아이콘 추가되면 예정
	for k, v in pairs(SynergyEntries) do
		--EID.descriptions["ko_kr"].ConditionalDescs[k] = v.Description
		--EID:AddPlayerConditional(v.Item, v.PlayerType, k)
	end

	for playerType, birthrightdesc in pairs(CharacterDesc) do
		--EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
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
		if itemdesc.BingeEater then
			EID.descriptions["ko_kr"].bingeEaterBuffs[itemID] = itemdesc.BingeEater
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

	return {
		targetMod = "Little Auri",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end