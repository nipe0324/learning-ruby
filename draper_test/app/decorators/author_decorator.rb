class AuthorDecorator < Draper::Decorator
  delegate_all

  def hoge
    model.name + "hogehoge"
  end
end
