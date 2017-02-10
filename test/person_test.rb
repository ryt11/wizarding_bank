require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class TestPerson < Minitest::Test
  def test_does_person_exist_with_money
    person1 = Person.new("Ronald", 500)
    assert_instance_of Person, person1
    assert_equal 500, person1.galleons
  end
end
