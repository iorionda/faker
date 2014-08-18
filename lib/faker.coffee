faker    = require 'faker'
commands = require './commands'

module.exports =
  activate: (state) ->
    for className of commands
      for commandName of commands[className]
        createCommands(className, commandName)

createCommands = (className, commandName) ->
  atom.workspaceView.command "faker:-#{className}-#{commandName}", ->
    editor = atom.workspace.getActiveEditor()
    fn     = commands[className][commandName]

    editor.insertText faker[className][fn]()
