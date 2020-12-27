class TestIf < Base

  def test_if_true
    assert_equal [5], execute("print 5 if true")
  end

  def test_if_false
    assert_equal [], execute("print 5 if false")
  end

  def test_if_lt
    assert_equal [5], execute("print 5 if 1<5 ; print 9 if 5<1")
  end

  def test_if_gt
    assert_equal [5], execute("print 5 if 5>1 ; print 9 if 1>5")
  end

  def test_if_eq
    assert_equal [5], execute("print 5 if 5==5 ; print 9 if 1==5")
  end

  def test_if_eq_vars
    assert_equal [5], execute("x=5;print 5 if x==read ; print 9 if read==x", [5,1])
  end

  def test_if_else
    assert_equal [5,5], execute(<<-END)
x=5
if x>4
  print 5
else
  print 1
end
if x<4
  print 1
else
  print 5
end
END
  end

end
