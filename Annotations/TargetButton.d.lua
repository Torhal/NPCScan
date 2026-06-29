---@meta _

--------------------------------------------------------------------------------
---- Types
--------------------------------------------------------------------------------

---@alias UnitClassification "elite" | "minus" | "normal" | "rare" | "rareelite" | "worldboss"

---@class AnimationGroupTexture: Texture
---@field animIn AnimationGroup

---@class FadeAnimationGroup: NamedAnimationGroup
---@field animOut Animation

---@class KilledTextureFrame: Frame
---@field animationGroup AnimationGroup
---@field left Texture
---@field right Texture

---@class NamedAnimationGroup: AnimationGroup
---@field name string

---@class TargetButton: AceEvent-3.0, Button, SecureActionButtonTemplate, SecureHandlerShowHideTemplate
---@field __isActive? boolean
---@field __classification UnitClassification | NPCClassification
---@field Background Texture
---@field Background2 Texture
---@field Background3 Texture
---@field Classification FontString
---@field DismissButton UIPanelCloseButtonNoScripts
---@field Particles1 Texture
---@field Particles2 Texture
---@field Particles3 Texture
---@field Portrait Texture
---@field PortraitModel PlayerModel
---@field PreAnimateIn? function
---@field RaidIcon Texture
---@field Ring1 Texture
---@field SourceText FontString
---@field SpecialText FontString
---@field Starglow Texture
---@field UnitName FontString
---@field animIn AnimationGroup
---@field dismissAnimationGroup NamedAnimationGroup
---@field durationFadeAnimationGroup FadeAnimationGroup
---@field glowTexture AnimationGroupTexture
---@field hiddenForCombat? boolean
---@field isDead? boolean
---@field killedBackgroundTexture AnimationGroupTexture
---@field killedTextureFrame KilledTextureFrame
---@field needsRaidTarget? boolean
---@field needsUnitData? boolean
---@field npcData? NPCData
---@field npcID! NPCID
---@field npcName? string
---@field pausedDismissal? boolean
---@field raidIconID! integer
---@field shineTexture AnimationGroupTexture
