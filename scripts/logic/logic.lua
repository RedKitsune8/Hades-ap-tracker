-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:

function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function min(a,b)
    if a>b then return b
    else return a
    end        
end

function checkPacts(reference, check_count)
    local reqCount = Tracker:ProviderCountForCode(reference)
    local count = Tracker:ProviderCountForCode(check_count)

    if count >= reqCount then
        return 1
    else
        return 0
    end
end

function totalpacts()
    local total =
    tonumber(Tracker:ProviderCountForCode("ReqHardLaborPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqLastingConsequencesPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqConvenienceFeePactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqJurySummonsPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqExtremeMeasuresPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqCalisthenicsProgramPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqBenefitsPackagePactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqMiddleManagementPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqUnderworldCustomsPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqForcedOvertimePactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqHeightenedSecurityPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqRoutineInspectionPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqDamageControlPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqApprovalProcessPactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqTightDeadlinePactLevel")) +
    tonumber(Tracker:ProviderCountForCode("ReqPersonalLiabilityPactLevel"))
    return total        
end

function totalRoutinePact()
    local total = tonumber(Tracker:ProviderCountForCode("ReqRoutineInspectionPactLevel")) 
    return total        
end

function ObtainedPacts()
    local total =
        tonumber(Tracker:ProviderCountForCode("hard_labor_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("lasting_consequences_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("convenience_fee_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("jury_summons_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("extreme_measures_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("calisthenics_program_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("benefits_package_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("middle_management_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("underworld_customs_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("forced_overtime_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("heightened_security_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("routine_inspection_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("damage_control_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("approval_process_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("tight_deadline_pact_amount")) +
        tonumber(Tracker:ProviderCountForCode("personal_liability_pact_amount"))
    return total        
end

function ObtainedRoutinePact()
    local total = tonumber(Tracker:ProviderCountForCode("routine_inspection_pact_amount")) 
    return total        
end

function ObtainedWeapons()
    local total = 
    tonumber(Tracker:ProviderCountForCode("SwordWeaponUnlockItemtem")) +
    tonumber(Tracker:ProviderCountForCode("BowWeaponUnlockItem")) +
    tonumber(Tracker:ProviderCountForCode("SpearWeaponUnlockItem")) +
    tonumber(Tracker:ProviderCountForCode("ShieldWeaponUnlockItem")) +
    tonumber(Tracker:ProviderCountForCode("BowWeaponUnlockItem")) +
    tonumber(Tracker:ProviderCountForCode("FistWeaponUnlockItem")) + 
    tonumber(Tracker:ProviderCountForCode("GunWeaponUnlockItem"))
    return total        
end

function checkAsphodel()
    local weapons = ObtainedWeapons()
    local pacts = totalpacts()
    local routinetotal = totalRoutinePact()
    local countpacts = ObtainedPacts()
    local countroutine = ObtainedRoutinePact()
    local limit = min(totalpacts()/2, 20)
    if weapons > 2 and pacts >= limit  then
    Tracker:FindObjectForCode("RegionAsphodel").Active = true
    return  1
    end
end 

function checkElysium()
    local weapons = ObtainedWeapons()
    if weapons >= 5 then
    Tracker:FindObjectForCode("RegionAsphodel").Active = true
    return  1
    end
end 

function checkStyx()
    local weapons = ObtainedWeapons()
    if weapons == 6 then
    Tracker:FindObjectForCode("RegionAsphodel").Active = true
    return  1
    end
end

function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end