local Translations = {

    client = {
        lang_1 = 'Trader Closed',
        lang_2 = 'come back after ',
        lang_3 = 'am',
        lang_4 = ' ( $',
        lang_5 = 'Sell ',
        lang_6 = 'Amount',
        lang_7 = 'Trading x',
        lang_8 = 'Issue Found',
        lang_9 = 'you don\'t have enough of that item to sell!',
        lang_10 = 'Open Trader Menu',
    },

    server = {
        lang_1 = 'Item Sold',
        lang_2 = 'your item sold for $',
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('client.lang_1')
-- Lang:t('server.lang_1')
