class Person
  attr_accessor :galleons
  attr_reader :name
  def initialize(name, galleons)
    @name = name
    @galleons = galleons
  end
end
