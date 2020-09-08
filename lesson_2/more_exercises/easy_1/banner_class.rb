class Banner
  def initialize(message, banner_width=message.length)
    @message = message
    if banner_width >= 76
      @banner_width = 76
    elsif banner_width < message.length
      @banner_width = message.length
    else
      @banner_width = banner_width
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    '+-' + '-' * @banner_width + '-+'
  end

  def empty_line
    '| ' + ' ' * @banner_width + ' |'
  end

  def message_line
    '| ' + @message.center(@banner_width) + ' |'
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 90)
puts banner
banner = Banner.new('', 90)
puts banner
