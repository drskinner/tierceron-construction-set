class Social < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :char_no_arg, presence: true

  PARSABLE_FIELDS = %i[char_no_arg
                       others_no_arg
                       char_obj
                       others_obj
                       char_found
                       others_found
                       vict_found
                       char_auto
                       others_auto]

  def parsable_field_value(field)
    self.send(field.to_sym) if self.respond_to?(field.to_sym)
  end

  def self.tokens
    name = User.current.first_name
    gender = User.current.pronoun_class
    
    { '$n' => name, '$N' => "Bill the security guard",
      '$m' => I18n.t("lists.user.pronouns.#{gender}.object"), '$M' => 'him',
      '$P' => 'a bagel',
      '$s' => I18n.t("lists.user.pronouns.#{gender}.possessive"), '$S' => 'his',
      '$e' => I18n.t("lists.user.pronouns.#{gender}.subject"), '$E' => 'he' }
  end

  def parse(field)
    message = self.send(field.to_sym) if self.respond_to?(field.to_sym)
    Social.tokens.each { |old, new| message.gsub!(old, new) } unless message.blank?

    message
  end

end
