mod_dir = ''..SMODS.current_mod.path

-- Kino_config = SMODS.current_mod.config
-- Kino.enabled = copy_table(Kino_config)

-- Read in all the sprites
SMODS.Atlas {
    key = "kino_atlas_1",
    px = 71,
    py = 95,
    path =  'kino_jokers_1.png'
}
SMODS.Atlas {
    key = "kino_atlas_2",
    px = 71,
    py = 95,
    path =  'kino_jokers_2.png'
}
SMODS.Atlas {
    key = "kino_atlas_3",
    px = 71,
    py = 95,
    path =  'kino_jokers_3.png'
}
SMODS.Atlas {
    key = "kino_atlas_4",
    px = 71,
    py = 95,
    path =  'kino_jokers_4.png'
}

SMODS.Atlas {
    key = 'modicon',
    px = 32,
    py = 32,
    path = 'modicon.png'
}

SMODS.Atlas {
    key = 'kino_tarot',
    px = 71,
    py = 95,
    path = 'kino_tarot.png'
}

SMODS.Atlas {
    key = 'kino_enhancements',
    px = 71,
    py = 95,
    path = 'kino_enhancements.png'
}

SMODS.Atlas {
    key = 'kino_boosters',
    px = 71,
    py = 95,
    path = 'kino_boosters.png'
}

SMODS.Atlas {
    key = 'kino_confections',
    px = 71,
    py = 95,
    path = 'kino_confections.png'
}



-- Load additional files
local helper, load_error = SMODS.load_file("Kinofunctions.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end



-- Add Mult Bonus (Code adapted from AutumnMood (https://github.com/AutumnMood924/AutumnMoodMechanics/blob/main/amm.lua))
local alias__Card_get_chip_mult = Card.get_chip_mult;
function Card:get_chip_mult()
    if self.debuff then return 0 end
    local ret = alias__Card_get_chip_mult(self) + (self.ability.perma_mult or 0)
	return ret
end

function is_genre(joker, genre)
    print("going to test this function now")
    if joker.config.center.k_genre then
        print("?:!")
        for i = 1, #joker.config.center.k_genre do
            if genre == joker.config.center.k_genre[i] then
                return true
            end
        end
    end
    return false
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other["card_extra_mult"] = {
		text = {
			"{C:mult}+#1#{} extra Mult"
		}
	}
end
-- End of adapted code

-- Add Kino mod specific game long globals
-- Scrap total
-- Matches Made
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    ret.current_round.sacrifices_made = 0
    -- generate_cmifc_rank()
    return ret
end

-- Register the Jokers
-- local files = NFS.getDirectoryItems(mod_dir .. "Items/Jokers")
-- for _, file in ipairs(files) do
--     print("Loading file: " .. file)
--     local status, err = pcall(function()
--         return NFS.load(mod_dir .. "/Items/Jokers/" .. file)()
--     end)
--     sendDebugMessage("Loaded Joker: " .. file, "--KINO")

--     local string = string.sub(file, 1, #file-4)
--     Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. string

--     if not status then
--         error(file .. ": " .. err)
--     end
-- end



-- Register the Jokers
local files = NFS.getDirectoryItems(mod_dir .. "Items/Jokers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Jokers/" .. file))()

    local string = string.sub(file, 1, #file-4)
    Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. string

end

-- Register the Enhancements
local files = NFS.getDirectoryItems(mod_dir .. "Items/Enhancements")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Enhancements/" .. file))()
end

-- Register the Consumable Types
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumable_types")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumable_types/" .. file))()
end


-- Register the Consumables
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumables")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumables/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(mod_dir .. "Items/Boosters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Boosters/" .. file))()
end

-- Register the genres
local helper, load_error = SMODS.load_file("Kinogenres.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

kino_genre_init()

