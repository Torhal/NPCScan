--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Barrows of Reverie (2254)
--------------------------------------------------------------------------------

Maps[MapID.BarrowsOfReverie].NPCs = {
    [209913] = true, -- Fruitface
}

--------------------------------------------------------------------------------
---- Emerald Dream (2200)
--------------------------------------------------------------------------------

Maps[MapID.EmeraldDream].NPCs = {
    [208658] = true, -- Moltenbinder's Disciple
    [209113] = true, -- Nuoberon
    [209365] = true, -- Splinterlimb
    [209574] = true, -- Aurostor
    [209620] = true, -- Ignit the Firebranded
    [209893] = true, -- Firebrand Fystia
    [209898] = true, -- Reefbreaker Moruud
    [209902] = true, -- Talthonei Ashwhisper
    [209909] = true, -- Crabtankerous
    [209911] = true, -- The Apostle
    [209912] = true, -- Raszageth's Last Breath
    [209913] = true, -- Fruitface
    [209915] = true, -- Amalgamation of Dreams
    [209919] = true, -- Isaqa
    [209929] = true, -- Envoy of Winter
    [209936] = true, -- Greedy Gessie
    [210045] = true, -- Moragh the Slothful
    [210046] = true, -- Keen-Eyed Cian
    [210047] = true, -- Somnambulant Ori
    [210050] = true, -- Bloodstripe Great Ray
    [210051] = true, -- Matriarch Keevah
    [210064] = true, -- Molten Leadspike
    [210070] = true, -- Mosa Umbramane
    [210075] = true, -- Henri Snufftail
    [210111] = true, -- Surging Lasher
    [210161] = true, -- Ristar the Rabid
    [210508] = true, -- Voracious Mikanji
    [210559] = true, -- Balboan
    [212090] = true, -- Elusive Blooming Brierhide
    [212133] = true, -- Elusive Verdant Gladewarden
}

--------------------------------------------------------------------------------
---- Ohn'ahran Plains (2023)
--------------------------------------------------------------------------------

Maps[MapID.OhnahranPlains].NPCs = {
    [187559] = true, -- Shade of Grief
    [187781] = true, -- Hamett
    [188095] = true, -- Hunter of the Deep
    [188124] = true, -- Irontree
    [188451] = true, -- Zerimek
    [189652] = true, -- Deadwaker Ghendish
    [191354] = true, -- Ty'foon the Ascended
    [191842] = true, -- Sulfurion
    [191950] = true, -- Porta the Overgrown
    [192020] = true, -- Eaglemaster Niraak
    [192045] = true, -- Windseeker Avash
    [192364] = true, -- Windscale the Stormborn
    [192453] = true, -- Vaniik the Stormtouched
    [192557] = true, -- Quackers the Terrible
    [192949] = true, -- Skaara
    [192983] = true, -- Web-Queen Ashkaz
    [193123] = true, -- Steamgill
    [193133] = true, -- Sunscale Behemoth
    [193136] = true, -- Scav Notail
    [193140] = true, -- Zarizz
    [193142] = true, -- Enraged Sapphire
    [193153] = true, -- Ripsaw the Stalker
    [193163] = true, -- Territorial Coastling
    [193165] = true, -- Sparkspitter Vrak
    [193168] = true, -- Biryuk
    [193170] = true, -- Fulgurb
    [193173] = true, -- Mikrin of the Raging Winds
    [193188] = true, -- Seeker Teryx
    [193209] = true, -- Zenet Avis
    [193212] = true, -- Malsegan
    [193215] = true, -- Scaleseeker Mezeri
    [193227] = true, -- Ronsak the Decimator
    [193235] = true, -- Oshigol
    [193534] = true, -- Strunraan
    [193644] = true, -- Bouldron
    [193645] = true, -- Crystalus
    [193647] = true, -- Karantun
    [193648] = true, -- Infernum
    [193650] = true, -- Emblazion
    [193652] = true, -- Grizzlerock
    [193653] = true, -- Gaelzion
    [193654] = true, -- Gravlion
    [193655] = true, -- Frozion
    [193669] = true, -- Prozela Galeshot
    [193674] = true, -- Voraazka
    [193675] = true, -- Kain Firebrand
    [193677] = true, -- Maeleera
    [193678] = true, -- Fieraan
    [193679] = true, -- Leerain
    [193680] = true, -- Zurgaz Corebreaker
    [193682] = true, -- Rouen Icewind
    [193684] = true, -- Pipspark Thundersnap
    [193686] = true, -- Neela Firebane
    [193710] = true, -- Seereel, the Spring
    [195186] = true, -- Cinta the Forgotten
    [195204] = true, -- The Jolly Giant
    [195223] = true, -- Rustlily
    [195409] = true, -- Makhra the Ashtouched
    [195895] = true, -- Nergazurai
    [196010] = true, -- Researcher Sneakwing
    [197009] = true, -- Liskheszaera
    [197411] = true, -- Astray Splasher
    [200832] = true, -- Fyrakk
    [201054] = true, -- Crimson Oldblood
    [201535] = true, -- Bloodbeak the Ravenous
    [201537] = true, -- Groffnar
    [201538] = true, -- Huntmaster Yrgena
    [201539] = true, -- Stormcaller Narkena
    [201540] = true, -- Lurgan
    [203698] = true, -- Rampant Shadowflame
    [203699] = true, -- Half-bound Rageflame
    [203700] = true, -- Flamebringer Shaman
    [203703] = true, -- Flamebringer Rageblood
    [203705] = true, -- Flamebringer Elementalist
    [203707] = true, -- Flamebringer Cauterizer
}

