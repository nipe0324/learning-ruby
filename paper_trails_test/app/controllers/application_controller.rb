class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def revert_link
      view_context.link_to('取消', revert_version_path(@product.versions.last), :method => :post)
    end

end
