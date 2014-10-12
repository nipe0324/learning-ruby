class Api::BaseController < ApplicationController
  before_action :authenticate_user!

  private

    def permission_denied
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
end
