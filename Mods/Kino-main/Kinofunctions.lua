-- Support Functions Needed:
-- 1. Create a tooltip for the genre
-- 2. Create a tooltip for the director
-- 3a. make jokers be able to check their cast, and compare.
-- 3b. start displaying cast members over the corresponding jokers if they're present in at least 3 owned jokers.

-- Is genre

-- Genre tooltip

-- Is director

-- Is cast

-- Director tooltip

-- Get Random hand type (Based on the neutronstarrandomhand function from Cryptid. (Planets.lua - line 830 - 853))
function get_random_hand()
    local rand_hand
    while true do
        rand_hand = pseudorandom_element(G.handlist, pseudoseed("random"))
        if G.GAME.hands[rand_hand].visible then
            break
        end
    end

    return rand_hand
end

-- Add a function to trigger jokers when money is spend in the shop (Based on cryptid, exotic.lua, l. 1407-1413)
local base_ease_dollars = ease_dollars
function ease_dollars(mod, x)
    base_ease_dollars(mod, x)

    for i = 1, #G.jokers.cards do 
        local effects = G.jokers.cards[i]:calculate_joker({kino_ease_dollars = mod})
    end
    
end

-- Add a function to randomize suits for jokers that need that (added to the ancient card functionality)
local rac = reset_ancient_card
function reset_ancient_card()
    rac()
    if not G.GAME.current_round.kino_thing_card then
        G.GAME.current_round.kino_thing_card = { suit = "Spades" }
    end

    local thing_suits = {}
    for k, v in ipairs({'Spades','Hearts','Clubs','Diamonds'}) do
        if v ~= G.GAME.current_round.kino_thing_card.suit then thing_suits[#thing_suits + 1] = v end
    end
    local thing_card = pseudorandom_element(thing_suits, pseudoseed('thing'..G.GAME.round_resets.ante))
    G.GAME.current_round.kino_thing_card.suit = thing_card

    print("This is the thing card = " .. G.GAME.current_round.kino_thing_card.suit)
end

-- Catch me if you can, select random rank
function generate_cmifc_rank()
    if not G.GAME.current_round.kino_cmifc_rank then
        G.GAME.current_round.kino_cmifc_rank = 2
    end

    local ranks = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
    G.GAME.current_round.kino_cmifc_rank = pseudorandom_element(ranks, "cmifc")
end

---- Add Scrap functionality
function update_scrap(num, is_set)
    -- num is the number to increment or set the scrap by
    -- is_set == true will set instead of increment
    print("UPDATING SCRAP || " .. num)
    if not G.GAME.current_round.scrap_total then
        G.GAME.current_round.scrap_total = 0
        print("No scrap_total found, setting it to 0")
    end

    if is_set then
        G.GAME.current_round.scrap_total = num
        print("is set was true. Setting to " .. num)
    else
        G.GAME.current_round.scrap_total = G.GAME.current_round.scrap_total + num
        print("added " .. num .. ". Total is now " .. G.GAME.current_round.scrap_total)
    end
end

-- Booster:Set_cost hook for oceans_11	
local b_sc = Card.set_cost
function Card:set_cost()
    b_sc(self)
    if self.ability.set == "Booster" and next(find_joker('j_kino_oceans_11')) then
        self.cost = 0
    end
end

----------------------
-- COLOURS --
local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = HEX("0a4a59")
    G.ARGS.LOC_COLOURS["Animation"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Comedy"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Christmas"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Crime"] = HEX("6a4c47") 
    G.ARGS.LOC_COLOURS["Drama"] = HEX("694c77")
    G.ARGS.LOC_COLOURS["Family"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Fantasy"] = HEX("087ad9")
    G.ARGS.LOC_COLOURS["Gangster"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Heist"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Historical"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Horror"] = HEX("372a2d")
    G.ARGS.LOC_COLOURS["Musical"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Romance"] = HEX("c8117d") 
    G.ARGS.LOC_COLOURS["Sci-fi"] = HEX("1eddd4")
    G.ARGS.LOC_COLOURS["Silent"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Sports"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Superhero"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Thriller"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["War"] = HEX("0086a5") -- No color picked yet
    G.ARGS.LOC_COLOURS["Western"] = HEX("0086a5") -- No color picked yet

    return genrecolors(_c, _default)
end