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
        children_hashes = node.children.collect { |child| recursively_calculate_hash_for_node(child) }.join(",")
        Digest::SHA1.hexdigest("#{node.name}+#{children_hashes}")
      end

    end
  end
end
