--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Boralus
--------------------------------------------------------------------------------
Maps[MapID.Boralus].NPCs = {
    [137983] = true, -- Rear Admiral Hainsworth
    [138039] = true, -- Dark Ranger Clea
    [139287] = true, -- Sawtooth
    [143559] = true, -- Grand Marshal Tremblade
    [143560] = true, -- Marshal Gabriel
    [145161] = true, -- Siege Engineer Krackleboom
}

--------------------------------------------------------------------------------
---- Drustvar
--------------------------------------------------------------------------------
Maps[MapID.Drustvar].NPCs = {
    [124548] = true, -- Betsy
    [125453] = true, -- Quillrat Matriarch
    [126621] = true, -- Bonesquall
    [127129] = true, -- Grozgore
    [127333] = true, -- Barbthorn Queen
    [127651] = true, -- Vicemaul
    [127844] = true, -- Gluttonous Yeti
    [127877] = true, -- Longfang
    [127901] = true, -- Henry Breakwater
    [128181] = true, -- Vengeful Dead
    [128707] = true, -- Rimestone
    [128973] = true, -- Whargarble the Ill-Tempered
    [129031] = true, -- Manifested Hate
    [129805] = true, -- Beshol
    [129835] = true, -- Gorehorn
    [129904] = true, -- Cottontail Matron
    [129950] = true, -- Talon
    [129995] = true, -- Emily Mayville
    [130138] = true, -- Nevermore
    [130143] = true, -- Balethorn
    [131735] = true, -- Idej the Wise
    [132319] = true, -- Bilefang Mother
    [134213] = true, -- Executioner Blackwell
    [134706] = true, -- Deathcap
    [134754] = true, -- Hyo'gi
    [135796] = true, -- Captain Leadfist
    [137529] = true, -- Arvon the Betrayed
    [137665] = true, -- Soul Goliath
    [137704] = true, -- Matron Morana
    [137708] = true, -- Stone Golem
    [137824] = true, -- Arclight
    [137825] = true, -- Avalanche
    [138618] = true, -- Haywire Golem
    [138667] = true, -- Blighted Monstrosity
    [138675] = true, -- Gorged Boar
    [138863] = true, -- Sister Martha
    [138866] = true, -- Mack
    [138870] = true, -- Mick
    [138871] = true, -- Ernie
    [139321] = true, -- Braedan Whitewall
    [139322] = true, -- Whitney "Steelclaw" Ramsay
    [139358] = true, -- The Caterer
    [140252] = true, -- Hailstone Construct
    [144855] = true, -- Apothecary Jerrod
    [145465] = true, -- Engineer Bolthold
    [145466] = true, -- Shredatron-2000
    [146607] = true, -- Omgar Doombow
    [148146] = true, -- Zul'aki the Headhunter
    [148155] = true, -- Muk'luk
    [148563] = true, -- Duchess Fallensong the Frigid
    [148648] = true, -- Packmaster Swiftarrow
    [148676] = true, -- Caravan Commander Veronica
    [148695] = true, -- Doctor Lazane
    [148717] = true, -- Inquisitor Erik
    [148723] = true, -- Maddok the Sniper
    [148739] = true, -- Magister Crystalynn
    [148860] = true, -- Grizzwald
    [148862] = true, -- Zillie Wunderwrench
}

