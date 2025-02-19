function kino_genre_init()

-- Iterate over all the jokers, and put them in the correct genre bundle

-- Dynamically create the objects?
-- Genres are identical to each other, other in key and name
kino_genres = {
    "Action",
    "Animation",
    "Comedy",
    "Christmas",
    "Crime",
    "Drama",
    "Family",
    "Fantasy",
    "Gangster",
    "Heist",
    "Historical",
    "Horror",
    "Musical",
    "Romance",
    "Sci-fi",
    "Silent",
    "Sports",
    "Superhero",
    "Thriller",
    "War",
    "Western"
}

-- Creates an object for each genre
for i, genre in ipairs(kino_genres) do
    local genre_config = {
        key = genre,
        default = "j_jimbo",
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            for i, v in ipairs(Kino.jokers) do
                print(v)
                if SMODS.Centers[v].k_genre then
                    for j, genre_in_list in ipairs(SMODS.Centers[v].k_genre) do
                        if genre_in_list == genre then
                            self.cards[v] = true
                        end
                    end
                else
                    print(v)
                end    
            end
            print(#self.cards .. " is size of cards for " .. self.key)
        end
    }

    SMODS["ObjectType"](genre_config)
    
end

end