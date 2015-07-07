$ ->
  $('form').on 'click', '#new_tag_btn', (event) ->
    event.preventDefault()
    tagName = $('form').find('#new_tag_name').val()
    return if tagName.length == 0

    $('form').find('#new_tag_name').val('')
    $field = '<span> +' + tagName +
               '<input type="hidden" name="article[tags][][id]">' +
               '<input type="hidden" name="article[tags][][name]" value="'+tagName+'">' +
             '</span><br/>'

    $('form').find('.tags').append($field)
