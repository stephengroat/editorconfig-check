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
    line_num = 0
    text = File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
      # TODO: does this need a rescue/next clause
    end
  end

  def check_indentation(line, indent_style, indent_size)
    indent = line[/^\s*/]
    # Space indentation
    raise 'Tab indentation found' if indent_style == 'space' && indent =~ /\t/
    raise 'Incorrect spxce indent size found' if indent_style == 'space'\
      && (indent.count(' ') % indent_size).nonzero?
    # Tab Indentation
    raise 'Space indentation found' if indent_style == 'tab' && indent =~ / /
    raise 'Incorrect tab indent size found' if indent_style == 'tab'\
      && (indent.count('\t') % indent_size).nonzero?
  end

  def check_trailing_whitespace(line)
    trailing_whitespace = line[/[\s]+$/]
    raise 'Trailing whitespace found' unless trailing_whitespace.nil?
  end
end
