# frozen_string_literal: true

class ApplicationValidator < Dry::Validation::Contract
  def validate(params)
    validation_errors = call(params).errors.to_h
    return if validation_errors.blank?

    raise ValidationError, validation_errors
  end
end