--------------------------------------------------------------------------------
---- Thaldraszus (2025)
--------------------------------------------------------------------------------

Maps[MapID.Thaldraszus].NPCs = {
    [183984] = true, -- The Weeping Vilomah
    [191305] = true, -- The Great Shellkhan
    [193125] = true, -- Goremaul the Gluttonous
    [193126] = true, -- Innumerable Ruination
    [193127] = true, -- Private Shikzar
    [193128] = true, -- Blightpaw the Depraved
    [193130] = true, -- Pleasant Alpha
    [193143] = true, -- Razk'vex the Untamed
    [193146] = true, -- Treasure-Mad Trambladd
    [193161] = true, -- Woolfang
    [193176] = true, -- Sandana the Tempest
    [193210] = true, -- Phleep
    [193220] = true, -- Broodweaver Araznae
    [193229] = true, -- Henlare
    [193234] = true, -- Eldoren the Reborn
    [193240] = true, -- Riverwalker Tamopo
    [193241] = true, -- Lord Epochbrgl
    [193243] = true, -- Acrosoth
    [193246] = true, -- Matriarch Remalla
    [193258] = true, -- Tempestrian
    [193273] = true, -- Liskron the Dazzling
    [193533] = true, -- Liskanoth
    [193644] = true, -- Bouldron
    [193645] = true, -- Crystalus
    [193647] = true, -- Karantun
    [193648] = true, -- Infernum
    [193650] = true, -- Emblazion
    [193652] = true, -- Grizzlerock
    [193653] = true, -- Gaelzion
    [193654] = true, -- Gravlion
    [193655] = true, -- Frozion
    [193658] = true, -- Corrupted Proto-Dragon
    [193663] = true, -- Craggravated Elemental
    [193664] = true, -- Ancient Protector
    [193666] = true, -- Rokmur
    [193668] = true, -- Lookout Mordren
    [193674] = true, -- Voraazka
    [193675] = true, -- Kain Firebrand
    [193677] = true, -- Maeleera
    [193678] = true, -- Fieraan
    [193679] = true, -- Leerain
    [193680] = true, -- Zurgaz Corebreaker
    [193682] = true, -- Rouen Icewind
    [193684] = true, -- Pipspark Thundersnap
    [193686] = true, -- Neela Firebane
    [193688] = true, -- Phenran
    [200832] = true, -- Fyrakk
    [201054] = true, -- Crimson Oldblood
    [201549] = true, -- Morlash
    [201550] = true, -- Overloading Defense Matrix
    [201552] = true, -- Overseer Stonetongue
    [201664] = true, -- Temporal Investi-gator
    [203698] = true, -- Rampant Shadowflame
    [203699] = true, -- Half-bound Rageflame
    [203700] = true, -- Flamebringer Shaman
    [203703] = true, -- Flamebringer Rageblood
    [203705] = true, -- Flamebringer Elementalist
    [203707] = true, -- Flamebringer Cauterizer
    [205865] = true, -- Zal'kir the Chosen
}

