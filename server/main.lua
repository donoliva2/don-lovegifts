local QBCore = exports['qb-core']:GetCoreObject()

-- Register usable items
for itemName, _ in pairs(Config.ValentineItems) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        TriggerClientEvent('don-lovegifts:useItem', source, item.name)
    end)
end
