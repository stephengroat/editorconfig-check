require 'editorconfig'

module EditorConfigCheck
  @BYTE_ORDER_MARKS = {
    '\xef\xbb\xbf' => 'utf-8-bom',
    '\xfe\xff' => 'utf-16be',
    '\xff\xfe' => 'utf-16le',
    '\x00\x00\xfe\xff' => 'utf-32be',
    '\xff\xfe\x00\x00' => 'utf-32le'
  }.freeze

  @LINE_ENDINGS = {
    'crlf' => '\r\n',
    'lf' => '\n',
    'cr' => '\r'
  }.freeze
  
  @INDENT = {
    'tab' => '\t',
    'space' => ' '
  }.freeze

  def check(file)
    line_num
    text = File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
      check_trailing_whitespace(line)
      check_end_of_line(line, 'lf')
      line_num += 1
      # TODO: does this need a rescue/next clause
    end
  end

  def check_indentation(line, indent_style, indent_size)
    indent = line[/^\s*/]
    raise "Non #{indent_style} indentation found" if /(?!#{@IDENT[indent_style]})/ =~ indent 
    raise 'Incorrect indent size found' if (indent.count(@INDENT[indent_style]) % indent_size).nonzero?
  end

  def check_trailing_whitespace(line)
    raise 'Trailing whitespace found' unless line[/[\s]+$/].nil?
  end
  
  def check_end_of_line(line, end_of_line)
    raise "Incorrect end of line found" if /#{@LINE_ENDINGS[end_of_line]}/ =~ line
  end
end