--------------------------------------------------------------------------------
---- Mechagon Island
--------------------------------------------------------------------------------
Maps[MapID.MechagonIsland].NPCs = {
    [149746] = true, -- Rusty Mechaspider
    [149847] = true, -- Crazed Trogg
    [150342] = true, -- Earthbreaker Gulroc
    [150394] = true, -- Armored Vaultbot
    [150575] = true, -- Rumblerocks
    [150786] = true, -- Mechanized Crawler
    [150937] = true, -- Seaspit
    [151124] = true, -- Mechagonian Nullifier
    [151202] = true, -- Foul Manifestation
    [151296] = true, -- OOX-Avenger/MG
    [151308] = true, -- Boggac Skullbash
    [151569] = true, -- Deepwater Maw
    [151623] = true, -- The Scrap King
    [151625] = true, -- The Scrap King
    [151627] = true, -- Mr. Fixthis
    [151672] = true, -- Mecharantula
    [151684] = true, -- Jawbreaker
    [151702] = true, -- Paol Pondwader
    [151884] = true, -- Fungarian Furor
    [151933] = true, -- Malfunctioning Beastbot
    [151934] = true, -- Arachnoid Harvester
    [151940] = true, -- Uncle T'Rogg
    [152001] = true, -- Bonepicker
    [152007] = true, -- Killsaw
    [152113] = true, -- The Kleptoboss
    [152182] = true, -- Rustfeather
    [152569] = true, -- Crazed Trogg
    [152570] = true, -- Crazed Trogg
    [152764] = true, -- Oxidized Leachbeast
    [152922] = true, -- Data Anomaly
    [152923] = true, -- Data Anomaly
    [152958] = true, -- Data Anomaly
    [152961] = true, -- Data Anomaly
    [152979] = true, -- Data Anomaly
    [152983] = true, -- Data Anomaly
    [153000] = true, -- Sparkqueen P'Emp
    [153088] = true, -- Shiny Mechaspider
    [153200] = true, -- Boilburn
    [153205] = true, -- Gemicide
    [153206] = true, -- Ol' Big Tusk
    [153226] = true, -- Steel Singer Freza
    [153228] = true, -- Gear Checker Cogstar
    [153486] = true, -- Data Anomaly
    [154153] = true, -- Enforcer KX-T57
    [154225] = true, -- The Rusty Prince
    [154342] = true, -- Arachnoid Harvester
    [154701] = true, -- Gorged Gear-Cruncher
    [154739] = true, -- Caustic Mechaslime
    [154968] = true, -- Armored Vaultbot
    [155060] = true, -- Doppel Ganger
    [155583] = true, -- Scrapclaw
}

--------------------------------------------------------------------------------
---- Stormsong Valley
--------------------------------------------------------------------------------
Maps[MapID.StormsongValley].NPCs = {
    [129803] = true, -- Whiplash
    [129836] = true, -- Spelltwister Moephus
    [130079] = true, -- Wagga Snarltusk
    [130897] = true, -- Captain Razorspine
    [131404] = true, -- Foreman Scripps
    [132007] = true, -- Galestorm
    [132047] = true, -- Reinforced Hullbreaker
    [134147] = true, -- Beehemoth
    [134884] = true, -- Ragna
    [134897] = true, -- Dagrus the Scorned
    [135939] = true, -- Vinespeaker Ratha
    [135947] = true, -- Strange Mushroom Ring
    [136183] = true, -- Crushtacean
    [136189] = true, -- The Lichen King
    [137025] = true, -- Broodmother
    [137649] = true, -- Pest Remover Mk. II
    [138938] = true, -- Seabreaker Skoloth
    [138963] = true, -- Nestmother Acada
    [139298] = true, -- Pinku'shon
    [139319] = true, -- Slickspill
    [139328] = true, -- Sabertron (Red Sabertron)
    [139335] = true, -- Sabertron (Yellow Sabertron)
    [139336] = true, -- Sabertron (Green Sabertron)
    [139356] = true, -- Sabertron (Orange Sabertron)
    [139359] = true, -- Sabertron (Copper Sabertron)
    [139385] = true, -- Deepfang
    [139968] = true, -- Corrupted Tideskipper
    [139980] = true, -- Taja the Tidehowler
    [139988] = true, -- Sandfang
    [140163] = true, -- Warbringer Yenajz
    [140398] = true, -- Zeritarj
    [140474] = true, -- Adherent of the Abyss
    [140925] = true, -- Doc Marrtens
    [140938] = true, -- Croaker
    [140997] = true, -- Severus the Outcast
    [141029] = true, -- Kickers
    [141039] = true, -- Ice Sickle
    [141043] = true, -- Jakala the Cruel
    [141059] = true, -- Grimscowl the Harebrained
    [141088] = true, -- Squall
    [141143] = true, -- Sister Absinthe
    [141175] = true, -- Song Mistress Dadalea
    [141226] = true, -- Haegol the Hammer
    [141239] = true, -- Osca the Bloodied
    [141286] = true, -- Poacher Zane
    [142088] = true, -- Whirlwing
    [144915] = true, -- Firewarden Viton Darkflare
    [144987] = true, -- Shadow Hunter Mutumba
    [144997] = true, -- Gurin Stonebinder
    [145020] = true, -- Dolizite
    [145278] = true, -- Dinomancer Zakuru
    [145415] = true, -- Cap'n Gorok
    [147562] = true, -- Mortar Master Zapfritz
    [147923] = true, -- Knight-Captain Joesiph
    [147941] = true, -- Tidesage Clarissa
    [147951] = true, -- Alkalinius
    [147998] = true, -- Voidmaster Evenshade
    [148044] = true, -- Owynn Graddock
    [148075] = true, -- Beast Tamer Watkins
    [148092] = true, -- Nalaess Featherseeker
    [154154] = true, -- Honey Smasher
    [155055] = true, -- Gurg the Hivethief
    [155059] = true, -- Yorag the Jelly Feaster
    [155069] = true, -- Honeyback Harvester
    [155171] = true, -- The Hivekiller
    [155172] = true, -- Trapdoor Bee Hunter
    [155173] = true, -- Honeyback Usurper
    [155176] = true, -- Old Nasha
}

