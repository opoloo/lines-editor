editor =
  cm: ''
  default_value: '# New document\n\nStart writing your story here...'

  init: (selector, theme = 'light') ->
    @bind_events()
    @load_documents()

    @cm = CodeMirror($(selector)[0],
      value: @default_value
      mode:
        name: 'markdown'
        highlightFormatting: true
      lineWrapping: true
      tabSize: 2
      theme: 'lines-' + theme
    )

  bind_events: ->
    $(document).on 'click', '.btn-action', (e) ->
      action = $(this).data('action')
      switch action
        when 'new'
          editor.new_document()
        when 'save'
          editor.save_document()

    $(document).on 'change', '.documents', (e) ->
      editor.load_document $(this).val()

    $(document).on 'change', '.font-size', (e) ->
      editor.set_font_size $(this).val()

    $(document).on 'change', '.theme', (e) ->
      editor.set_theme $(this).val()

  new_document: ->
    # Clear editor
    @cm.setValue(@default_value)
    @cm.clearHistory()
    # Set document selection to new doc
    $(".documents").val("new")

  load_document: (id) ->
    if id is "new"
      @new_document()
    else
      @cm.setValue(JSON.parse(localStorage.getItem(id)).content)

  set_font_size: (size) ->
    $('.CodeMirror').css "font-size", size + "px"

  set_theme: (theme) ->
    @cm.setOption 'theme', theme
    $('#editor').removeClass("lines-light")
    $('#editor').removeClass("lines-dark")
    $('#editor').addClass(theme)

  load_documents: ->
    documents = []
    keys = Object.keys localStorage
    i = 0

    # Read all saved documents from localStorage
    while i < keys.length
      documents.push JSON.parse(localStorage.getItem(keys[i]))
      i++

    # Parse each file and insert it into file-selection
    $.each documents, (key, doc) ->
      $(".actions .documents").append('<option value="' + documents[key].id + '">' + documents[key].title + '</option>')

  save_document: ->
    # Ask for docname
    docname = prompt('Please name your document', 'New document')

    if docname
      # Unique File ID
      doc_id = @generate_uuid()

      # Create new file object
      doc =
        id: doc_id
        created_at: Date.now()
        updated_at: Date.now()
        title: docname
        content: @cm.getValue()

      # Save file object to localStorage
      localStorage.setItem(doc_id, JSON.stringify(doc))
      alert 'File successfully saved.'

  generate_uuid: ->
    `var uuid`
    chars = '0123456789abcdef'.split('')
    uuid = []
    rnd = Math.random
    r = undefined
    i = 0
    uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-'
    uuid[14] = '4' # version 4
    while i < 36
      if !uuid[i]
        r = 0 | rnd() * 16
        uuid[i] = chars[if i == 19 then r & 0x3 | 0x8 else r & 0xf]
      i++
    uuid.join ''
    
window.editor = editor