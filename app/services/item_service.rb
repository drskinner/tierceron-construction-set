module ItemService
  def self.get_import_value(line)
    line[9..-1].chomp("~\n")
  end

  def self.import(file)
    object_open = false
    full_desc_open = false

    count = 0
    content = File.read(file)

    content.each_line do |line|
      if line[0..6] == '#OBJECT'
        object_open = true
        @item = Item.new
      end

      if object_open
        case line[0..8]
        when 'Vnum     '
          @item.vnum = line[9..-1]
        when 'Keywords '
          @item.keywords = ItemService.get_import_value(line)
        when 'Type     '
          @item.item_type = ItemService.get_import_value(line)
        when 'Short    '
          @item.short_desc = ItemService.get_import_value(line)
        when 'Long     '
          @item.long_desc = ItemService.get_import_value(line)
        when 'Flags    '
          @item.flags = ItemService.get_import_value(line).split(' ')
        when 'WFlags   '
          @item.wear_flags = ItemService.get_import_value(line).split(' ')
        when 'Values   '
          temp_values = line[9..-1].split(' ')
          (0..5).each do |index|
            @item.send("value#{index}=", temp_values[index])
          end
        when 'Stats    '
          stats = line[9..-1].split(' ')
          @item.weight = stats[0];
          @item.cost   = stats[1];
          @item.rent   = stats[2];
          @item.level  = stats[3];
          @item.layers = stats[4];
        when '#ENDOBJEC'
          object_open = false
          if @item.valid?
            @item.save!
            count += 1
          end
        when 'Full     '
          full_desc_open = true
          @item.full_desc = ItemService.get_import_value(line)
        else
          if full_desc_open
            if line.start_with?('~')
              full_desc_open = false
            else
              @item.full_desc << line
            end
          end
        end
      end
    end

    count
  end

  def self.value_label(item_type, index)
    return "Value#{index}" if item_type.blank?

    label = I18n.t("lists.item.value#{index}.#{item_type}")
    label.include?('translation missing') ? 'not used' : label
  end

  def self.value_labels(item_type)
    [].tap do |labels|
      (0..5).each do |index|
        labels << self.value_label(item_type, index)
      end
    end
  end
end
