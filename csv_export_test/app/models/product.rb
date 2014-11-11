class Product < ActiveRecord::Base
  belongs_to :manufacture
end


# product.attributes
# => {"id"=>1, "name"=>"レコーダー", "price"=>2000, "released_on"=>Sun, 09 Nov 2014,
#     "manufacture_id"=>1, "created_at"=>Tue, 11 Nov 2014 15:57:15 UTC +00:00,
#     "updated_at"=>Tue, 11 Nov 2014 15:57:15 UTC +00:00}

# column_names
# =>  ["id", "name", "price", "released_on", "manufacture_id", "created_at", "updated_at"]

# => [1, "レコーダー", 2000, Sun, 09 Nov 2014, 1, Tue, 11 Nov 2014 15:57:15 UTC +00:00, Tue, 11 Nov 2014 15:57:15 UTC +00:00]
