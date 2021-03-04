# frozen_string_literal: true

module API
  module V1
    module ShowTimes
      class Destroy < Grape::API
        desc '[Cinema worker only] Destroy given show time',
             success: { code: 204, message: 'Show time destroyed' },
             failure: [
               { code: 401, message: 'User is not authenticated' },
               { code: 403, message: 'User is not authorized to destroy a show time' },
               { code: 404, message: 'Show time to destroy not found' }
             ]

        before { authenticate_user! }

        delete do
          authorize show_time, :destroy?

          show_time.destroy!

          status :no_content
        end
      end
    end
  end
end
