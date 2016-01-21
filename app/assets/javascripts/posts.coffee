jQuery(document).on 'ready page:load', ->

  # 创建
  jQuery('form.new_post').on 'click', 'a.create-submit', (evt)->
    data = jQuery('form.new_post').serialize()
    jQuery.ajax
      type: 'post'
      url: api.post.create
      data: data
    .done (res)->
      Turbolinks.visit api.post.show(res.post)
    .fail (res)->
      errors = JSON.parse res.responseText
      $err_tips = jQuery "<div class='error-tips' style='color:red;'></div>"
      for field, tips of errors
        for tip in tips
          $err_tips.append "<div>#{field}:#{tip}</div>"
      jQuery('form.new_post')
        .find('.error-tips').remove().end()
        .append $err_tips

  # 修改
  jQuery('form.edit_post').on 'click', 'a.update-submit', (evt)->
    data = jQuery('form.edit_post').serialize()
    post_id = jQuery('form.edit_post a.update-submit').data('id')
    jQuery.ajax
      type: 'put'
      url: api.post.update post_id
      data: data
    .done (res)->
      Turbolinks.visit api.post.show(res.post)
    .fail (res)->
      errors = JSON.parse res.responseText
      $err_tips = jQuery "<div class='error-tips' style='color:red;'></div>"
      for field, tips of errors
        for tip in tips
          $err_tips.append "<div>#{field}:#{tip}</div>"
      jQuery('form.edit_post')
        .find('.error-tips').remove().end()
        .append $err_tips

  # 删除
  jQuery('table.posts').on 'click', 'a.destory', ->
    if confirm 'Are you sure?'
      post_id = jQuery(this).data('id')
      jQuery.ajax
        type: 'delete'
        url: api.post.destory post_id
      .done =>
        jQuery(this).closest('tr').remove()

