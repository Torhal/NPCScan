--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Azj-Kahet (2255)
--------------------------------------------------------------------------------

Maps[MapID.AzjKahet].NPCs = {
    [214151] = true, -- Ahg'zagall
    [216031] = true, -- Abyssal Devourer
    [216032] = true, -- Khak'ik
    [216034] = true, -- XT-Minecrusher 8700
    [216037] = true, -- Vilewing
    [216038] = true, -- The Groundskeeper
    [216039] = true, -- Xishorr
    [216041] = true, -- Webspeaker Grik'ik
    [216042] = true, -- Cha'tak
    [216043] = true, -- Monstrous Lasharoth
    [216044] = true, -- Maddened Siegebomber
    [216045] = true, -- Enduring Gutterface
    [216046] = true, -- Tka'ktath
    [216047] = true, -- The One Left
    [216048] = true, -- Jix'ak the Crazed
    [216049] = true, -- The Oozekhan
    [216050] = true, -- Harvester Qixt
    [216051] = true, -- Umbraclaw Matra
    [216052] = true, -- Skirmisher Sa'zryk
    [221067] = true, -- Orta
    [221327] = true, -- Kaheti Silk Hauler
    [222624] = true, -- Deepcrawler Tx'kesh
    [226232] = true, -- Elusive Razormouth Steelhide
}

--------------------------------------------------------------------------------
---- Azj-Kahet - Lower (2256)
--------------------------------------------------------------------------------

Maps[MapID.AzjKahetLower].NPCs = {
    [214151] = true, -- Ahg'zagall
    [216031] = true, -- Abyssal Devourer
    [216032] = true, -- Khak'ik
    [216034] = true, -- XT-Minecrusher 8700
    [216037] = true, -- Vilewing
    [216038] = true, -- The Groundskeeper
    [216039] = true, -- Xishorr
    [216041] = true, -- Webspeaker Grik'ik
    [216042] = true, -- Cha'tak
    [216043] = true, -- Monstrous Lasharoth
    [216044] = true, -- Maddened Siegebomber
    [216045] = true, -- Enduring Gutterface
    [216046] = true, -- Tka'ktath
    [216047] = true, -- The One Left
    [216048] = true, -- Jix'ak the Crazed
    [216049] = true, -- The Oozekhan
    [216050] = true, -- Harvester Qixt
    [216051] = true, -- Umbraclaw Matra
    [216052] = true, -- Skirmisher Sa'zryk
    [221067] = true, -- Orta
    [221327] = true, -- Kaheti Silk Hauler
    [222624] = true, -- Deepcrawler Tx'kesh
    [226232] = true, -- Elusive Razormouth Steelhide
}

--------------------------------------------------------------------------------
---- City of Threads (2213)
--------------------------------------------------------------------------------

Maps[MapID.CityOfThreads].NPCs = {
    [216038] = true, -- The Groundskeeper
    [216039] = true, -- Xishorr
    [221067] = true, -- Orta
}

--------------------------------------------------------------------------------
---- City of Threads - Lower (2216)
--------------------------------------------------------------------------------

Maps[MapID.CityOfThreadsLower].NPCs = {
    [216038] = true, -- The Groundskeeper
    [216039] = true, -- Xishorr
    [221067] = true, -- Orta
}

--------------------------------------------------------------------------------
---- Hallowfall (2215)
--------------------------------------------------------------------------------

