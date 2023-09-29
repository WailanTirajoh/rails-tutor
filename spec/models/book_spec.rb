require 'rails_helper'

RSpec.describe Book, type: :model do
  # Association Test
  describe 'associations' do
    it { is_expected.to belong_to(:author) }
  end
end
