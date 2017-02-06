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

  def test_check_indentation
    exception = assert_raises(RuntimeError)\
       { EditorConfigCheck.check_indentation(' s', 'tab', 1) }
    assert_equal('Non tab indentation found', exception.message)
    exception = assert_raises(RuntimeError)\
       { EditorConfigCheck.check_indentation('\ts', 'space', 1) }
    assert_equal('Non space indentation found', exception.message)
    exception = assert_raises(RuntimeError)\
       { EditorConfigCheck.check_indentation(' s', 'space', 2) }
    assert_equal('Incorrect indent size found', exception.message)
  end
end
