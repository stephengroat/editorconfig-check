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
end
