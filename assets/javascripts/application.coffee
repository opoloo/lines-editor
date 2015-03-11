#window.onload = ->
  #editor.init "editor"

editor =
  cm: ""
  default_value: "# The Surveillance State and the Problems that will affect our Future\n\nIt should be the purpose of an state to give its citizens as much freedom as possible, while at the same time protecting them from harm. Freedom involves certain risks, so security means the loss of certain freedoms. In a democratic state, the concepts of freedom and security must therefore be balanced out against each other.\n\n# 9/11 and the Patriot Act that resultet after the Destruction of the World Trade Center\n\nThe term 'surveillance state' describes a form of goverment that attacks and records locations, conversations, and connections between its citizens. This manner of imposing control will eventually influence how people act, which imposes boundaries on privacy."

  init: (selector, theme = 'light') ->
    @cm = CodeMirror(document.getElementById(selector),
      value: @default_value
      mode:
        name: "markdown"
        highlightFormatting: true
      lineWrapping: true
      tabSize: 2
      theme: "lines-" + theme
    )
    
window.editor = editor