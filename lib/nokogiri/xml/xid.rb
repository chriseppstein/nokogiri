require 'digest/sha1'

module Nokogiri
  module XML
    class XID

      attr_accessor :hash

      def initialize(node)
        @hash = recursively_calculate_hash_for_node(node)
      end

      private

      def recursively_calculate_hash_for_node(node)
        children_hash = Digest::SHA1.hexdigest(Array(node.children).collect { |child|
            recursively_calculate_hash_for_node(child)
          }.join(","))
        attribute_hash = Digest::SHA1.hexdigest(Array(node.attributes).collect { |attr|
            Digest::SHA1.hexdigest("#{attr.first}=#{attr.last.value}")
          }.join(","))
        Digest::SHA1.hexdigest [node.name, attribute_hash, children_hash].join(",")
      end

    end
  end
end
