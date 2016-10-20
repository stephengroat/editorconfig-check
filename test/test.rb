require 'coveralls'
require 'editorconfig-check'
require "test/unit"

Coveralls.wear!

class Test < Test::Unit::TestCase
  def test_check_trailing_whitespace
    assert_raise(EditorConfig.check_trailing_whitespace(" "))
    assert_nil(EditorConfig.check_trailing_whitespace(""))
  end
end
