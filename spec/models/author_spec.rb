require 'rails_helper'

RSpec.describe Author, type: :model do
  # Association Test
  describe 'associations' do
    it { is_expected.to have_many(:books) }
  end
end
