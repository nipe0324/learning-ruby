class CreateHoges < ActiveRecord::Migration
  def change
    create_table :hoges do |t|
      t.integer :int2, limit: 2 # smallint型
      t.integer :int4, limit: 4 # integer型
      t.integer :int            # integer型
      t.integer :int8, limit: 8 # bigint型

      t.decimal :decimal, precision: 10, scale: 2 # decimal/numeric(10,2)型

      t.float :real, limit: 4   # real型
      t.float :double_precision # double precision型

      t.money :money # money型

      t.string :str                # character varying型
      t.string :str128, limit: 128 # character varying(128)型
      t.text   :text               # text型

      t.datetime  :datetime  # timestamp without time zone型
      t.timestamp :timestamp # timestamp without time zone型
      t.timestamp :timestamp # timestamp without time zone型
      t.time      :time      # date型
      t.date      :date      # time without time zone型
      t.column    :duration, :interval # interval型
      t.column :timestamp_with_tz, 'timestamp with time zone'
      t.column :time_with_tz,      'time with time zone'


      t.boolean   :bool # boolean型

      t.timestamps null: false # created_atとupdated_atを作成
    end
  end
end
