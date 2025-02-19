--- STEAMODDED HEADER
--- MOD_NAME: MarvelUniverseBalatroMod
--- MOD_ID: MarvelUniverseBalatroMod
--- MOD_AUTHOR: [ztgarrett]
--- MOD_DESCRIPTION: Marvel planet cards

--- PRIORITY: -100
--- BADGE_COLOR: ED1D24
--- DISPLAY_NAME: Marvel Universe
--- PREFIX: marvel
--- VERSION: 1.0.0
--- DEPENDENCIES: [malverk]


Malverk.badges.badge_space_station = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_space_station'), get_type_colour(self or card.config, card), nil, 1.2)
end

Malverk.badges.badge_realm = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_realm'), get_type_colour(self or card.config, card), nil, 1.2)
end

Malverk.badges.badge_universe = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_universe'), get_type_colour(self or card.config, card), nil, 1.2)
end

Malverk.badges.badge_plane = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_plane'), get_type_colour(self or card.config, card), nil, 1.2)
end

AltTexture{ -- Marvel Planets
    key = 'planets',
    set = 'Planet',
    path = 'marvel_universe.png',
    original_sheet = true,
    localization = true
}
AltTexture{ -- Marvel Boosters
    key = 'boosters',
    set = 'Booster',
    path = 'marvel_universe_boosters.png',
    keys = {
        'p_celestial_normal_1',
        'p_celestial_normal_2',
        'p_celestial_normal_3',
        'p_celestial_normal_4',
        'p_celestial_jumbo_1',
        'p_celestial_jumbo_2',
        'p_celestial_mega_1',
        'p_celestial_mega_2',
    },
    original_sheet = true
}
AltTexture{
    key = 'spectral',
    set = 'Spectral',
    path = 'marvel_universe.png',
    original_sheet = true,
    keys = {'c_black_hole'},
    localization = true
}
TexturePack{ -- Marvel Texture Pack
    key = 'marvel_universe',
    textures = {
        'marvel_spectral',
        'marvel_planets',
        'marvel_boosters',
    },
}