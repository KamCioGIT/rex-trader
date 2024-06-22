local RSGCore = exports['rsg-core']:GetCoreObject()
local SpawnedTraderBilps = {}

---------------------------------------------
-- prompts and blips
---------------------------------------------
Citizen.CreateThread(function()
    for _,v in pairs(Config.TraderShops) do
        if v.showblip == true then
            local TraderBlip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(TraderBlip, joaat(v.blip.blipSprite), true)
            SetBlipScale(TraderBlip, v.blip.blipScale)
            SetBlipName(TraderBlip, v.blip.blipName)
            table.insert(SpawnedTraderBilps, TraderBlip)
        end
    end
end)

--------------------------------------
-- trader hours system
--------------------------------------
local OpenTraders = function(trader)
    if not Config.AlwaysOpen then
        local hour = GetClockHours()
        if (hour < Config.OpenTime) or (hour >= Config.CloseTime) and not Config.AlwaysOpen then
			lib.notify({
				title = Lang:t('client.lang_1'),
				description = Lang:t('client.lang_2')..Config.OpenTime..Lang:t('client.lang_3'),
				type = 'error',
				icon = 'fa-solid fa-shop',
				iconAnimation = 'shake',
				duration = 7000
			})
            return
        end
    end
    TriggerEvent('rex-trader:client:mainmenu', trader)
end

--------------------------------------
-- get trader hours function
--------------------------------------
local GetTraderHours = function()
    local hour = GetClockHours()
    if not Config.AlwaysOpen then
        if (hour < Config.OpenTime) or (hour >= Config.CloseTime) then
            for k, v in pairs(SpawnedTraderBilps) do
                BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_2'))
            end
        else
            for k, v in pairs(SpawnedTraderBilps) do
                BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_8'))
            end
        end
    else
        for k, v in pairs(SpawnedTraderBilps) do
            BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_8'))
        end
    end
end

--------------------------------------
-- get trader hours on player loading
--------------------------------------
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    GetTraderHours()
end)

---------------------------------
-- update trader hours every min
---------------------------------
CreateThread(function()
    while true do
        GetTraderHours()
        Wait(60000) -- every min
    end       
end)

AddEventHandler('rex-trader:client:opentrader', function(trader)
    OpenTraders(trader)
end)

---------------------------------------------
-- trader menu
---------------------------------------------
RegisterNetEvent('rex-trader:client:mainmenu')
AddEventHandler('rex-trader:client:mainmenu', function(trader)
    local options = {}
    for k,v in pairs(Config.TraderShops) do
        if v.trader == trader then
            for g,f in pairs(v.shopdata) do
               local itemimg = "nui://"..Config.Image..RSGCore.Shared.Items[tostring(f.item)].image  
                options[#options + 1] = {
                    title = f.title..Lang:t('client.lang_4')..f.price..' '..f.money..')',
                    icon = itemimg,
                    event = 'rex-trader:client:sellcount',
                    args = { item = f.item , money = f.money, price = f.price, label = f.title },
                    arrow = true,
                }
            end
        end
        lib.registerContext({
            id = 'trader_menu',
            title = getMenuTitle(trader),
            position = 'top-right',
            options = options
        })
        lib.showContext('trader_menu')        
    end
end)

---------------------------------------------
-- sell amount
---------------------------------------------
RegisterNetEvent('rex-trader:client:sellcount', function(data)

    local input = lib.inputDialog(Lang:t('client.lang_5')..data.label, {
        { 
            label = Lang:t('client.lang_6'),
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })
    
    if not input then
        return
    end
    
    local hasItem = RSGCore.Functions.HasItem(data.item, input[1])
    
    if hasItem then
        LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
        lib.progressBar({
            duration = Config.Selltime,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disableControl = true,
            disable = {
                move = true,
                mouse = true,
            },
            label = Lang:t('client.lang_7')..input[1]..' '..data.label,
        })
        TriggerServerEvent('rex-trader:server:sellitem', data.item, input[1], data.price, data.money)
        LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
    else
        lib.notify({ title = Lang:t('client.lang_8'), description = Lang:t('client.lang_9'), type = 'error', duration = 7000 })
    end
    
end)

function getMenuTitle(trader)
    for k,v in pairs(Config.TraderShops)  do
        if trader == v.trader then
            return v.tradername
        end
    end
end
