require 'coveralls'
require 'editorconfig-check'
require 'minitest/autorun'

Coveralls.wear!

class TestEditorConfigCheck < Minitest::Test
  def test_check_trailing_whitespace
    assert_raises(EditorConfig.check_trailing_whitespace(" "))
    assert_nil(EditorConfig.check_trailing_whitespace(""))
  end
end
