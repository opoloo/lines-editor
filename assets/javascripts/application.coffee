editor =
  cm: ''
  default_value: '# The Surveillance State and the Problems that will affect our Future\n\nIt should be the purpose of an state to give its citizens as much freedom as possible, while at the same time protecting them from harm. Freedom involves certain risks, so security means the loss of certain freedoms. In a democratic state, the concepts of freedom and security must therefore be balanced out against each other.\n\n# 9/11 and the Patriot Act that resultet after the Destruction of the World Trade Center\n\nThe term \'surveillance state\' describes a form of goverment that attacks and records locations, conversations, and connections between its citizens. This manner of imposing control will eventually influence how people act, which imposes boundaries on privacy.'

  init: (selector, theme = 'light') ->
    @bind_events()
    @load_files()

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
          editor.new_file()
        when 'save'
          editor.save_file()

    $(document).on "change", ".files", (e) ->
      editor.load_file($(this).val())

  new_file: ->
    @cm.setValue('')
    @cm.clearHistory()

  load_file: (id) ->
    @cm.setValue(JSON.parse(localStorage.getItem(id)).content)

  load_files: ->
    files = []
    keys = Object.keys localStorage
    i = 0

    # Read all saved files from localStorage
    while i < keys.length
      files.push JSON.parse(localStorage.getItem(keys[i]))
      i++

    # Parse each file and insert it into file-selection
    $.each files, (key, file) ->
      $(".actions .files").append('<option value="' + files[key].id + '">' + files[key].title + '</option>')

  save_file: ->
    # Ask for filename
    filename = prompt('Please name your document', 'New document')

    # If filename is not set, set it to default
    if filename == ''
      filename = 'New document'

    # Unique File ID
    file_id = @generate_uuid()

    # Create new file object
    file =
      id: file_id
      created_at: Date.now()
      updated_at: Date.now()
      title: filename
      content: @cm.getValue()

    # Save file object to localStorage
    localStorage.setItem(file_id, JSON.stringify(file))
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