--------------------------------------------------------------------------------
---- The Azure Span (2024)
--------------------------------------------------------------------------------

Maps[MapID.TheAzureSpan].NPCs = {
    [186962] = true, -- Cascade
    [190244] = true, -- Mahg the Trampler
    [191356] = true, -- Frostpaw
    [192749] = true, -- Sharpfang
    [193116] = true, -- Beogoka
    [193149] = true, -- Skag the Thrower
    [193157] = true, -- Dragonhunter Gorund
    [193178] = true, -- Blightfur
    [193196] = true, -- Trilvarus Loreweaver
    [193201] = true, -- Mucka the Raker
    [193214] = true, -- Forgotten Creation
    [193223] = true, -- Vakril
    [193225] = true, -- Notfar the Unbearable
    [193238] = true, -- Spellwrought Snowman
    [193251] = true, -- Gruffy
    [193259] = true, -- Blue Terror
    [193269] = true, -- Grumbletrunk
    [193288] = true, -- Summoned Destroyer
    [193532] = true, -- Bazual
    [193632] = true, -- Wilrive
    [193644] = true, -- Bouldron
    [193645] = true, -- Crystalus
    [193647] = true, -- Karantun
    [193648] = true, -- Infernum
    [193650] = true, -- Emblazion
    [193652] = true, -- Grizzlerock
    [193653] = true, -- Gaelzion
    [193654] = true, -- Gravlion
    [193655] = true, -- Frozion
    [193674] = true, -- Voraazka
    [193675] = true, -- Kain Firebrand
    [193677] = true, -- Maeleera
    [193678] = true, -- Fieraan
    [193679] = true, -- Leerain
    [193680] = true, -- Zurgaz Corebreaker
    [193682] = true, -- Rouen Icewind
    [193684] = true, -- Pipspark Thundersnap
    [193686] = true, -- Neela Firebane
    [193691] = true, -- Fisherman Tinnak
    [193698] = true, -- Frigidpelt Den Mother
    [193706] = true, -- Snufflegust
    [193708] = true, -- Skald the Impaler
    [194210] = true, -- Azure Pathfinder
    [194270] = true, -- Arcane Devourer
    [194392] = true, -- Brackle
    [195353] = true, -- Breezebiter
    [197344] = true, -- Snarglebone
    [197353] = true, -- Blisterhide
    [197354] = true, -- Gnarls
    [197356] = true, -- High Shaman Rotknuckle
    [197557] = true, -- Bisquius
    [198004] = true, -- Mange the Outcast
    [200832] = true, -- Fyrakk
    [201054] = true, -- Crimson Oldblood
    [203698] = true, -- Rampant Shadowflame
    [203699] = true, -- Half-bound Rageflame
    [203700] = true, -- Flamebringer Shaman
    [203703] = true, -- Flamebringer Rageblood
    [203705] = true, -- Flamebringer Elementalist
    [203707] = true, -- Flamebringer Cauterizer
}

--------------------------------------------------------------------------------
---- The Forbidden Reach (2118)
--------------------------------------------------------------------------------

