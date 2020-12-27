class TestMath < Base
  def do_math(expr)
    w=5;x=11;y=22;z=33
    assert_equal [eval(expr)], execute("x=#{x};y=#{y};z=#{z};w=#{w};print(#{expr})")
  end

  def test_var_assign
    assert_equal [66], execute("x=22;x+=44;print(x)")
    assert_equal [66], execute("x=22;x-=-44;print(x)")
    assert_equal [66], execute("x=22;x*=3;print(x)")
    assert_equal [66], execute("x=-22;x*=-3;print(x)")
    assert_equal [66], execute("x=22;x+=4*11;print(x)")
  end

  def test_2ints
    do_math "5+1"
    do_math "5-1"
    do_math "1-5"
    do_math "5*2"
  end

  def test_3ints
    do_math "5+1+2"
    do_math "5-1-1"
    do_math "1-5+10"
    do_math "1+5-10"
    do_math "5*2*3"
    do_math "5*2+3"
    do_math "5+2*3"
    do_math "5-2*3"
  end

  def test_1var
    assert_equal [66], execute("x=22;y=4*x-x;z=y;print(z)")

    do_math "5+x+2"
    do_math "5-x-x"
    do_math "x-5+10"
    do_math "x+5-10"
    do_math "5*x*3"
    do_math "5*x+3"
    do_math "5+x*x"
    do_math "5-x*x"
  end

  def test_2var
    do_math "x+y+2"
    do_math "5-x-x"
    do_math "x-5+x"
    do_math "x+5-y"
    do_math "5*x*y"
    do_math "5*x+y"
    do_math "y+x*x"
    do_math "5-x*x"
  end

  def test_3var
    do_math "x+y+z"
    do_math "x-y-z"
    do_math "x-y+z"
    do_math "x+y-z"
    do_math "x*y*z"
    do_math "x*y+z"
    do_math "x+y*z"
    do_math "x-y*z"
    do_math "x*y-z"
  end

  def test_4var
    do_math "x+7-y+z+w"
    do_math "x-7-y-z+w"
    do_math "x-7-y+z+w"
    do_math "x+7-y-z*w"
    do_math "x*7-y*z*w"
    do_math "x*7-y+z*w"
    do_math "x+7-y*z*w"
    do_math "x-7-y*z*w"
  end
end
