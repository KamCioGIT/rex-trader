local RSGCore = exports['rsg-core']:GetCoreObject()

---------------------------------------------
-- sell items to the trader
---------------------------------------------
RegisterNetEvent('rex-trader:server:sellitem', function(item, amount, price, money)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    totalvalue = (amount * price)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "remove")
    Player.Functions.AddMoney(money, totalvalue)
    TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, GetPlayerName(src) .. Config.Lang1 .. amount .. ' ' .. RSGCore.Shared.Items[item].label .. Config.Lang2 ..totalvalue, false)
    TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), description = Lang:t('server.lang_2')..totalvalue, type = 'success', duration = 7000 })
end)
