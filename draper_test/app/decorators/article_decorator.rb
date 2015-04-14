class ArticleDecorator < Draper::Decorator
  delegate_all
  decorates_association :author
  decorates_finders

  def posted_at
    h.content_tag :span, class: 'time' do
      model.created_at.strftime("%Y/%m/%d %H:%m")
    end
  end

  def emphatic
    h.content_tag(:strong, "Awesome")
    #=> <strong>Awesome</strong>
  end

  def sub_view
    h.render 'sub_view', title: model.title
    # articles/sub_view
  end
end
