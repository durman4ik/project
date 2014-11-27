jQuery ($)->
  $(".delete-comment-btn").click (->
    current_comment = $(this).parents("div.comment")
    if confirm "Точно удалить?"
      $.ajax (
        url: $(current_comment).attr("data-scheme-id") + "/comments/" + $(current_comment).attr("data-comment-id"),
        type: "POST",
        data: { _method: "DELETE" },
        success: ->
          current_comment.fadeOut(200)
      )
  )
