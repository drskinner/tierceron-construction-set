class Item < ApplicationRecord
  include Searchable

  validates :vnum, presence: true, 
                   uniqueness: true
  validates :vnum, inclusion: { in: (User.current.present? ? User.current.owned_vnums : []) },
                     if: Proc.new { |i| User.current.builder? && i.vnum.present? }
  validates :keywords, presence: true
  validates :item_type, presence: true
  validates :short_desc, presence: true
  validates :long_desc, presence: true

  before_validation :clean_multiselect_fields

  scope :by_item_type, ->(item_type) { where(item_type: item_type) }
  scope :by_zone_id, (lambda { |zone_id|
    zone = Zone.find_by(id: zone_id)
    where('vnum >= ? AND vnum <= ?', zone.min_vnum, zone.max_vnum) unless zone.blank?
  })
  scope :keywords_contain, ->(key) { where('keywords ILIKE ?', "%#{key}%") }

  ITEM_TYPES = %w[none light scroll wand staff weapon shelf furniture treasure armor 
                  potion worn other trash _oldtrap container _note drinkcon key food 
                  money pen boat corpse corpse_pc fountain pill plant jewellery scraps 
                  pipe herbcon herb incense fire book switch lever pullchain button 
                  dial rune runepouch match trap map portal paper tinder lockpick 
                  spike disease oil fuel puddle journal missileweapon projectile quiver
                  shovel salve cook keyring odor chance piece housekey mix]

  OBJECT_FLAGS = %w[glow hum dark nolongdesc evil invis magic nodrop
                    bless antigood antievil antineutral noremove inventory
                    antimage antithief antiwarrior anticleric organic metal
                    donation float clancorpse antiinventor antishaman
                    hidden poisoned covering deathrot buried prototype
                    nolocate groundrot]

  WEAR_FLAGS = %w[take finger neck body head legs feet hands arms shield 
       about waist wrist wield hold _dual_ ears eyes missile back face ankle]

  def clean_multiselect_fields    
    flags.reject!(&:blank?) unless flags.blank?
    wear_flags.reject!(&:blank?) unless wear_flags.blank?
  end

  def self.item_type_collection
    ITEM_TYPES.map { |t| [t.humanize, t] }.sort
  end

  def self.object_flag_collection
    OBJECT_FLAGS.map { |flag| [I18n.t("lists.item.object_flags.#{flag}"), flag] }.sort
  end

  def self.wear_flag_collection
    WEAR_FLAGS.map { |flag| [I18n.t("lists.item.wear_flags.#{flag}"), flag] }.sort
  end

  def flags_display
    flags.map { |flag| I18n.t("lists.item.object_flags.#{flag}") }.join(', ')
  end

  def item_type_display
    item_type.humanize
  end

  def wear_flags_display
    wear_flags.map { |flag| I18n.t("lists.item.wear_flags.#{flag}") }.join(', ')
  end

  def value0_display
    case item_type
    when 'furniture'
      List.bitvector_to_labels(value0, List::PREPOSITIONS)
    else
      value0
    end
  end

  def value1_display
    case item_type
    when 'furniture'
      List.bitvector_to_labels(value1, List::PREPOSITIONS)
    when 'shelf'
      List.bitvector_to_labels(value1, List::CONTAINER_FLAGS)
    else
      value1
    end
  end

  def value2_display
    case item_type
    when 'drinkcon'
      List::LIQUID_TYPES[value2]
    when 'furniture'
      List.bitvector_to_labels(value2, List::PREPOSITIONS)
    when 'trap'
      List::TRAP_TYPES[value2]
    else
      value2
    end
  end

  def value3_display
    case item_type
    when 'furniture'
      List.bitvector_to_labels(value3, List::PREPOSITIONS)
    when 'trap'
      List.bitvector_to_labels(value3, List::TRAP_FLAGS)
    when 'weapon'
      List::WEAPON_TYPES[value3]
    else
      value3
    end
  end

  def value4_display
    case item_type
    when 'furniture'
      List::PREPOSITIONS[value4]
    when 'shelf'
      List::PREPOSITIONS_SHELF[value4]
    else
      value4
    end
  end
end
