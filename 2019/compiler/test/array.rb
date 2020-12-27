class TestArray < Base

  def test_array_get
    assert_equal [33], execute("a=[11,22,33];print a[2]")
  end

  def test_array_set
    assert_equal [44], execute("a=[11,22,33];a[0]=44;print a[0]")
    assert_equal [44], execute("a=[11,22,33];x=44;a[0]=x;print a[0]")
  end

  def test_array_set_incr
    assert_equal [44], execute("a=[11,22,33];a[0]+=33;print a[0]")
  end

  def test_array_get_math
    assert_equal [44], execute("a=[11,22,33];x=22+a[0]*2;print x")
    assert_equal [44], execute("a=[11,22,33];x=a[0]+a[2];print x")
    assert_equal [44], execute("a=[11,22,33];print 44 if a[1]==22")
  end

  def test_array_new
    assert_equal [44], execute("a=Array.new(10);a[5]=44;x=11;print a[5]")
    assert_equal [44], execute("a=Array.new(10, 44);print a[5]")
  end

  def test_array_new_init_to_zero
    assert_equal [0,0], execute("a=Array.new(10);b=[1];c=Array.new(10);x=44;print a[5];print c[5]")
  end

end