Maps[MapID.TheForbiddenReach].NPCs = {
    [181427] = true, -- Stormspine
    [181833] = true, -- Shimmermaw
    [182280] = true, -- Tazenrath
    [191713] = true, -- Scytherin
    [191729] = true, -- Deathrip
    [191746] = true, -- Ketess the Pillager
}

--------------------------------------------------------------------------------
---- The Forbidden Reach (2151)
--------------------------------------------------------------------------------

Maps[MapID.TheForbiddenReach2].NPCs = {
    [200537] = true, -- Gahz'raxes
    [200579] = true, -- Ishyra
    [200584] = true, -- Vraken the Hunter
    [200600] = true, -- Reisa the Drowned
    [200610] = true, -- Duzalgor
    [200619] = true, -- Tectonus
    [200620] = true, -- Sir Pinchalot
    [200621] = true, -- Manathema
    [200622] = true, -- Snarfang
    [200681] = true, -- Bonesifter Marwak
    [200717] = true, -- Galakhad
    [200721] = true, -- Grugoth the Hullcrusher
    [200722] = true, -- Gareed
    [200725] = true, -- Faunos
    [200730] = true, -- Tidesmith Zarviss
    [200737] = true, -- Arcantrix
    [200738] = true, -- Kangalo
    [200739] = true, -- Fimbol
    [200740] = true, -- Agni Blazehoof
    [200742] = true, -- Luttrok
    [200743] = true, -- Amephyst
    [200885] = true, -- Lady Shaz'ra
    [200904] = true, -- Veltrax
    [200911] = true, -- Volcanakk
    [200956] = true, -- Ookbeard
    [200960] = true, -- Warden Entrix
    [200978] = true, -- Pyrachniss
    [201013] = true, -- Wyrmslayer Angvardi
    [201181] = true, -- Mad-Eye Carrey
    [201186] = true, -- Shimmermaw Jr.
    [201310] = true, -- Nidharr
    [203353] = true, -- Loot Specialist
}

--------------------------------------------------------------------------------
---- The Primalist Future (2085)
--------------------------------------------------------------------------------

Maps[MapID.ThePrimalistFuture].NPCs = {
    [201542] = true, -- Tikarr Frostclaw
    [201543] = true, -- Avalantus
    [201545] = true, -- Shapemaster Za'lani
    [201562] = true, -- Shardwing
}

--------------------------------------------------------------------------------
---- The Waking Shores (2022)
--------------------------------------------------------------------------------

