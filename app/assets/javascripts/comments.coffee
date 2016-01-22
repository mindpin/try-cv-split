show_errors = ($form, errors)->
  $err_tips = jQuery "<div class='error-tips' style='color:red;'></div>"
  for field, tips of errors
    for tip in tips
      $err_tips.append "<div>#{field}:#{tip}</div>"
  $form
    .find('.error-tips').remove().end()
    .append $err_tips

jQuery(document).on 'ready page:change', ->
  $new_form = jQuery('form.new_comment')
  $edit_form = jQuery('form.edit_comment')

  # 创建
  $new_form.on 'click', 'a.create-submit', (evt)->
    book_id = $new_form.data('book-id')
    data = $new_form.serialize()
    api.routes.book_comments(book_id).post(data)
      .done (res)->
        api.routes.comment(res).visit()
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors $new_form, errors

  # 修改
  $edit_form.on 'click', 'a.update-submit', (evt)->
    data = jQuery('form.edit_comment').serialize()
    comment_id = jQuery(this).data('id')
    api.routes.comment(comment_id).put(data)
      .done (res)->
        api.routes.comment(res).visit()
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors $edit_form, errors

  # 删除
  jQuery('table.comments').on 'click', 'a.destory', ->
    if confirm 'Are you sure?'
      comment_id = jQuery(this).data('id')
      api.routes.comment(comment_id).delete()
        .done =>
          jQuery(this).closest('tr').remove()

