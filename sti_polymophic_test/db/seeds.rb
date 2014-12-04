%w(Celeron Corei5 Xeno).each { |name| Cpu.create! name: name }
%w(Lenobo HB TOSHIBO).each { |name| Maker.create! name: name }
%w(田中 加藤 佐藤).each { |name| Author.create! name: name }
