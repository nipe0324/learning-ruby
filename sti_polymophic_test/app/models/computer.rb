class Computer < Product
  validates :cpu_id,   presence: true
  validates :maker_id, presence: true

def full_name
    "#{name}(#{cpu.name}/#{maker.name})"
  end
end
