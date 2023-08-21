# frozen_string_literal: true
class State
  attr_reader :name, :history, :bibliography

  @states = {}

  def initialize(attrs = {})
    @name = attrs.fetch(:name)
    @history = attrs.fetch(:history, '')
    @bibliography = attrs.fetch(:bibliography, '')
  end

  def self.register(state_attrs)
    @states[state_attrs.fetch(:name)] = new(state_attrs)
  end

  def self.find(name)
    @states[name.to_s]
  end
end
