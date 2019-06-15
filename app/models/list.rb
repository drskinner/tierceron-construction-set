class List
  CONTAINER_FLAGS = {  1 => 'closeable',
                       2 => 'pickproof',
                       4 => 'closed',
                       8 => 'locked',
                      16 => 'eatkey'
                    }

  LIQUID_TYPES = {  0 => 'water',
                    1 => 'beer',
                    2 => 'white wine',
                    3 => 'red wine',
                    4 => 'ale',
                    5 => 'stout',
                    6 => 'bitter',
                    7 => 'ginseng tea',
                    8 => 'herbal tea',
                    9 => 'really manky coffee',
                   10 => 'milk',
                   11 => 'Rhuennan Breakfast tea',
                   12 => 'Cuendar dark-roast coffee',
                   13 => 'Nadrali Estate AA coffee',
                   14 => 'orange juice',
                   15 => 'sancocho prieto',
                   16 => "Beak's Specialty",
                   17 => "Morning's Revenge",
                   18 => 'Black Ale',
                   19 => 'salt water',
                   20 => 'stagnant water',
                   21 => 'Fazenda Vista Allegre coffee',
                   22 => 'espresso',
                   23 => 'cappuccino',
                   24 => 'Saxon breakfast tea',
                   25 => 'chocolate mocha',
                   26 => 'wheatgrass tonic',
                   27 => 'Energy Elixir',
                   28 => 'Kharmic Refresher'
                 }

  PREPOSITIONS = { 1 => 'on', 2 => 'in', 4 => 'at', 8 => 'under' }

  PREPOSITIONS_SHELF = { 1 => 'on', 2 => 'in', 3 => 'at', 4 => 'under' }

  WEAPON_TYPES = {  0 => 'barehand or miscellaneous',
                    1 => 'club, hammer, or mace',
                    2 => 'heavy bludgeon',
                    3 => 'quarterstaff',
                    4 => 'spear',
                    5 => 'small dagger',
                    6 => 'large dagger',
                    7 => 'short sword',
                    8 => 'standard sword',
                    9 => 'long sword',
                   10 => 'large or two-bladed axe',
                   11 => 'small axe or hatchet',
                   12 => 'Crusader Holy weapon',
                   13 => 'whip or flail',
                   14 => 'claw',
                   15 => 'animal bite',
                   16 => 'stinger',
                   17 => 'magical discharge',
                   18 => 'crossbow',
                   19 => 'bow',
                   20 => 'dart or blow gun',
                   21 => 'slingshot',
                   22 => 'shield (counterattacks)'
                 }

  def self.bitvector_to_bits(bitvector)
    [].tap { |bits| 
      bitvector.to_s(2).chars.reverse.each_with_index { |bit, index| bits << 2**index unless bit.to_i.zero? } 
    }
  end

  def self.bitvector_to_labels(bitvector, list)
    bitvector_to_bits(bitvector).map { |bit| list[bit] }.join(', ')
  end

  def self.sum_bitvector(bitvector)
    bitvector.map { |bit| bit.to_i }.sum
  end
end
