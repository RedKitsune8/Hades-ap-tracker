-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item in %s of type", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif v[2] == "reverseconsumable" then
                    obj.AcquiredCount = obj.MaxCount    
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- manually run snes interface functions after onClear in case we are already ingame
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here
    end
    print(dump_table(SLOT_DATA))
    -- We put the max values for the pacts
    if slot_data["hard_labor_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("HardLaborPactLevel").AcquiredCount = tonumber(slot_data["hard_labor_pact_amount"])
        Tracker:FindObjectForCode("ReqHardLaborPactLevel").AcquiredCount = tonumber(slot_data["hard_labor_pact_amount"])
    end
    if slot_data["lasting_consequences_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("LastingConsequencesPactLevel").AcquiredCount = tonumber(slot_data["lasting_consequences_pact_amount"])
        Tracker:FindObjectForCode("ReqLastingConsequencesPactLevel").AcquiredCount = tonumber(slot_data["lasting_consequences_pact_amount"])
    end
    if slot_data["convenience_fee_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("ConvenienceFeePactLevel").AcquiredCount = tonumber(slot_data["convenience_fee_pact_amount"])
        Tracker:FindObjectForCode("ReqConvenienceFeePactLevel").AcquiredCount = tonumber(slot_data["convenience_fee_pact_amount"])
    end
    if slot_data["jury_summons_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("JurySummonsPactLevel").AcquiredCount = tonumber(slot_data["jury_summons_pact_amount"])
        Tracker:FindObjectForCode("ReqJurySummonsPactLevel").AcquiredCount = tonumber(slot_data["jury_summons_pact_amount"])
    end
    if slot_data["extreme_measures_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("ExtremeMeasuresPactLevel").AcquiredCount = tonumber(slot_data["extreme_measures_pact_amount"])
        Tracker:FindObjectForCode("ReqExtremeMeasuresPactLevel").AcquiredCount = tonumber(slot_data["extreme_measures_pact_amount"])
    end
    if slot_data["calisthenics_program_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("CalisthenicsProgramPactLevel").AcquiredCount = tonumber(slot_data["calisthenics_program_pact_amount"])
        Tracker:FindObjectForCode("ReqCalisthenicsProgramPactLevel").AcquiredCount = tonumber(slot_data["calisthenics_program_pact_amount"])
    end
    if slot_data["benefits_package_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("BenefitsPackagePactLevel").AcquiredCount = tonumber(slot_data["benefits_package_pact_amount"])
        Tracker:FindObjectForCode("ReqBenefitsPackagePactLevel").AcquiredCount = tonumber(slot_data["benefits_package_pact_amount"])
    end
    if slot_data["middle_management_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("MiddleManagementPactLevel").AcquiredCount = tonumber(slot_data["middle_management_pact_amount"])
        Tracker:FindObjectForCode("ReqMiddleManagementPactLevel").AcquiredCount = tonumber(slot_data["middle_management_pact_amount"])
    end
    if slot_data["underworld_customs_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("UnderworldCustomsPactLevel").AcquiredCount = tonumber(slot_data["underworld_customs_pact_amount"])
        Tracker:FindObjectForCode("ReqUnderworldCustomsPactLevel").AcquiredCount = tonumber(slot_data["underworld_customs_pact_amount"])
    end
    if slot_data["forced_overtime_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("ForcedOvertimePactLevel").AcquiredCount = tonumber(slot_data["forced_overtime_pact_amount"])
        Tracker:FindObjectForCode("ReqForcedOvertimePactLevel").AcquiredCount = tonumber(slot_data["forced_overtime_pact_amount"])
    end
    if slot_data["heightened_security_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("HeightenedSecurityPactLevel").AcquiredCount = tonumber(slot_data["heightened_security_pact_amount"])
        Tracker:FindObjectForCode("ReqHeightenedSecurityPactLevel").AcquiredCount = tonumber(slot_data["heightened_security_pact_amount"])
    end
    if slot_data["routine_inspection_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("RoutineInspectionPactLevel").AcquiredCount = tonumber(slot_data["routine_inspection_pact_amount"])
        Tracker:FindObjectForCode("ReqRoutineInspectionPactLevel").AcquiredCount = tonumber(slot_data["routine_inspection_pact_amount"])
    end
    if slot_data["damage_control_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("DamageControlPactLevel").AcquiredCount = tonumber(slot_data["damage_control_pact_amount"])
        Tracker:FindObjectForCode("ReqDamageControlPactLevel").AcquiredCount = tonumber(slot_data["damage_control_pact_amount"])
    end
    if slot_data["approval_process_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("ApprovalProcessPactLevel").AcquiredCount = tonumber(slot_data["approval_process_pact_amount"])
        Tracker:FindObjectForCode("ReqApprovalProcessPactLevel").AcquiredCount = tonumber(slot_data["approval_process_pact_amount"])
    end
    if slot_data["tight_deadline_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("TightDeadlinePactLevel").AcquiredCount = tonumber(slot_data["tight_deadline_pact_amount"])
        Tracker:FindObjectForCode("ReqTightDeadlinePactLevel").AcquiredCount = tonumber(slot_data["tight_deadline_pact_amount"])
    end
    if slot_data["personal_liability_pact_amount"] ~= 0 then
        Tracker:FindObjectForCode("PersonalLiabilityPactLevel").AcquiredCount = tonumber(slot_data["personal_liability_pact_amount"])
        Tracker:FindObjectForCode("ReqPersonalLiabilityPactLevel").AcquiredCount = tonumber(slot_data["personal_liability_pact_amount"])
    end
    
    -- Initial Weapon
    if slot_data["initial_weapon"] == 0 then
        Tracker:FindObjectForCode("SwordWeaponUnlockItem").Active = true
    end
    if slot_data["initial_weapon"] == 1 then
        Tracker:FindObjectForCode("BowWeaponUnlockItem").Active = true
    end
    if slot_data["initial_weapon"] == 2 then
        Tracker:FindObjectForCode("SpearWeaponUnlockItem").Active = true
    end
    if slot_data["initial_weapon"] == 3 then
        Tracker:FindObjectForCode("ShieldWeaponUnlockItem").Active = true
    end
    if slot_data["initial_weapon"] == 4 then
        Tracker:FindObjectForCode("FistWeaponUnlockItem").Active = true
    end
    if slot_data["initial_weapon"] == 8 then
        Tracker:FindObjectForCode("GunWeaponUnlockItem").Active = true
    end    
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
        return
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount - obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
            if v[2] then
                obj = Tracker:FindObjectForCode(v[2])
                obj.AcquiredCount = obj.AcquiredCount + obj.Increment
            end
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
            item_player))
    end
    -- not implemented yet :(
end

-- called when a bounce message is received 
function onBounce(json)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onBounce: %s", dump_table(json)))
    end
    -- your code goes here
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)
