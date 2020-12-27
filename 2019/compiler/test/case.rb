class TestCase < Base

  def test_when
    assert_equal [5], execute("case 5;when 5 then print 5; else print 1; print 4; end")
  end

  def test_2_whens
    assert_equal [5], execute("case 5;when 4 then print 4;when 5 then print 5; else print 1;end")
  end

  def test_else
    assert_equal [5], execute("case 5;when 1 then print 1; else print 5;end")
  end

  def test_no_else
    assert_equal [], execute("case 5;when 1 then print 1;end")
  end

  def test_func
    assert_equal [5], execute("case read; when 5 then print 5; else print 1;end", [5])
  end

  def test_variable
    assert_equal [5], execute("x=5;case x;when 5 then print 5; else print 1;end")
  end

end