Maps[MapID.TheWakingShores].NPCs = {
    [184853] = true, -- Primal Scythid Queen
    [186200] = true, -- Harkyn Grymstone
    [186201] = true, -- Groth
    [186202] = true, -- Voll
    [186203] = true, -- Snee
    [186783] = true, -- Cauldronbearer Blakor
    [186827] = true, -- Magmaton
    [186859] = true, -- Worldcarver A'tir
    [187111] = true, -- Ancient Hornswog
    [187209] = true, -- Klozicc the Ascended
    [187306] = true, -- Morchok
    [187598] = true, -- Rohzor Forgesmash
    [187886] = true, -- Turboris
    [187945] = true, -- Anhydros the Tidetaker
    [189289] = true, -- Penumbrus
    [189822] = true, -- Shas'ith
    [190718] = true, -- Monsoo, The Boiling Rage
    [190985] = true, -- Death's Shadow
    [190986] = true, -- Battlehorn Pyrhus
    [190991] = true, -- Char
    [191611] = true, -- Dragonhunter Igordan
    [192362] = true, -- Possessive Hornswog
    [192737] = true, -- Qalashi War Mammoth
    [192738] = true, -- Brundin the Dragonbane
    [192741] = true, -- Flamebreaker Grella
    [192743] = true, -- Stonefist Rejara
    [192744] = true, -- Scalemelter Dorbane
    [193118] = true, -- O'nank Shorescour
    [193120] = true, -- Smogswog the Firebreather
    [193132] = true, -- Amethyzar the Glittering
    [193134] = true, -- Enkine the Voracious
    [193135] = true, -- Azra's Prized Peony
    [193148] = true, -- Thunderous Matriarch
    [193152] = true, -- Massive Magmashell
    [193154] = true, -- Forgotten Gryphon
    [193171] = true, -- Terillod the Devout
    [193175] = true, -- Slurpo, the Incredible Snail
    [193177] = true, -- Beakers
    [193181] = true, -- Skewersnout
    [193198] = true, -- Captain Lancer
    [193217] = true, -- Drakewing
    [193226] = true, -- Gorjo the Crab Shackler
    [193228] = true, -- Snappy
    [193232] = true, -- Rasnar the War Ender
    [193256] = true, -- Nulltheria the Void Gazer
    [193263] = true, -- Helmet Missingway
    [193266] = true, -- Lepidoralia the Resplendent
    [193271] = true, -- Shadeslash Trakken
    [193535] = true, -- Basrikron
    [193644] = true, -- Bouldron
    [193645] = true, -- Crystalus
    [193647] = true, -- Karantun
    [193648] = true, -- Infernum
    [193650] = true, -- Emblazion
    [193652] = true, -- Grizzlerock
    [193653] = true, -- Gaelzion
    [193654] = true, -- Gravlion
    [193655] = true, -- Frozion
    [193674] = true, -- Voraazka
    [193675] = true, -- Kain Firebrand
    [193677] = true, -- Maeleera
    [193678] = true, -- Fieraan
    [193679] = true, -- Leerain
    [193680] = true, -- Zurgaz Corebreaker
    [193682] = true, -- Rouen Icewind
    [193684] = true, -- Pipspark Thundersnap
    [193686] = true, -- Neela Firebane
    [195915] = true, -- Firava the Rekindler
    [196056] = true, -- Gushgut the Beaksinker
    [200832] = true, -- Fyrakk
    [201054] = true, -- Crimson Oldblood
    [203698] = true, -- Rampant Shadowflame
    [203699] = true, -- Half-bound Rageflame
    [203700] = true, -- Flamebringer Shaman
    [203703] = true, -- Flamebringer Rageblood
    [203705] = true, -- Flamebringer Elementalist
    [203707] = true, -- Flamebringer Cauterizer
}

--------------------------------------------------------------------------------
---- Zaralek Cavern (2133)
--------------------------------------------------------------------------------

Maps[MapID.ZaralekCavern].NPCs = {
    [200111] = true, -- Magtembo
    [201029] = true, -- Viridian King
    [201747] = true, -- Bogg
    [202270] = true, -- Animated Contaminant
    [202309] = true, -- Cavern Flayer Matriarch
    [202318] = true, -- Response Team Watcher
    [203355] = true, -- Captain Reykal
    [203462] = true, -- Kob'rok
    [203466] = true, -- Kapraku
    [203468] = true, -- Aquifon
    [203477] = true, -- Goopal
    [203480] = true, -- Spinmarrow
    [203515] = true, -- Alcanon
    [203521] = true, -- Professor Gastrinax
    [203592] = true, -- General Zskorro
    [203593] = true, -- Underlight Queen
    [203606] = true, -- Calibrating Scent Matrix
    [203618] = true, -- Klakatak
    [203621] = true, -- Brullo the Strong
    [203625] = true, -- Karokta
    [203627] = true, -- Invoq
    [203643] = true, -- Skornak
    [203646] = true, -- Dinn
    [203660] = true, -- Flowfy
    [203662] = true, -- Subterrax
    [203664] = true, -- Emberdusk
    [203834] = true, -- Contaminated Titan Watcher
    [203846] = true, -- Elder Magma Serpent
    [204093] = true, -- Colossian
    [204426] = true, -- Jalgon Stoutburn
    [205540] = true, -- Pahi'rys
}
