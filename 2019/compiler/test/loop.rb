class TestLoop < Base

  def test_while
    assert_equal [5], execute("x=0;while x<5;x=x+1;end;print x")
  end

  def test_while_1liner
    assert_equal [5], execute("x=0;x=x+1 while x<5;print x")
  end

  def test_while_in_while
    assert_equal [25], execute(<<-END)
x=0
a=0
while x<5
  x=x+1
  y=0
  while y<5
    y=y+1
    a=a+1
  end
end
print a
END
  end

  def test_break
    assert_equal [5], execute(<<-END)
x=0
while x<10
  x=x+1
  break if x==5
end
print x
END
  end

  def test_next
    assert_equal [4,5], execute(<<-END)
x=0
while x<5
  x=x+1
  next if x<4
  print x
end
END
  end

  def test_while_false
    assert_equal [5], execute(<<-END)
x=5
while false
  x=x+1
end
print x
END
  end

  def test_while_true
    assert_equal [5], execute(<<-END)
x=0
while true
  x=x+1
  break if x==5
end
print x
END
  end

end
