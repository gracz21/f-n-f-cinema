# frozen_string_literal: true

shared_examples 'failing validation' do
  it 'raises a validation error' do
    expect { validate }.to raise_error(ValidationError)
  end
end