Maps[MapID.Hallowfall].NPCs = {
    [206184] = true, -- Deathpetal
    [206203] = true, -- Moth'ethk
    [206514] = true, -- Crazed Cabbage Smacker
    [206977] = true, -- Parasidious
    [207780] = true, -- Finclaw Bloodtide
    [207802] = true, -- Beledar's Spawn
    [207803] = true, -- Toadstomper
    [207826] = true, -- Ravageant
    [214757] = true, -- Croakit
    [215805] = true, -- Sloshmuck
    [218426] = true, -- Ixlorb the Spinner
    [218444] = true, -- The Taskmaker
    [218452] = true, -- Murkshade
    [218458] = true, -- Deepfiend Azellix
    [220771] = true, -- Murkspike
    [221179] = true, -- Duskshadow
    [221224] = true, -- Shurrai
    [221534] = true, -- Lytfang the Lost
    [221551] = true, -- Grimslice
    [221648] = true, -- The Perchfather
    [221668] = true, -- Horror of the Shallows
    [221690] = true, -- Strength of Beledar
    [221708] = true, -- Sir Alastair Purefire
    [221753] = true, -- Deathtide
    [221767] = true, -- Funglour
    [221786] = true, -- Pride of Beledar
}

--------------------------------------------------------------------------------
---- Isle of Dorn (2248)
--------------------------------------------------------------------------------

Maps[MapID.IsleOfDorn].NPCs = {
    [213115] = true, -- Rustul Titancap
    [217534] = true, -- Sandres the Relicbearer
    [219262] = true, -- Springbubble
    [219263] = true, -- Warphorn
    [219264] = true, -- Bloodmaw
    [219265] = true, -- Emperor Pitfang
    [219266] = true, -- Escaped Cutthroat
    [219267] = true, -- Plaguehart
    [219268] = true, -- Gar'loc
    [219269] = true, -- Tempest Lord Incarnus
    [219270] = true, -- Kronolith, Might of the Mountain
    [219271] = true, -- Twice-Stinger the Wretched
    [219278] = true, -- Shallowshell the Clacker
    [219279] = true, -- Flamekeeper Graz
    [219281] = true, -- Alunira
    [219284] = true, -- Zovex
    [220068] = true, -- Malfunctioning Spire
    [220883] = true, -- Sweetspark the Oozeful
    [220890] = true, -- Matriarch Charfuria
    [221126] = true, -- Tephratennae
    [221128] = true, -- Clawbreaker K'zithix
    [222378] = true, -- Kereke
    [222380] = true, -- Rotfist
    [224515] = true, -- Elusive Ironhide Maelstrom Wolf
    [229334] = true, -- Kordac
}

--------------------------------------------------------------------------------
---- K'aresh (2371)
--------------------------------------------------------------------------------

Maps[MapID.Karesh].NPCs = {
    [231229] = true, -- Korgoth the Hungerer
    [231981] = true, -- Maw of the Sands
    [232006] = true, -- Sha'ryth the Cursed
    [232077] = true, -- Korgorath the Ravager
    [232098] = true, -- "Chowdar"
    [232108] = true, -- Morgil the Netherspawn
    [232111] = true, -- The Nightreaver
    [232127] = true, -- Orith the Dreadful
    [232128] = true, -- Ixthar the Unblinking
    [232129] = true, -- Shadowhowl
    [232182] = true, -- Prototype Mk-V
    [232189] = true, -- Revenant of the Wasteland
    [232193] = true, -- Stalker of the Wastes
    [232195] = true, -- Urmag
    [232199] = true, -- Xarran the Binder
    [234845] = true, -- Sthaarbs
    [234970] = true, -- Miasmawrath
    [235087] = true, -- The Harvester
    [235104] = true, -- The Wallbreaker
    [238319] = true, -- Reshanor
    [238384] = true, -- Xy'vox the Twisted
    [238540] = true, -- Grubber
    [241920] = true, -- Purple Peat
    [241956] = true, -- Arcana-Monger So'zer
    [245997] = true, -- Malek'ta
    [245998] = true, -- Heka'tamos
}

--------------------------------------------------------------------------------
---- Siren Isle (2369)
--------------------------------------------------------------------------------

