require 'coveralls'
Coveralls.wear!
require 'editorconfig_check'
require 'minitest/autorun'

class TestEditorConfigCheck < Minitest::Test
  def test_check_trailing_whitespace
    exception = assert_raises(RuntimeError)\
       { EditorConfigCheck.check_trailing_whitespace(' ') }
    assert_equal('Trailing whitespace found', exception.message)
  end
end
