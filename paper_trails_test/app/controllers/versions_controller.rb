class VersionsController < ApplicationController
  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy!
    end
    redirect_to :back, notice: "#{@version.event} を取り消しました"
  end
end
