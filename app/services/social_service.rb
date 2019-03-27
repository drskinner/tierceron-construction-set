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
        break # make a return instead?
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
end
