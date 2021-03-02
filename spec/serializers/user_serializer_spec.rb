# frozen_string_literaL: true

require 'rails_helper'

describe UserSerializer, type: :serializer do
  subject(:serializer) { described_class.new(user) }

  let(:user) do
    User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email
    )
  end

  let(:first_name) { 'Test' }
  let(:last_name) { 'User' }
  let(:email) { 'test@user.com' }

  describe '#as_json' do
    subject(:as_json) { serializer.as_json }

    describe 'data' do
      subject(:data) { as_json['data'] }

      it 'contains correct type' do
        expect(data['type']).to eq('user')
      end

      it 'contains correct id' do
        expect(data['id']).to eq(user.id.to_s)
      end

      describe 'attributes' do
        subject(:attributes) { data['attributes'] }

        let(:expected_attributes) do
          {
            'first_name' => first_name,
            'last_name' => last_name,
            'email' => email
          }
        end

        it 'contains episode attributes' do
          expect(attributes).to eq(expected_attributes)
        end
      end
    end
  end
end
