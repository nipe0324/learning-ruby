class Letter < ActiveRecord::Base
  def deliver
    sleep 10 # 処理に時間がかかることを擬似的に実施
    update(delivered_at: Time.zone.now)
  end
end