Maps[MapID.SirenIsle].NPCs = {
    [227545] = true, -- Ikir the Flotsurge
    [228151] = true, -- Wreckwater
    [228154] = true, -- Bloodbrine
    [228155] = true, -- Grimgull
    [228201] = true, -- Gravesludge
    [228547] = true, -- Slaughtershell
    [228580] = true, -- Plank-Master Bluebelly
    [228583] = true, -- Chef Chum Platter
    [228601] = true, -- Ghostmaker
    [229852] = true, -- Coralweaver Calliso
    [229853] = true, -- Siris the Sea Scorpion
    [229982] = true, -- Nerathor
    [229992] = true, -- Stalagnarok
    [230137] = true, -- Asbjorn the Bloodsoaked
    [231090] = true, -- Snacker
    [231353] = true, -- Tempest Talon
    [231356] = true, -- Brinebough
    [231357] = true, -- Zek'ul the Shipbreaker
}

--------------------------------------------------------------------------------
---- Tazavesh (2472)
--------------------------------------------------------------------------------

Maps[MapID.Tazavesh].NPCs = {
    [232098] = true, -- "Chowdar"
    [235104] = true, -- The Wallbreaker
    [238384] = true, -- Xy'vox the Twisted
    [238540] = true, -- Grubber
    [241956] = true, -- Arcana-Monger So'zer
}

--------------------------------------------------------------------------------
---- The Forgotten Vault (2375)
--------------------------------------------------------------------------------

Maps[MapID.TheForgottenVault].NPCs = {
    [227550] = true, -- Shardsong
    [228159] = true, -- Gunnlod the Sea-Drinker
    [231368] = true, -- Ksvir the Forgotten
}

--------------------------------------------------------------------------------
---- The Ringing Deeps (2214)
--------------------------------------------------------------------------------

Maps[MapID.TheRingingDeeps].NPCs = {
    [218393] = true, -- Disturbed Earthgorger
    [220265] = true, -- Automaxor
    [220266] = true, -- Coalesced Monstrosity
    [220267] = true, -- Charmonger
    [220268] = true, -- Trungal
    [220269] = true, -- Cragmund
    [220270] = true, -- Zilthara
    [220271] = true, -- Terror of the Forge
    [220272] = true, -- Deathbound Husk
    [220273] = true, -- Rampaging Blight
    [220274] = true, -- Aquellion
    [220275] = true, -- King Splash
    [220276] = true, -- Candleflyer Captain
    [220285] = true, -- Lurker of the Deeps
    [220286] = true, -- Deepflayer Broodmother
    [220287] = true, -- Kelpmire
    [220999] = true, -- Aggregation of Horrors
    [221199] = true, -- Hungerer of the Deeps
    [221217] = true, -- Spore-Infused Shalewing
    [228439] = true, -- Slatefang
}

--------------------------------------------------------------------------------
---- Undermine (2346)
--------------------------------------------------------------------------------

Maps[MapID.Undermine].NPCs = {
    [230746] = true, -- Ephemeral Agent Lathyd
    [230793] = true, -- The Junk-Wall
    [230800] = true, -- Slugger the Smart
    [230828] = true, -- Chief Foreman Gutso
    [230840] = true, -- Flyboy Snooty
    [230931] = true, -- Scrapbeak
    [230934] = true, -- Ratspit
    [230940] = true, -- Tally Doublespeak
    [230946] = true, -- V.V. Goosworth
    [230947] = true, -- Slimesby
    [230951] = true, -- Thwack
    [230979] = true, -- S.A.L.
    [230995] = true, -- Nitro
    [231012] = true, -- Candy Stickemup
    [231017] = true, -- Grimewick
    [231288] = true, -- Swigs Farsight
    [231310] = true, -- Darkfuse Precipitant
    [231821] = true, -- The Gobfather
    [233471] = true, -- Scrapchewer
    [233472] = true, -- Voltstrike the Charged
    [234480] = true, -- M.A.G.N.O.
    [234499] = true, -- Giovante
    [234621] = true, -- Gallagio Garbage
}
