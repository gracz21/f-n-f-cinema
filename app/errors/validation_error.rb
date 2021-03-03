# frozen_string_literal: true

class ValidationError < StandardError
  attr_reader :validation_errors

  def initialize(validation_errors)
    @validation_errors = validation_errors
    super('Validation failed')
  end
end
