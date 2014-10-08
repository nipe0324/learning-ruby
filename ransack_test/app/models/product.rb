class Product < ActiveRecord::Base
  belongs_to :carrier

  # デフォルトでは全てのカラム名を返す
  # 許可するカラムの名前をオーバーライドする
  def self.ransackable_attributes auth_object = nil
    %w(name description price)
  end

  # デフォルトは全てのアソシエーション名を返す
  # 許可する関連の配列をオーバーライドする
  def self.ransackable_associations auth_object = nil
    %w(carrier)
  end
end
