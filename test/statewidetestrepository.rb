gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewidetestrepository'

class StateWideTestRepositoryTest < Minitest::Test

  def test_init
    std = StateWideTestRepository.new
    assert_instance_of StateWideTestRepository, std
  end
end
