class User < ActiveRecord::Base
  attr_writer :last_name, :first_name
  attr_accessor :new_group_name

  belongs_to :group

  validates :name,       presence: true
  validates :last_name,  presence: true
  validates :first_name, presence: true

  before_validation :set_name
  before_validation :build_group

  def last_name
    @last_name || self.name.split(" ").first if self.name.present?
  end

  def first_name
    @first_name || self.name.split(" ").last if self.name.present?
  end

  def set_name
    self.name = [@last_name, @first_name].join(" ")
  end

  def build_group
    return if new_group_name.blank?

    @group = Group.new name: new_group_name
    if @group.valid?
      self.group = @group
    else
      @group.errors.each do |_, message|
        errors.add :new_group_name, message
      end
    end
  end
end
