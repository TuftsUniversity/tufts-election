class Party
  attr_reader :id, :name, :description

  @parties = {}

  def initialize(attrs = {})
    @id = attrs.fetch(:id)
    @name = attrs.fetch(:name)
    @description = attrs.fetch(:description, '')
  end

  def self.register(party_attrs)
    @parties[party_attrs.fetch(:name)] = new(party_attrs)
  end

  def self.find(party_id)
    @parties[party_id.to_s]
  end
end

