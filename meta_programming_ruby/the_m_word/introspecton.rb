class Greeting
  def initialize(text)
    @text = text
  end

  def welcome
    @text
  end
end

my_obj = Greeting.new("Hello")
p my_obj.class
#=> Greeting

p my_obj.class.instance_methods(false)
#=> [:welcome]

p my_obj.instance_variables
#=> [:@text]
