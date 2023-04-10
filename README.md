# NPCScan

NPCScan helps you find NPCs by scanning nameplates, minimap vignettes, and mouseover targets, with an optional dynamic targeting keybinding. Once an NPC is found by one of these methods, an on screen alert is displayed and an audio alert is played.

Translators needed - apply localizations [here](https://www.curseforge.com/wow/addons/npcscan/localization).

## Nameplates

Alerts will be triggered whenever a nameplate is created, if that nameplate belongs to one of the tracked NPCs. To use this feature with any reliability, the Interface->Names->Always Show Nameplates option must be turned on from the WoW Game Menu.

## Dynamic Target Keybinding

NPCScan includes a key binding that will trigger a dynamically-generated targeting macro. Each time it is pressed, the key binding will invoke a "/targetexact 'NPC name'" command for every tracked NPC in the current zone you are in, in addition to any custom NPC definitions. This only attempts a search each time it is triggered; it is not a continuous search.

To access this feature, just set a keybinding under the Key Bindings->AddOns->NPCScan->Targeting Macro section.

## “Found” Alert

When an NPC is found, NPCScan alerts you by playing a loud and distinctive sound, making your screen pulse red, and displaying a Targeting Button for every NPC that is found.

## Targeting Buttons

When clicked, the targeting button tries to target the NPC it depicts. You can also bind a key to trigger the newest button, in cases where multiple buttons are spawned.

Note: These buttons cannot be shown during combat. In the unlikely case that you do find a tracked NPC while fighting, the button or buttons will appear after you leave combat.

## Options

NPCScan's main options window can be accessed from the Interface Options menu. To access the NPC list and other settings, type “/npcscan”.

New sounds can be added to the alert sound dropdown menu by installing [SharedMedia](https://www.curseforge.com/wow/addons/sharedmedia).