--------------------------------------------------------------------------------
---- Tiragarde Sound
--------------------------------------------------------------------------------
Maps[MapID.TiragardeSound].NPCs = {
    [127289] = true, -- Saurolisk Tamer Mugg
    [127290] = true, -- Mugg
    [129181] = true, -- Barman Bill
    [130508] = true, -- Broodmother Razora
    [131252] = true, -- Merianae
    [131262] = true, -- Pack Leader Asenya
    [131389] = true, -- Teres
    [131520] = true, -- Kulett the Ornery
    [131984] = true, -- Twin-hearted Construct
    [132052] = true, -- Vol'Jim
    [132068] = true, -- Bashmu
    [132076] = true, -- Totes
    [132086] = true, -- Black-Eyed Bart
    [132088] = true, -- Captain Wintersail
    [132127] = true, -- Foxhollow Skyterror
    [132179] = true, -- Raging Swell
    [132182] = true, -- Auditor Dolp
    [132211] = true, -- Fowlmouth
    [132280] = true, -- Squacks
    [133356] = true, -- Tempestria
    [134106] = true, -- Lumbergrasp Sentinel
    [136385] = true, -- Azurethos
    [137183] = true, -- Honey-Coated Slitherer
    [138279] = true, -- Adhara White
    [138288] = true, -- Ghost of the Deep
    [138299] = true, -- Bloodmaw
    [139135] = true, -- Squirgle of the Depths
    [139145] = true, -- Blackthorne
    [139152] = true, -- Carla Smirk
    [139205] = true, -- P4-N73R4
    [139233] = true, -- Gulliver
    [139235] = true, -- Tort Jaw
    [139278] = true, -- Ranja
    [139280] = true, -- Sythian the Swift
    [139285] = true, -- Shiverscale the Toxic
    [139289] = true, -- Tentulos the Drifter
    [139290] = true, -- Maison the Portable
    [144722] = true, -- Togoth Cruelarm
    [145112] = true, -- Zagg Brokeneye
    [145286] = true, -- Motega Bloodshield
    [145287] = true, -- Zunjo of Sen'jin
    [145292] = true, -- Alsian Vistreth
    [145308] = true, -- First Sergeant Steelfang
    [145392] = true, -- Ambassador Gaines
    [145395] = true, -- Katrianna
    [146611] = true, -- Strong Arm John
    [146651] = true, -- Mistweaver Nian
    [146675] = true, -- Hartford Sternbach
    [146773] = true, -- First Mate Malone
    [147061] = true, -- Grubb
    [147489] = true, -- Captain Greensails
    [147750] = true, -- Artillery Master Goodwin
}
