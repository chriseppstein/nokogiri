require "helper"

module Nokogiri
  module XML
    class TestXID < Nokogiri::TestCase

      def test_same_elements_in_same_html_doc_with_no_attributes_and_no_content_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div></div><div></div></body></html>"
        node1 = doc.at_xpath("//div[position()=1]")
        node2 = doc.at_xpath("//div[position()=2]")

        # assert on setup
        assert_not_equal node1, node2
        assert_not_equal node1.object_id, node2.object_id
        assert_equal node1.document, node2.document

        assert_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_same_elements_in_different_html_docs_with_no_attributes_and_no_content_have_equal_xid_hashes
        doc1 = Nokogiri::HTML "<html><body><div></div>/body></html>"
        doc2 = Nokogiri::HTML "<html><body><div></div>/body></html>"
        node1 = doc1.at_xpath("//div")
        node2 = doc2.at_xpath("//div")

        # assert on setup
        assert_not_equal node1, node2
        assert_not_equal node1.object_id, node2.object_id
        assert_not_equal node1.document, node2.document

        assert_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_different_elements_do_not_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div></div><em></em></body></html>"
        node1 = doc.at_xpath("//div")
        node2 = doc.at_xpath("//em")

        assert_not_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_same_elements_with_no_attributes_but_different_children_do_not_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div><span></span></div><div><em></em></div></body></html>"
        node1 = doc.at_xpath("//div[position()=1]")
        node2 = doc.at_xpath("//div[position()=2]")

        assert_not_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_same_elements_with_no_attributes_but_different_grandchildren_do_not_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div><span><em></em></span></div><div><span><b></b></span></div></body></html>"
        node1 = doc.at_xpath("//div[position()=1]")
        node2 = doc.at_xpath("//div[position()=2]")

        assert_not_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_same_element_with_different_attributes_do_not_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div class='1' size='large'></div><div size='medium' class='2'></div></body></html>"
        node1 = doc.at_xpath("//div[position()=1]")
        node2 = doc.at_xpath("//div[position()=2]")

        assert_not_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

      def test_same_element_with_hacked_attributes_do_not_have_equal_xid_hashes
        doc = Nokogiri::HTML "<html><body><div class='1' size='large'></div><div size='large,class=1'></div></body></html>"
        node1 = doc.at_xpath("//div[position()=1]")
        node2 = doc.at_xpath("//div[position()=2]")

        assert_not_equal Nokogiri::XML::XID.new(node1).hash, Nokogiri::XML::XID.new(node2).hash
      end

    end
  end
end
