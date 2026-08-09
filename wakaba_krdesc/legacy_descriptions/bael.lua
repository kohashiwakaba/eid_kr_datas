
if BaelMOD then

	EID._currentMod = "Bael"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = CollectibleType
	local Trinkets = TrinketType

	local BirthrightDesc = {
		[PlayerType.PLAYER_BAEL] = {
			Name = "Bael",
			QuoteDesc = "획득멘트",
			Description = "생득권 설명",
			Detailed = "",
			Birthright = "{{ColorTransform}}The Cat{{ColorText}} now drops {{Card49}} 2 Wet Dice Shards in {{TreasureRoom}} Treasure Rooms#{{Card49}} Wet Dice Shards have a higher chance to spawn in other special rooms",
		},
	}

	local CollectibleDesc = {
		[CollectibleType.COLLECTIBLE_CAT_PYRAMID] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Collectible284}} Activates the D4 effect on pickup",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SACK] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Pill}} Automatically consumes 5 random pills",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BURGLAR] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Collectible144}} Grants Bum Friend#Lose 75% of your money on pickup#Drops extra goodies depending on how much was lost ({{Luck}})",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PAJAMAS] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Converts all {{Heart}} Red Heart Containers into {{BlackHeart}} Black Hearts#{{Heart}} Spawns 4 random hearts",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CROWN] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Coin}} Spawns 3-5 nickels#30 coins are removed next floor",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_KEY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Key}} Spawns 2-4 keys#Keys are replaced by other pickups {{Heart}}{{Coin}}{{Bomb}} for the next 2 floors",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_EMBLEM] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{BlackHeart}} +1 Black Heart#{{ArrowUp}} +0.2 Damage up#You receive {{Damage}} +0.5 damage up for every {{CurseBlind}} blind devil deal you take",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_COIN] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Coin}} Spawns a penny#{{ArrowDown}} -3 Luck",
			QuoteDesc = "TESET",
		},

		[CollectibleType.COLLECTIBLE_CAT_BREAKFAST] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} +0.7 Tears up#{{EmptyHeart}} {{ColorError}}-2 Heart Containers",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_LUNCH] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Heart}} +1 Heart Container#{{BlackHeart}} Spawns a Black Heart#{{ArrowDown}} {{ColorError}}-0.25 Damage down",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_DINNER] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Heart}} +1 Heart Container#{{ColorError}}Depletes all red health if possible",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SNACK] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Heart}} +1 Heart Container#{{BrokenHeart}} {{ColorError}}+3 Broken Hearts",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MEAT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{SoulHeart}} +3 Soul Hearts#{{EmptyHeart}} {{ColorError}}-1 Heart Container#{{ArrowDown}} {{ColorError}}-0.3 Tears down",
			QuoteDesc = "TESET",
		},

		[CollectibleType.COLLECTIBLE_CAT_REWARD] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ColorError}}All dropped hearts have a 25% chance to disappear on a timer#After entering Womb II or Corpse: Consume the item and activate the {{Collectible585}} Alabaster Box effect",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_JUDGEMENT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Spawn {{EternalHeart}} eternal hearts and retroactively receive {{Damage}} +0.2 damage for every unique {{ColorTransform}}Cat Item{{ColorText}} the player is holding",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CANDLE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{BlackHeart}} +1 Black Heart#{{ArrowUp}} +1.0 Tears up while {{CurseBlind}} Curse of the Blind is active#Automatically gives {{CurseBlind}} Curse of the Blind if devil or angel chance is at 100%",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_OPTION] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Card49}} Spawns a Wet Dice Shard#{{Card49}} A Wet Dice Shard spawns at the beginning of every floor",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BED] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} {{ColorError}}-0.35 Speed down#{{Heart}}{{Card}}{{Pill}} Spawn a small handful of hearts, cards and pills at the beginning of every floor#{{Luck}} You get more goodies with higher luck",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_NICKEL] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Coin}} Spawns 0-2 coins#Has a base 3% chance ({{Luck}}) to consume this and spawn a random item#{{ColorError}}Lose 1 coin after every new room while holding this",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_NUGGET] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Your bombs are limited to a max of 7#All bombs picked up after 7 turn into exploding attack flies",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_TOP] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Your damage fluctuates based on how fast you are currently moving",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MARBLE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{SoulHeart}} +1 Soul heart# Forces {{CurseBlind}} Curse of the Blind permanently",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_LAXATIVE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Pill}} Spawns a random pill#{{ArrowDown}} Size up#33% chance to poop at the beginning of every new room",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CUBE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Card49}} Spawns 2 Wet Dice Shards#Drops 2 of your items on the ground if possible#Only one can be retaken",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_FOOT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} -1 Luck down#{{ArrowDown}} -0.6 Damage down#Using a pill during the first 5 seconds of an active room grants you increased ({{Tears}}{{Damage}}{{Luck}}) stats for the current floor#Bad pills give more stats",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_GIFT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Spawn an item in the {{TreasureRoom}} Treasure Room of the next floor#If there is no treasure room, spawn one in a regular room instead#{{ColorError}}The item has a 40% chance to be {{Collectible36}} The Poop",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_NEEDLE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} +3.0 Tears up#{{ArrowUp}} +0.5 Speed up#These stats diminish based on the current floor#{{ColorError}}You may randomly lose health upon entering new floors beyond Chapter 3",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BLITZ] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Bomb}} +3 Bombs#Placing a bomb now drops 2 more basic bombs in quick succession",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_POLYGON] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Rerolls item pedestals into a {{ColorTransform}}Cat Item{{ColorText}} from any item pool#",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BEAN] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#40% chance for you to constantly spew slippery creep each room#While spewing, you have a high chance ({{Luck}}) to deflect enemy damage",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_APPLE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ColorError}}Tears and damage down while holding#{{Tears}}{{Damage}} Grants a massive tears or damage up depending on the slot this is being held in",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_GLASSES] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Enemies have a chance to become duplicated upon room entry#Duplicated enemies have a small chance ({{Luck}}) to drop {{HalfSoulHeart}} half a soul heart on death",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SAWBLADE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Taking damage blows you up and spawns you back at the door",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_WAFER] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Teleports you to the devil room",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_JOYSTICK] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#You occasionally start to drift in random directions",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SKELETON] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} Removes all Red Heart containers but one#{{ArrowUp}} +0.5 Damage up#Any guaranteed revive items you have are removed and replaced with +0.8 damage up",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_ONION] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} 0.7 Tears up#Fired tears are less accurate",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PISS] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} -1.5 Range down#{{ArrowDown}} -20% additional Range down#You have a chance to leave damaging creep while close to enemies",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SCARY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} +1.5 Tears up#You become feared after entering a new room for a few seconds",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MASK] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Protect up to 3 hits per room#This damage is instantly dealt in the next room",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_COLONY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Trinket94}} Gulp a Fish Tail (doubled blue flies)#Enemies may spawn spiders or flies on death",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CANDY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Heart}} In active rooms: Your red hearts drop on the ground as scared hearts#{{Damage}} Gain a temporary +0.2 damage up for every heart you pick back up#The hearts come back after room clear",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PREY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#50% chance to grant or remove flight every room#Takes priority over other items that give flight",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PACT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{BlackHeart}} +2 Black Hearts#{{ColorError}}One of the next hits you take will reduce you to one heart#Gain a permanent +1.0 tears and +1.0 damage up after this occurs",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_HOLE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#If {{ColorTransform}}The Cat{{ColorText}} is circling around an item pedestal: destroy it#Spawns the last item that was previously destroyed#Gives {{CurseBlind}} Curse of the Blind if no items were destroyed",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_FEAST] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Spawns an additional {{ColorTransform}}Cat Food Item{{ColorText}} in every boss room",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_VIGOR] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{BrokenHeart}} {{ColorError}}Gives 5 Broken Hearts on pickup#Removes a Broken Heart on use",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MASTERKEY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"# {{ColorError}}Forces your keys to 0 while held#Opens all doors and chests in the room",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CAP] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ColorError}}Removes all your soul hearts if possible#{{ArrowUp}} +0.16 Tears up for every soul heart lost#{{ArrowDown}} -0.16 Shot speed down",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MISSILE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Spawns an Epic Fetus rocket in every combat room#Going near the target makes the rocket drop",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CONTAGION] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Enemies may spawn with a green aura that damages you if you linger inside#The aura can damage other enemies down to half their health",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BOMB] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Explode",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PENNY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#+1 cent",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MATTER] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} +1.2 Damage up#{{ArrowDown}} -0.3 Tears down#Missing a tear will fire a homing projectile at you that deals no damage but briefly inflicts fear",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BLOOD] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} +1 Heart Container#{{ArrowUp}} +0.3 Speed#{{Heart}} Brings your heart containers up to a minimum of 4#{{ColorError}}Lose several of your soul hearts every floor",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_MUSHROOM] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowUp}} While big: +1.0 Damage and +0.15 Speed up#{{ArrowDown}} While small: All damage you take is doubled#Getting hit while big protects you and shrinks you down#More cat mushrooms can spawn from tinted rocks and occasionally new rooms",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_RAZOR] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{EmptyHeart}} Consumes 1 heart and grants a {{Damage}} Damage up that lasts 3-6 combat rooms#{{ColorError}}Enemies have 1.5x more health if this item is being held and the effect isn't active",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_LOCKET] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{SoulHeart}} +12 Soul Hearts#{{ArrowDown}} If you have soul hearts: your speed is maxed at 1.0 with a speed down for each soul heart#{{ArrowUp}} If you have no soul hearts: +1.0 tears and +1.0 damage up",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_HEART] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ColorError}}Deal 3 full hearts of damage on pickup (red hearts first)#{{ArrowUp}} Grants homing#{{ArrowUp}} 1.5x Damage Multiplier#{{ArrowUp}} +2.0 Damage up#{{ArrowDown}} -0.15 Shotspeed down#Taking damage has a 25% chance to spawn another {{Collectible"..CollectibleType.COLLECTIBLE_CAT_HEART.."}} Cat's Heart",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CONTRABAND] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Killed enemies have a chance to spawn a smaller duplicate with less health#{{Pill}} Duplicates have a small chance ({{Luck}}) to spawn a pill on death",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_DOLL] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} -0.5 Tears down#{{Heart}}{{RottenHeart}}{{SoulHeart}} Spawns a big random assortment of red, rotten and soul hearts",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_EGG] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Enemies may spawn with eggs orbiting them#Eggs that die hatch into dead birds that can hurt you and other enemies",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_JELLYBEAN] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Pickups have a small chance to be replaced with jellybeans",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CLOTH] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Card49}} Wet Dice Shards turn into {{Card41}} Black Runes instead of disappearing#Taking damage while holding a Black Rune will deal extra damage and destroy the rune#{{Warning}} Black Runes share the disappearing properties of Wet Dice Shards",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_IPECAC] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Hitting an enemy may cause them to blink and create an explosion after a small delay#{{Luck}} Chance increases with luck",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CASH] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ColorError}}{{ArrowDown}} -0.4 Damage down#{{ArrowUp}} +0.04 Damage up for every {{Coin}} coin you have#Extra money is scattered throughout the floor if {{CurseBlind}} Curse of the Blind is active",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_COLD] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#The first direction you shoot per floor will have its fire rate greatly reduced and afflict poison",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_PUZZLE] = {
			Name = "고양이 퍼즐",
			Description = ""
			.."#!!! 공격 버튼을 누르고 있을 때:"
			.."#>>> 캐릭터의 이동방향으로 적이 같이 이동합니다."
			.."{{CR}}",
			BaelOnly = true, --"#While firing, other enemies are slightly pushed in the same direction you are moving",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_COINSLOT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Using a {{Card49}} Wet Dice Shard now deals 40 damage to all enemies in the room and drops coins based on the total damage dealt#{{Collectible619}} This damage is doubled if you have Birthright",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BELT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Clearing a new room in under 6 seconds will reset the room and force you to clear it again with slightly buffed base stats and no other items#{{Damage}} Gain a permanent +0.15 Damage Up every time the effect triggers",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SQUISHTOY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Every room, spawns a Bouncy Cat Head that bounces off you and other enemies#Deals x2 your damage upon contact with enemies",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_GACHA] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#On pickup, spawns 3 Lucky Capsules#More Lucky Capsules can appear in dead end rooms#Extra Lucky Capsules may randomly appear in rooms if {{CurseBlind}} Curse of the Blind is active",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_SKIN] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Consumes 1 heart container or 2 soul hearts and spawns a {{ColorTransform}}Cat Item{{ColorText}} from any item pool",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_HOME] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{Collectible580}} If you haven't been hit for multiple rooms, you have a high chance of teleporting into an adjacent red room#Red rooms have harder layouts and increased enemy health",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_GLAUCOMA] = {
			Name = "Cat-aracts",
			Description = ""
			.."#!!! 필터 강제 적용"
			.."#{{DamageSmall}} 적과 멀어질수록 적에게 주는 피해량 감소"
			.."#{{Confusion}} 적과 일정 거리 이상 멀어지면 혼란"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Enables the Filter#Enemies take less damage the further they are away from you#Enemies become confused while they are far away",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_TAR] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} -0.5 Tears Down#Grants a familiar that constantly spews black creep that slows down enemies#Standing on black creep gives you slowing tears, slows you down and boosts your tear rate",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_CONTRACT] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#Instead of room clear rewards, {{ColorTransform}}The Cat{{ColorText}} has a 1/4 chance to offer a selection of various options that quickly cycle",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BELL] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#A bell will randomly ring, causing everything in the room to stop#Moving during this time will deal damage to you#Staying still will grant rewards",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_TOMB] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#An extra vault room will appear beyond Chapter 3 that contains two devil items and other rewards",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BOX] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Spawns 2 Wet Dice Shards#Spawns a random item",
			QuoteDesc = "TESET",
		},

		[CollectibleType.COLLECTIBLE_PENTOBARBITAL] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{ArrowUp}} +3.0 Tears up#{{ArrowUp}} +1.0 Damage up#{{ArrowUp}} +0.5 Speed up#These stats diminish based on the current floor#{{ColorError}}You may randomly lose health upon entering new floors beyond Chapter 3",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_PAGEANT_KITTY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{ArrowUp}} +1 Luck#{{Coin}} Spawns 5-7 nickels#25 coins are removed next floor",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_GUPPYS_SKELETON] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{EmptyBoneHeart}} Spawns 2 Bone Hearts#{{ArrowUp}} +0.5 Damage up#Any guaranteed revive items you have are removed and replaced with +0.8 damage up",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_MEWCHARIST] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Teleports you to a devil room with angel items and an angel statue",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_LEFT_FINGER] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Transforms all chests in the room into {{RedChest}} Red Chests#Transforms a random enemy in the room into a {{RedChest}} Red Chest#{{Warning}} While held: opening a Red Chest has a 50% chance to turn another enemy into a Red Chest",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_DARK_CUBE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Every new floor: drops 2 of your items on the ground in addition to 2 {{Card49}} Wet Dice Shards#Pickup effects are regranted when picking items back up",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_SURGICAL_DOLL] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Shuffles through and removes an item of your choosing from your inventory#Grants a random new item from the {{TreasureRoom}} Treasure Pool",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_COIN_STRING] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{Slotmachine}} Destroying a Slot Machine has an {{ColorTransform}}x%{{ColorText}} chance to drop 5-15 extra coins#{{ColorTransform}}x%{{ColorText}} is shown above the machine and can be rerolled by paying the machine",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_CAT_BOY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{BlackHeart}} +1 Black Heart#{{Damage}} Spawns a special beggar at the beginning of every floor that trades up to 6 soul or black hearts at once for damage#{{BlackHeart}} The beggar drops up to 2 black hearts when bombed if you have almost no soul or black hearts",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_GAMBLERS_FLESH] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"On pickup, spawns 3 Lucky Capsules#More Lucky Capsules can appear in dead end rooms",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_SQUISHY_FRIEND] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Throw a Bouncy Cat Head that bounces off you and other enemies#Deals x2 your damage upon contact with enemies, first hit does x5 damage",
			QuoteDesc = "TESET",
		},
		[CollectibleType.COLLECTIBLE_TOMBMATES] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"An extra vault room will appear beyond Chapter 3 that contains the miniboss {{ColorTransform}}\"The Cherub\"{{ColorText}}#You recieve {{Damage}} +0.25 damage during the fight for every devil deal taken during the run#Defeating the miniboss will spawn 2 devil items and other rewards",
			QuoteDesc = "TESET",
		},

		[CollectibleType.COLLECTIBLE_CAT_GLIZZY] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			BaelOnly = true, --"#{{ArrowDown}} -1 half-filled heart container#{{ArrowDown}} -0.1 speed down#{{ArrowDown}} -0.1 tears down#{{ArrowDown}} -0.1 damage down#{{ArrowDown}} -0.1 range down#{{ArrowDown}} -0.1 shot speed down#{{ArrowDown}} -0.1 luck down",
			QuoteDesc = "TESET",
		},
	}

	local TrinketDesc = {
		[TrinketType.TRINKET_PURPLE_MASK] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"Forces {{CurseBlind}} Curse of the Blind while held#You receive a permanent {{Damage}} +1.0 damage up for every {{CurseBlind}} blind devil deal you take",
			QuoteDesc = "TESET",
		},
		[TrinketType.TRINKET_PROMISE] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			--"{{TreasureRoom}} Shows you the vision of an item on pickup#{{Timer}} After a certain amount of floors: consume this trinket and spawn the item",
			QuoteDesc = "TESET",
		},
	}

	local CardDesc = {
		[Cards.bobs_tongue] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local PillDesc = {
		[Pills.bobs_tongue] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			Horse = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local entityDesc = {
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
		},
	}

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
	for itemID, itemdesc in pairs(CardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end

	local function FF_EIDKR_VanillaDescCondition(descObj)
		if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
		return
			descObj.ObjType == 5
			and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
			and VanillaCollectibles[descObj.ObjSubType]
	end

	local function FF_EIDKR_VanillaDescCallback(descObj)
		if VanillaCollectibles[descObj.ObjSubType] then
			local type = VanillaCollectibles[descObj.ObjSubType].Type
			if type == V_REPLACE then
				descObj.Description = VanillaCollectibles[descObj.ObjSubType].Description
			else
				EID:appendToDescription(descObj, "#"..VanillaCollectibles[descObj.ObjSubType].Description)
			end
		end
		return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_GodmodeVanillaDescs", FF_EIDKR_VanillaDescCondition, FF_EIDKR_VanillaDescCallback)


	return {
		targetMod = "Mod",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end