# frozen_string_literal: true

require 'rails_helper'

describe MovieRating, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:creator).class_name('User').with_foreign_key(:user_id).inverse_of(:ratings) }
  end
end
