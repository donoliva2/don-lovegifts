local QBCore = exports['qb-core']:GetCoreObject()

-- Variables to track animation and prop state
local isAnimPlaying = false
local attachedProp = nil

-- Function to load animation dictionary
local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

-- Function to load model
local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

-- Function to play animation and attach prop
local function playAnimation(itemName)
    local itemData = Config.ValentineItems[itemName]
    if not itemData then return end

    -- Load animation dictionary and model
    loadAnimDict(itemData.animDict)
    loadModel(itemData.prop)

    -- Attach prop to player
    local playerPed = PlayerPedId()
    attachedProp = CreateObject(itemData.prop, 0, 0, 0, true, true, true)
    AttachEntityToEntity(attachedProp, playerPed, GetPedBoneIndex(playerPed, itemData.propBone),
        itemData.propPlacement[1], itemData.propPlacement[2], itemData.propPlacement[3],
        itemData.propPlacement[4], itemData.propPlacement[5], itemData.propPlacement[6], true, true, false, true, 1, true)

    -- Play animation in a loop
    isAnimPlaying = true
    CreateThread(function()
        while isAnimPlaying do
            if not IsEntityPlayingAnim(playerPed, itemData.animDict, itemData.animName, 3) then
                TaskPlayAnim(playerPed, itemData.animDict, itemData.animName, 8.0, -8.0, -1, 49, 0, false, false, false)
            end

            -- Disable combat actions
            DisableControlAction(0, 24, true)    -- Disable attack (left-click)
            DisableControlAction(0, 25, true)    -- Disable aim (right-click)
            DisableControlAction(0, 45, true)    -- Disable reload (R key)
            DisableControlAction(0, 140, true)   -- Disable melee attack (R key)
            DisableControlAction(0, 257, true)   -- Disable melee attack (left-click)
            DisableControlAction(0, 263, true)   -- Disable melee attack (left-click)
            DisableControlAction(0, 264, true)   -- Disable melee attack (right-click)
            DisableControlAction(0, 142, true)   -- Disable melee attack (left-click)
            DisableControlAction(0, 143, true)   -- Disable melee attack (right-click)
            DisablePlayerFiring(playerPed, true) -- Disable firing weapons

            Wait(0)
        end
    end)
end

-- Function to stop animation and cleanup prop
local function stopAnimation()
    if isAnimPlaying then
        isAnimPlaying = false
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        if DoesEntityExist(attachedProp) then
            DeleteObject(attachedProp)
            attachedProp = nil
        end
    end
end

-- Event to trigger animation when using an item
RegisterNetEvent('don-lovegifts:useItem')
AddEventHandler('don-lovegifts:useItem', function(itemName)
    stopAnimation() -- Stop any existing animation
    playAnimation(itemName) -- Start new animation
end)

-- Key press to stop animation (X key)
CreateThread(function()
    while true do
        if isAnimPlaying then
            if IsControlJustPressed(0, 73) then -- 73 is the control ID for the X key
                stopAnimation()
            end
        end
        Wait(0)
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        stopAnimation()
    end
end)
