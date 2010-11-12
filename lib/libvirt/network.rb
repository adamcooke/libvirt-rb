module Libvirt
  # Represents a network within libvirt, which is a network interface
  # such as a host-only network for VirtualBox, for example.
  class Network
    # Initializes a new {Network} object given a `virNetworkPtr`. Please
    # do not call this directly. Instead, use the {Connection#networks}
    # object.
    def initialize(pointer)
      @pointer = pointer
    end

    # Returns the name of the network as a string.
    #
    # @return [String]
    def name
      FFI::Libvirt.virNetworkGetName(self)
    end

    # Returns the XML descriptions of this network.
    #
    # @return [String]
    def xml
      FFI::Libvirt.virNetworkGetXMLDesc(self, 0)
    end

    # Returns the UUID of the network as a string.
    #
    # @return [String]
    def uuid
      output_ptr = FFI::MemoryPointer.new(:char, 48)
      FFI::Libvirt.virNetworkGetUUID(self, output_ptr)
      output_ptr.read_string
    end

    # Deterine if the network is active or not.
    #
    # @return [Boolean]
    def active?
      FFI::Libvirt.virNetworkIsActive(self) == 1
    end

    # Determine if the network is persistent or not.
    #
    # @return [Boolean]
    def persistent?
      FFI::Libvirt.virNetworkIsPersistent(self) == 1
    end

    # Converts to the actual `virNetworkPtr` of this structure. This allows
    # this object to be used directly with the FFI layer which expects a
    # `virNetworkPtr`.
    #
    # @return [FFI::Pointer]
    def to_ptr
      @pointer
    end

    # Provide a meaningful equality check for two networks by comparing
    # UUID.
    #
    # @return [Boolean]
    def ==(other)
      other.is_a?(Network) && other.uuid == uuid
    end
  end
end
