module SocialService
  def self.import(file)
    keys = { 'Name        ' => :name,
             'CharNoArg   ' => :char_no_arg,
             'OthersNoArg ' => :others_no_arg,
             'CharObject  ' => :char_obj,
             'OthersObject' => :others_obj,
             'CharFound   ' => :char_found,
             'OthersFound ' => :others_found,
             'VictFound   ' => :vict_found,
             'CharAuto    ' => :char_auto,
             'OthersAuto  ' => :others_auto
           }

    count = 0
    content = File.read(file)

    content.each_line do |line|
      if line[0..6] == '#SOCIAL'
        @social = Social.new
      elsif line[0..2] == 'End'
        if @social.valid?
          @social.save!
          count += 1
        end
      elsif line[0..3] == '#END'
        break
      else
        my_key = line[0..11]
        my_value = line[13..-3]
        if keys.has_key?(my_key)
          @social[keys[my_key]] = my_value
        end
      end
    end

    count
  end

  def self.export(socials)
    fields = Social::PARSABLE_FIELDS

    [].tap { |file|
      socials.each do |social|
        file << '#SOCIAL'
        file << "Name         #{social.name}~"
        fields.each do |field|
          value = social.send(field)
          unless value.blank?          
            label = '%-12.12s' % I18n.t("activerecord.attributes.social.#{field.to_s}_label")
            file << "#{label} #{value}~"
          end
        end

        file << 'End'
        file << ''
      end
      file << "#END\n"
    }.join("\n")
  end
end
