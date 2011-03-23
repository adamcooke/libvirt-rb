require "test_helper"

Protest.describe("Graphics device spec") do
  setup do
    @klass = Libvirt::Spec::Device::Graphics
  end

  context "initialization and parsing XML" do
    should "parse the type" do
      @instance = @klass.new("<graphics type='sdl'/>")
      assert_equal :sdl, @instance.type
    end

    should "parse the display" do
      @instance = @klass.new("<graphics display='foo'/>")
      assert_equal 'foo', @instance.display
    end

    should "parse the vnc port" do
      @instance = @klass.new("<graphics port='1234'/>")
      assert_equal 1234, @instance.port
    end

    should "parse the vnc listen interface" do
      @instance = @klass.new("<graphics listen='1.2.3.4'/>")
      assert_equal "1.2.3.4", @instance.listen
    end

    should "parse the vnc autoport" do
      @instance = @klass.new("<graphics autoport='yes'/>")
      assert_equal true, @instance.autoport
      @instance = @klass.new("<graphics autoport='no'/>")
      assert_equal false, @instance.autoport
    end

    should "raise an exception if unsupported tags exist" do
      assert_raises(Libvirt::Exception::UnparseableSpec) {
        @klass.new("<graphics><foo/></graphics>")
      }
    end
  end
end
