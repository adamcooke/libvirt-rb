module Libvirt
  module Spec
    module Device
      class Emulator
        attr_accessor :path

        # Initialize an emulator device with the given path. The capabilities
        # XML from {Connection} describes what emulators are available.
        def initialize(path)
          if path.is_a?(Nokogiri::XML::Element)
            @path = path.text
          else
            @path = path
          end
        end

        # Returns the XML for this device.
        #
        # @return [String]
        def to_xml(xml=Nokogiri::XML::Builder.new)
          xml.emulator path
          xml.to_xml
        end
      end
    end
  end
end
