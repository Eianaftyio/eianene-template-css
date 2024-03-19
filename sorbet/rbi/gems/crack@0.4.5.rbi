# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `crack` gem.
# Please instead update this file by running `bin/tapioca gem crack`.

module Crack; end

class Crack::REXMLParser
  class << self
    def parse(xml); end
  end
end

class Crack::XML
  class << self
    def parse(xml); end
    def parser; end
    def parser=(parser); end
  end
end

class REXMLUtilityNode
  def initialize(name, normalized_attributes = T.unsafe(nil)); end

  def add_node(node); end
  def attributes; end
  def attributes=(_arg0); end
  def children; end
  def children=(_arg0); end
  def inner_html; end
  def name; end
  def name=(_arg0); end
  def to_hash; end
  def to_html; end
  def to_s; end
  def type; end
  def type=(_arg0); end
  def typecast_value(value); end
  def undasherize_keys(params); end

  private

  def unnormalize_xml_entities(value); end

  class << self
    def available_typecasts; end
    def available_typecasts=(obj); end
    def typecasts; end
    def typecasts=(obj); end
  end
end

class REXMLUtiliyNodeString < ::String
  def attributes; end
  def attributes=(_arg0); end
end
