class TestFunc < Base

  def test_fun
    assert_equal [22], execute("def f(a,b);return a+b;end;x=2;print f(x,20)")
  end

  def test_fun2
    assert_equal [22], execute("def f(a,b);return a+b;end;x=f(2,20);print x")
  end

  def test_return_var
    assert_equal [22], execute("def f;x=22;return x;end;print f()")
  end

  def test_io
    assert_equal [102], execute("print 102")
    assert_equal [102], execute("x=102;print x")
    assert_equal [102], execute("print 2+read", [100])
  end

  def test_recursion
    assert_equal [377], execute(<<-END)
def fib(n)
  if n < 1 then return 0
  elsif n==1 then return 1
  elsif n==2 then return fib(1)
  else return fib(n-1)+fib(n-2)
  end
end
print fib(14)
END
  end

  def test_consume_result
    error = assert_raises do
      execute("def f;return 2;end;f()")
    end
    assert_equal 'f returns 1 value', error.message
  end

  def test_num_of_arguments
    out, _ = capture_io do
      error = assert_raises do
        execute("def f(a,b);return a+b;end;print f(1)")
      end
      assert_equal 'cannot compile', error.message
    end
    assert_match %r%unmatched function arity%, out
  end

  def test_return_from_global
    error = assert_raises do
      execute("return 42")
    end
    assert_equal 'cannot return from global scope', error.message
  end
end
