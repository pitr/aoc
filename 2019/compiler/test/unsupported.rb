class TestUnsupported < Base

  def do_and_catch
    error = nil
    out, _ = capture_io do
      error = assert_raises do
        yield
      end
    end
    return error.message, out
  end

  def test_no_classes
    error, out = do_and_catch { execute("class A; end") }
    assert_equal 'cannot compile', error
    assert_match %r%class .* is not supported%, out
  end

  def test_no_divide
    error, out = do_and_catch { execute("a=5;b=a/5") }
    assert_equal 'cannot compile', error
    assert_match %r%operator / .* is not supported%, out
  end

  def test_only_simple_bool
    error, out = do_and_catch { execute("a=5 if x<=0") }
    assert_equal 'cannot compile', error
    assert_match %r%operator <= .* is not supported%, out
  end

  def test_only_simple_bool2
    error, out = do_and_catch { execute("a=5;b=5<a") }
    assert_equal 'cannot compile', error
    assert_match %r%non-int assign .* is not supported%, out
  end

  def test_only_case_with_value
    error, out = do_and_catch { execute("case;when 5==5 then print 5; end") }
    assert_equal 'cannot compile', error
    assert_match %r%no value on case at .* is not supported%, out
  end

  def test_no_raise
    error, out = do_and_catch { execute("raise 2") }
    assert_equal 'cannot compile', error
    assert_match %r%undefined function raise .* is not supported%, out
  end

  def test_no_begin_rescue
    error, out = do_and_catch { execute("begin;x=4;rescue;puts(4);end") }
    assert_equal 'cannot compile', error
    assert_match %r%kwbegin at .* is not supported%, out
  end

  def test_no_lambda
    error, out = do_and_catch { execute("x=lambda { |y| puts y }") }
    assert_equal 'cannot compile', error
    assert_match %r%block at .* is not supported%, out
  end

  def test_no_block
    error, out = do_and_catch { execute("loop do |i| puts i; end") }
    assert_equal 'cannot compile', error
    assert_match %r%block at .* is not supported%, out
  end

  def test_no_reassign
    types = ["x=5", "def x();return 10;end"]

    types.permutation(2) do |a,b|
      error, _ = do_and_catch { execute([a,b].join(';')) }
      assert_match %r%changing type of variable x%, error
    end
  end

  def test_no_func_reassign
    error, _ = do_and_catch { execute("def x();return 10;end;"*2) }
    assert_match %r%re-declaring constant x .* is not supported%, error
  end

  def test_no_complicated_whens
    error, out = do_and_catch { execute("case 5;when 5,6 then print 5; else print 1;end") }
    assert_equal 'cannot compile', error
    assert_match %r%complicated when .* is not supported%, out
  end

  def test_no_unconsumed_intop
    error, _ = do_and_catch { execute("a=99;x=66;x+1;print(x)") }
    assert_equal 'x + 1 yields a value that must be consumed', error
  end

  def test_no_index_on_non_array
    error, out = do_and_catch { execute("x=1;print(x[12])") }
    assert_equal 'cannot compile', error
    assert_match %r%non-array var x .* is not supported%, out
  end

  def test_no_out_of_bound_index_on_array
    error, out = do_and_catch { execute("x=[1,2,3];print(x[12])") }
    assert_equal 'cannot compile', error
    assert_match %r%out of bound index .* is not supported%, out
  end

  def test_no_negative_index_on_array
    error, out = do_and_catch { execute("x=[1,2,3];print(x[-1])") }
    assert_equal 'cannot compile', error
    assert_match %r%out of bound index .* is not supported%, out
  end

  def test_no_var_index_on_array
    error, out = do_and_catch { execute("a=1;x=[1,2,3];print(x[a])") }
    assert_equal 'cannot compile', error
    assert_match %r%non-int index .* is not supported%, out
  end

  def test_no_non_global_arrays
    error, _ = do_and_catch { execute("def f;x=[1,2,3];end;print(2)") }
    assert_equal 'cannot create arrays outside global scope', error
  end

  def test_no_var_default_on_array
    error, out = do_and_catch { execute("x=42;a=Array.new(10, x)") }
    assert_equal 'cannot compile', error
    assert_match %r%non-int default value .* is not supported%, out
  end
end
