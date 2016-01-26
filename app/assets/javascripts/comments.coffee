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

  # 在book详情页里读取comments列表
  $page_book = jQuery('.page-book')
  if $page_book.length > 0
    book_id = $page_book.data('book-id')
    api.routes.book_comments(book_id).get()
      .done (res)->
        tmp = ''
        res.map (comment)->
          comment_id = comment._id.$oid
          tmp += "<tr></tr>"
          tmp += "<td>#{comment.body}</td>"
          tmp += "<td><a href='#{api.routes.comment(comment_id)}'>Show</a></td>"
          tmp += "<td><a href='#{api.routes.comment(comment_id)}/edit'>Edit</a></td>"
          tmp += "<td><a class='destory' href='javascript:;' data-id='#{comment_id}'>Destroy</a></td>"

        $page_book.find('tbody').html(tmp)
      .fail (res)->
        console.log res
