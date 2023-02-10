
if GODMODE then

	EID._currentMod = "AOIGodmodeAchieved"

	local Items = GODMODE.registry.items
	
	local BirthrightDesc = {
    [GODMODE.players[Isaac.GetPlayerTypeByName("Recluse",false)]] = {
			Name = "Recluse",
			Description = "{{Collectible"..Items.larval_therapy.."}}진드기의 공격력 +50%",
			QuoteDesc = "",
    },
	}

	local CollectibleDesc = {
		[Items.black_mushroom] = {
			Description = "!!! 일회용#!!! 사용 시;#↓ {{EmptyHeart}}최대 체력 -1#↑ {{SoulHeart}}소울하트 +3#{{Heart}} 체력을 전부 회복합니다.#사용한 방에서 나가면 스테이지를 재시작합니다.",
			Name = "암흑 버섯",
			QuoteDesc = "",
		},
		[Items.crown_of_gold] = {
			Description = "방 입장 시 랜덤 적 하나를 석화시킵니다. #{{Coin}}동전 25개마다 {{LuckSmall}}행운 +1#↓ 피격 시 일정 수량만큼의 동전을 잃습니다.#!!! 수량 : (5 + {{DamageSmall}} - (1~3))",
			Name = "황금 왕관",
			QuoteDesc = "",
		},
		[Items.dads_balloon] = {
			Description = "!!! 사용 시:#캐릭터의 위치에 적을 석화시키는 장판을 깔거나;#4/8/16방향의 눈물을 발사합니다.",
			Name = "아빠의 풍선",
			QuoteDesc = "",
		},
		[Items.fallen_guardian] = {
			Description = "적을 쫓아다니며 접촉한 적에게 캐릭터의 공격력 x0.15 + 1.3의 피해를 줍니다.#적을 오래 공격할수록 공격 주기가 더 짧아집니다.",
			Name = "타락한 수호자",
			QuoteDesc = "",
		},
		[Items.feather_duster] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.1#부정적인 문 효과가 발생하지 않습니다.#거미줄을 밟으면 거미줄이 사라집니다.",
			Name = "더스터 깃털",
			QuoteDesc = "",
		},
		[Items.fruit_salad] = {
			Description = "↑ 최대 체력 +1#↑ 빨간하트 +2#↑ 소울하트 +1#획득 시 랜덤 스탯을 5분간 증가시키는 과일을 8개 드랍합니다.",
			Name = "과일 샐러드",
			QuoteDesc = "",
		},
		[Items.fuzzy_dice] = {
			Description = "사용 시 각각 소지 중인 {{Coin}}/{{Bomb}}/{{Key}}의 33%를 섞습니다.",
			Name = "애매한 주사위",
			QuoteDesc = "",
		},
		[Items.larval_therapy] = {
			Description = "적 처치 시 체력이 가장 높은 적을 쫒아가는 진드기를 소환합니다.#진드기는 적에게 캐릭터의 공격력 x0.25의 피해를 주며 10번의 피해를 주면 사라집니다.",
			Name = "벌레 테라피",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {

	}

	local CardDesc = {

	}

	local PillDesc = {

	}

end