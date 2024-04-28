-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")

print("-- Example Tracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Custom Items
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlus.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlusWrapper.lua")

-- Items
Tracker:AddItems("items/Keepsakes.json")
Tracker:AddItems("items/Npcs.json")
Tracker:AddItems("items/Pacts.json")
Tracker:AddItems("items/Store.json")
Tracker:AddItems("items/TextsCounters.json")
Tracker:AddItems("items/Weapons.json")

if not IS_ITEMS_ONLY then -- <--- use variant info to optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.json")    
    -- Locations
    Tracker:AddLocations("locations/locations.json")
    Tracker:AddLocations("locations/Tartarus.json")
    Tracker:AddLocations("locations/Asphodel.json")
    Tracker:AddLocations("locations/Elysium.json")
    Tracker:AddLocations("locations/TempleStyx.json")
    Tracker:AddLocations("locations/Score.json")
    Tracker:AddLocations("locations/HouseContractor.json")
    Tracker:AddLocations("locations/Fates.json")
    Tracker:AddLocations("locations/LogicMap.json")
end

-- Layout
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
