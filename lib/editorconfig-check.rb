require "editorconfig"

module EditorConfig
  @byte_order_marks = {
    '\xef\xbb\xbf' => 'utf-8-bom',
    '\xfe\xff' => 'utf-16be',
    '\xff\xfe' => 'utf-16le',
    '\x00\x00\xfe\xff' => 'utf-32be',
    '\xff\xfe\x00\x00' => 'utf-32le',
  }

  @line_endings = {
    'crlf' => '\r\n',
    'lf' =>'\n',
    'cr' => '\r',
  }
  
  def check(file)
    line_num=0
    text=File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
    end
  end
  
  def check_indentation(line, indent_style)
    indent=line[/^\s*/]
    if indent_style == 'space' and indent=~/\t/
      errors.add('Tab indentation found')
      if indent.count(' ') % indent_size != 0
        errors.add("Incorrect space indent size found")
      end
    else if indent_style == 'tab' and indent=~/' '/
      errors.add('Space indentation found')
    end
  end

end
