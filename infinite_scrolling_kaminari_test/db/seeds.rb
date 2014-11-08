1000.times do |i|
  Shop.create!(
    name:    "店名#{i}",
    zipcode: "111-#{sprintf("%04d", i)}",
    address: "住所#{i}",
    tel:     "00-1234-#{sprintf("%04d", i)}"
  )
end
