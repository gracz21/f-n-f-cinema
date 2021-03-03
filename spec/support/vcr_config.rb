# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_records'
  c.hook_into :webmock
  c.before_record do |i|
    i.request.headers.delete('Authorization')
    i.request.body.delete('string')
  end
end
