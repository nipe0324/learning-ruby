describe "Foo", ->
  beforeEach ->
    @foo = new Foo("Taro")

  it "is first test", ->
    expect(@foo.greet()).toBe "Hello, Taro"
