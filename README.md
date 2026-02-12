# don-lovegifts

1.ox_inventory\data\items.lua

    ['roseflower'] = {
        label = 'Rose Flower',
        weight = 115,
    },

    ['bigballoon'] = {
        label = 'Big Heart Balloon',
        weight = 115,
    },

    ['smallballoon'] = {
        label = 'Small Rainbow Balloon',
        weight = 115,
    },

    ['flowerbouque'] = {
        label = 'Flower Bouquet',
        weight = 115,
    },

    ['rosebouquet'] = {
        label = 'Big Heart Balloon',
        weight = 115,
    },

    ['lovecake'] = {
        label = 'Love Cake',
        weight = 115,
    },

    ['pourpleheart'] = {
        label = 'Purple Heart Prop',
        weight = 115,
    },

    ['teddybear'] = {
        label = 'Teddy Bear',
        weight = 115,
    },

2.ox_inventory\data\shops.lua

	GiftShop = {
		name = 'GiftShop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'roseflower', price = 10 },
			{ name = 'bigballoon', price = 10 },
			{ name = 'smallballoon', price = 10 },
			{ name = 'flowerbouquet', price = 10 },
			{ name = 'rosebouquet', price = 10 },
			{ name = 'lovecake', price = 10 },
			{ name = 'pourpleheart', price = 10 },
			{ name = 'teddybear', price = 10 },																		
		}, locations = {
			vec3(-1582.9, -234.65, 53.84),
		}, targets = {
			{ loc = vec3(-1582.9, -234.65, 53.84), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},
