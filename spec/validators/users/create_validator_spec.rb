# frozen_string_literal: true

require 'rails_helper'

describe Users::CreateValidator, type: :validator do
  subject(:validator) { described_class.new }

  describe '#validate' do
    subject(:validate) { validator.validate(params) }

    let(:params) do
      {
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    end

    let(:first_name) { 'Test' }
    let(:last_name) { 'User' }
    let(:email) { 'test@example.com' }
    let(:password) { 'Password123' }
    let(:password_confirmation) { 'Password123' }

    it 'does not raise any validation errors' do
      expect { validate }.not_to raise_error
    end

    context 'with empty first name' do
      let(:first_name) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with empty last name' do
      let(:last_name) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with empty email' do
      let(:email) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with used email' do
      before { User.create!(email: email) }

      it_behaves_like 'failing validation'
    end

    context 'with invalid email format' do
      let(:email) { 'invalid_email' }

      it_behaves_like 'failing validation'
    end

    context 'with empty password' do
      let(:password) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with empty password and password confirmation' do
      let(:password) { '' }
      let(:password_confirmation) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with password confirmation different than the password' do
      let(:password_confirmation) { 'Asdf123' }

      it_behaves_like 'failing validation'
    end
  end
end
