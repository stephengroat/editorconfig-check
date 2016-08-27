require 'editorconfig'

module EditorConfig
  @byte_order_marks = {
    '\xef\xbb\xbf' => 'utf-8-bom',
    '\xfe\xff' => 'utf-16be',
    '\xff\xfe' => 'utf-16le',
    '\x00\x00\xfe\xff' => 'utf-32be',
    '\xff\xfe\x00\x00' => 'utf-32le'
  }

  @line_endings = {
    'crlf' => '\r\n',
    'lf' => '\n',
    'cr' => '\r'
  }

  def check(file)
    line_num = 0
    text = File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
      #rescue
      #  next
    end
  end

  def check_indentation(line, indent_style, indent_size)
    indent = line[/^\s*/]
    if indent_style == 'space'
      if indent =~ /\t/
        raise 'Tab indentation found'
      elsif (indent.count(' ') % indent_size).nonzero?
        raise 'Incorrect space indent size found'
      end
    elsif indent_style == 'tab'
      if indent =~ /\s/
        raise 'Space indentation found'
      elsif (indent.count('\t') % indent_size).nonzero?
        raise 'Incorrect tab indent size found'
      end
    end
  end
  
  def check_trailing_whitespace(line)
    trailing_whitespace = line[/[\s]+$/]
    unless trailing_whitespace.nil? raise 'Trailing whitespace found'
  end
end
