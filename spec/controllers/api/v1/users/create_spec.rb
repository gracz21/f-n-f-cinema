# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Users::Create, type: :request do
  subject(:call) { post endpoint, params: params }

  let(:endpoint) { '/api/v1/users' }
  let(:params) do
    {
      'first_name' => 'Test',
      'last_name' => 'User',
      'email' => 'test@example.com',
      'password' => 'Password123',
      'password_confirmation' => 'Password123'
    }
  end

  let(:new_user) { User.last }

  let(:expected_response) do
    {
      'data' => {
        'id' => new_user.id.to_s,
        'type' => 'user',
        'attributes' => {
          'first_name' => 'Test',
          'last_name' => 'User',
          'email' => 'test@example.com'
        }
      }
    }
  end

  it 'responds with 201 status' do
    call
    expect(response).to have_http_status(201)
  end

  it 'creates a new user' do
    expect { call }.to change(User, :count).by(1)
  end

  it 'creates a new user without cinema worker permissions' do
    call
    expect(new_user.role?(UserRoles::CINEMA_WORKER)).to be_falsey
  end

  it 'creates a new user with given params' do
    call
    expect(new_user.attributes).to include(params.except('password', 'password_confirmation'))
  end

  it 'returns new user params serialized to JSON' do
    call
    expect(JSON.parse(response.body)).to match(expected_response)
  end

  context 'with invalid params' do
    let(:params) do
      {
        first_name: 'Test',
        last_name: 'User',
        email: 'test@example.com',
        password: 'Password123',
        password_confirmation: 'Password'
      }
    end

    it 'responds with 422 status' do
      call
      expect(response).to have_http_status(422)
    end
  end
end
