show_errors = ($form, errors)->
  $err_tips = jQuery "<div class='error-tips' style='color:red;'></div>"
  for field, tips of errors
    for tip in tips
      $err_tips.append "<div>#{field}:#{tip}</div>"
  $form
    .find('.error-tips').remove().end()
    .append $err_tips

jQuery(document).on 'ready page:change', ->
  $new_form = jQuery('form.new_post')
  $edit_form = jQuery('form.edit_post')

  # 创建
  $new_form.on 'click', 'a.create-submit', (evt)->
    data = $new_form.serialize()
    api.routes.posts().post(data)
      .done (res)->
        api.routes.post(res).visit()
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors $new_form, errors

  # 修改
  $edit_form.on 'click', 'a.update-submit', (evt)->
    data = jQuery('form.edit_post').serialize()
    post_id = jQuery(this).data('id')
    api.routes.post(post_id).put(data)
      .done (res)->
        api.routes.post(res).visit()
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors $edit_form, errors

  # 删除
  jQuery('table.posts').on 'click', 'a.destory', ->
    if confirm 'Are you sure?'
      post_id = jQuery(this).data('id')
      api.routes.post(post_id).delete()
        .done =>
          jQuery(this).closest('tr').remove()
