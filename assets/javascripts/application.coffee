window.onload = ->
  editor.init "editor"

editor =
  cm: ""
  default_value: "Type your text here...\n"

  init: (selector) ->
    @cm = CodeMirror(document.getElementById(selector),
      value: @default_value
      mode:
        name: "gfm"
        highlightFormatting: true
      lineWrapping: true
      tabSize: 2
      theme: "lines"
    )