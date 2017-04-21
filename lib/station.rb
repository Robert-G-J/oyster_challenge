class Station

  attr_reader :name, :zone

  def initialize(args={})
    args = defaults.merge(args)
    @name = args[:name]
    @zone = args[:zone]
  end

  def defaults
    {
    name: "Unnamed Station",
    zone: 2
  }
  end

end
