require 'editorconfig'

module EditorConfig
  BYTE_ORDER_MARKS = {
    '\xef\xbb\xbf' => 'utf-8-bom',
    '\xfe\xff' => 'utf-16be',
    '\xff\xfe' => 'utf-16le',
    '\x00\x00\xfe\xff' => 'utf-32be',
    '\xff\xfe\x00\x00' => 'utf-32le'
  }.freeze

  LINE_ENDINGS = {
    'crlf' => '\r\n',
    'lf' => '\n',
    'cr' => '\r'
  }.freeze

  def check(file)
    line_num
    text = File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
      check_trailing_whitespace(line)
      line_num += 1
      # TODO: does this need a rescue/next clause
    end
  end

  def check_indentation(line, indent_style, indent_size)
    indent = line[/^\s*/]
    # Space indentation
    if indent_style == 'space'
      raise 'Tab indentation found' if indent =~ /\t/
      raise 'Incorrect spxce indent size found' if (indent.count(' ') % indent_size).nonzero?
    # Tab Indentation
    elsif indent_style == 'tab'
      raise 'Space indentation found' if indent =~ / /
      raise 'Incorrect tab indent size found' if (indent.count('\t') % indent_size).nonzero?
    end
  end

  def check_trailing_whitespace(line)
    trailing_whitespace = line[/[\s]+$/]
    raise 'Trailing whitespace found' unless trailing_whitespace.nil?
  end
  
  def check_end_of_line(line, end_of_line)
    raise "Incorrect end of line found" if \LINE_ENDINGS[end_of_line]\ =~ line
  end
end
