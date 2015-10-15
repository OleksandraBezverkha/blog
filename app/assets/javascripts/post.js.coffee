jQuery ->
  availableTags = $('#q_tags_name_cont').data('autocomplete-source')
  split = (val) ->
    val.split /,\s*/
  extractLast = (term) ->
    split(term).pop()
  $('#q_tags_name_cont').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete('instance').menu.active
      event.preventDefault()
    return
  ).autocomplete
    minLength: 1
    source: (request, response) ->
      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))
      return
    focus: ->
      false
    select: (event, ui) ->
      terms = split(@value)
      terms.pop()
      terms.push ui.item.value
      terms.push ''
      @value = terms.join(', ')
      false