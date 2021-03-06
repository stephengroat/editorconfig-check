require 'editorconfig'

# EditorConfig Check module
module EditorConfigCheck
  @byte_order_marks = {
    '\xef\xbb\xbf' => 'utf-8-bom',
    '\xfe\xff' => 'utf-16be',
    '\xff\xfe' => 'utf-16le',
    '\x00\x00\xfe\xff' => 'utf-32be',
    '\xff\xfe\x00\x00' => 'utf-32le'
  }.freeze

  @line_endings = {
    'crlf' => "\r\n",
    'lf' => "\n",
    'cr' => "\r"
  }.freeze

  @whitespace = {
    'tab' => "\t",
    'space' => "\ "
  }.freeze

  def self.check(file)
    line_num
    text = File.open(file).read
    text.each_line do |line|
      check_indentation(line, 'space')
      check_trailing_whitespace(line)
      check_end_of_line(line, 'lf')
      puts line_num += 1
      # TODO: does this need a rescue/next clause
    end
  end

  def self.check_indentation(line, indent_type, indent_size)
    indent = line[/^[\t ]+/]
    return if indent.nil?
    raise "Non #{indent_type} indentation found"\
      unless indent[/(?!#{@whitespace[indent_type]})/].empty?
    raise 'Incorrect indent size found'\
          if (indent.count(@whitespace[indent_type]) % indent_size).nonzero?
  end

  def self.check_trailing_whitespace(line)
    raise 'Trailing whitespace found' unless line[/[\t ]+$/].nil?
  end

  def self.check_end_of_line(line, eol)
    raise 'Incorrect end of line found' if /#{@line_endings[eol]}/ =~ line
  end
end
