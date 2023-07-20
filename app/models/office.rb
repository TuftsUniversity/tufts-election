# frozen_string_literal: true
class Office
  attr_reader :id, :name, :description

  @offices = {}

  def initialize(attrs = {})
    @id = attrs.fetch(:id)
    @name = attrs.fetch(:name)
    @description = attrs.fetch(:description, '')
  end

  def self.register(office_attrs)
    @offices[office_attrs.fetch(:id)] = new(office_attrs)
  end

  def self.find(office_id)
    @offices[office_id.to_s]
  end
end
