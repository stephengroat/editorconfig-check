require 'coveralls'
Coveralls.wear!
require 'editorconfig-check'
require 'minitest/autorun'

class TestEditorConfigCheck < Minitest::Test
  def test_check_trailing_whitespace
    assert_raises(EditorConfigCheck.check_trailing_whitespace(" "))
    assert_nil(EditorConfigCheck.check_trailing_whitespace(""))
  end
end
