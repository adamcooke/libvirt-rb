require "test_helper"

Protest.describe("error") do
  setup do
    @klass = Libvirt::Error
  end

  context "getting the last error" do
    setup do
      # Reset the error manually so we're clear.
      FFI::Libvirt.virResetLastError
    end

    should "be fine if there is no last error" do
      result = nil
      assert_nothing_raised { result = @klass.last_error }
      assert result.nil?
    end

    should "report the last error" do
      result = FFI::Libvirt.virConnectOpen("NSEpicFailure")
      assert result.null? # Sanity check on the failure

      # And now we verify the error is accessible
      error = @klass.last_error
      assert error
    end
  end

  context "with an error instance" do
    setup do
      # Get an error instance...
      FFI::Libvirt.virConnectOpen("FailHard")
      @error = @klass.last_error
    end

    should "allow access to the raw struct" do
      assert @error.interface.is_a?(FFI::Libvirt::Error)
    end

    should "allow access to the error code" do
      assert_equal :system_error, @error.code
    end

    should "allow access to the error domain" do
      assert_equal :remote, @error.domain
    end

    should "allow access to the error message" do
      assert @error.message
    end
  end
end
