require 'digest/sha1'

module Nokogiri
  module XML
    class XID

      attr_accessor :hash

      def initialize(node)
        @hash = Digest::SHA1.hexdigest(node.name)
      end

    end
  end
end
