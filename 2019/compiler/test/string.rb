class TestStrings < Base

  def test_char
    assert_equal [120], execute("a='x';print a")
    assert_equal [120], execute("a='z';print a-2")
  end

  def test_strings
    assert_equal [120], execute('a="hello world\n";print a;print "hi again"')
  end

end
