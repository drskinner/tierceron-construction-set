module MobileService
  def self.get_import_value(line)
    line[11..-1].chomp("~\n")
  end

  def self.get_import_array(line)
    get_import_value(line).split(' ')
  end

  def self.import(file)
    mobile_open = false
    description_open = false

    count = 0
    content = File.read(file)
  
    content.each_line do |line|
      if line[0..6] == '#MOBILE'
        mobile_open = true
        @mobile = Mobile.new
      end

      if mobile_open
        case line[0..9]
        when 'Vnum      '
          @mobile.vnum = line[11..-1]
        when 'Keywords  '
          @mobile.keywords = get_import_value(line)
        when 'Short     '
          @mobile.short_desc = get_import_value(line)
        when 'Long      '
          @mobile.long_desc = get_import_value(line).chomp("\n")
        when 'Race      '
          @mobile.race = get_import_value(line)
        when 'Class     '
          @mobile.klass = get_import_value(line)
        when 'Position  '
          @mobile.position = get_import_value(line)
        when 'DefPos    '
          @mobile.defposition = get_import_value(line)
        when 'Gender    '
          @mobile.sex = get_import_value(line)
        when 'Actflags  '
          @mobile.act_flags = get_import_array(line)
        when 'Affected  '
          @mobile.affected_by = get_import_array(line)
        when 'Stats1    '
          stats = get_import_array(line)
          @mobile.alignment = stats[0]
          @mobile.level     = stats[1]
          @mobile.mobthac0  = stats[2]
          @mobile.ac        = stats[3]
          @mobile.gold      = stats[4]
          @mobile.exp       = stats[5]
        when 'Stats2    '
          stats = get_import_array(line)
          @mobile.hitnodice   = stats[0]
          @mobile.hitsizedice = stats[1]
          @mobile.hitplus     = stats[2]
        when 'Stats3    '
          stats = get_import_array(line)
          @mobile.damnodice   = stats[0]
          @mobile.damsizedice = stats[1]
          @mobile.damplus     = stats[2]
        when 'Stats4    '
          stats = get_import_array(line)
          @mobile.height     = stats[0]
          @mobile.weight     = stats[1]
          @mobile.numattacks = stats[2]
          @mobile.hitroll    = stats[3]
          @mobile.damroll    = stats[4]
        when 'Attribs   '
          stats = get_import_array(line)
          @mobile.str = stats[0]
          @mobile.int = stats[1]
          @mobile.wis = stats[2]
          @mobile.dex = stats[3]
          @mobile.con = stats[4]
          @mobile.cha = stats[5]
          @mobile.lck = stats[6]
        when 'Saves     '
          stats = get_import_array(line)
          @mobile.saving_poison_death = stats[0]
          @mobile.saving_wand         = stats[1]
          @mobile.saving_para_petri   = stats[2]
          @mobile.saving_breath       = stats[3]
          @mobile.saving_spell_staff  = stats[4]
        when 'Speaks    '
          @mobile.speaks = get_import_array(line)
        when 'Speaking  '
          @mobile.speaking = get_import_array(line)
        when 'Bodyparts '
          @mobile.xflags = get_import_array(line)
        when 'Resist    '
          @mobile.resistant = get_import_array(line)
        when 'Immune    '
          @mobile.immune = get_import_array(line)
        when 'Suscept   '
          @mobile.susceptible = get_import_array(line)
        when 'Attacks   '
          @mobile.attacks = get_import_array(line)
        when 'Defenses  '
          @mobile.defenses = get_import_array(line)
        when 'ShopData  '
          @mobile.shop_data = get_import_array(line)
        when 'RepairData'
          @mobile.repair_data = get_import_array(line)
        when '#ENDMOBILE'
          mobile_open = false
          if @mobile.valid?
            @mobile.save!(validate: false) # FIX THIS
            count += 1
          end
        when 'Desc      '
          description_open = true
          @mobile.description = get_import_value(line)
        else
          if description_open
            if line.start_with?('~')
              description_open = false
            else
              @mobile.description << line
            end
          end
        end
      end
    end

    count
  end

end
