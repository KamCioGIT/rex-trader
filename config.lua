Config = {}

---------------------------------
-- settings
---------------------------------
Config.Keybind = 'J'
Config.Selltime = 10000

---------------------------------
-- webhook settings
---------------------------------
Config.WebhookName = 'rextrader'
Config.WebhookTitle = 'Rex Trader'
Config.WebhookColour = 'default'
Config.Lang1 = ' sold x'
Config.Lang2 = ' for $'

---------------------------------
-- openting hours
---------------------------------
Config.AlwaysOpen = true -- if false configure the open/close times
Config.OpenTime = 8 -- store opens
Config.CloseTime = 20 -- store closes

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn = true

---------------------------------
-- inventory image path
---------------------------------
Config.Image = 'rsg-inventory/html/images/'

---------------------------------
-- trader shops
---------------------------------
Config.TraderShops = {
    
    {   -- emerald trader
        trader = 'emerald-trader',
        promptname = 'Open Trader',
        tradername = 'Emerald Ranch Trader',
        coords = vector3(1440.85, 355.17, 88.55),
        npcmodel = `mp_u_m_m_trader_01`,
        npccoords = vector4(1440.85, 355.17, 88.55, 102.52),
        blip = {
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = 'Emerald Ranch Trader',
        },
        showblip = true,
        shopdata = {
            {
                title = 'Bread',
                description = 'sell bread',
                price = 0.03,
				money = 'cash',
                item = 'bread',
                image = 'bread.png'
            },
        },
    },

    {   -- blade trader
        trader = 'blade-trader',
        promptname = 'Open Trader',
        tradername = 'Blade Trader',
        coords = vector3(1867.72, -1855.26, 43.02),
        npcmodel = `mp_u_m_m_trader_01`,
        npccoords = vector4(1867.72, -1855.26, 43.02, 316.02),
        blip = {
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = 'Blade Trader',
        },
        showblip = true,
        shopdata = {
            {
                title = 'Moonshine',
                description = 'sell moonshine to trader',
                price = 4.00,
				money = 'bloodmoney',
                item = 'moonshine',
                image = 'moonshine.png'
            },
        },
    },
	
    {   -- little creek trader
        trader = 'littlecreek-trader',
        promptname = 'Open Trader',
        tradername = 'Little Creek Trader',
        coords = vector3(-2198.98, 717.52, 122.42),
        npcmodel = `mp_u_m_m_trader_01`,
        npccoords = vector4(-2198.98, 717.52, 122.42, 106.63),
        blip = {
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = 'Little Creek Trader',
        },
        showblip = true,
        shopdata = {
            {
                title = 'Gold Bar',
                description = 'sell gold bar to trader',
                price = 75.00,
				money = 'cash',
                item = 'goldbar',
                image = 'goldbar.png'
            },
        },
    },

}
