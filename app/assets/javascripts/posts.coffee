jQuery(document).on 'ready page:load', ->

  show_errors = ($form, errors)->
    $err_tips = jQuery "<div class='error-tips' style='color:red;'></div>"
    for field, tips of errors
      for tip in tips
        $err_tips.append "<div>#{field}:#{tip}</div>"
    $form
      .find('.error-tips').remove().end()
      .append $err_tips

  # 创建
  jQuery('form.new_post').on 'click', 'a.create-submit', (evt)->
    data = jQuery('form.new_post').serialize()
    api.resource('post')
      .create data
      .done (res)->
        Turbolinks.visit api.resource('post').show(res.post)
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors jQuery('form.new_post'), errors

  # 修改
  jQuery('form.edit_post').on 'click', 'a.update-submit', (evt)->
    data = jQuery('form.edit_post').serialize()
    post_id = jQuery('form.edit_post a.update-submit').data('id')

    api.resource('post')
      .update {id: post_id}, data
      .done (res)->
        Turbolinks.visit api.resource('post').show(res.post)
      .fail (res)->
        errors = JSON.parse res.responseText
        show_errors jQuery('form.edit_post'), errors

  # 删除
  jQuery('table.posts').on 'click', 'a.destory', ->
    if confirm 'Are you sure?'
      post_id = jQuery(this).data('id')
      api.resource('post')
        .destory {id: post_id}
        .done =>
          jQuery(this).closest('tr').remove()