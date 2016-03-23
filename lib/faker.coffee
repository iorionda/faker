faker    = require 'faker'
commands = require './commands'

module.exports =
  activate: (state) ->
    for className of commands
      for commandName of commands[className]
        createCommands(className, commandName)
  deactivate: ->
    @commands.dispose()

createCommands = (className, commandName) ->
  @commands = atom.commands.add 'atom-workspace',
  "faker:-#{className}-#{commandName}", ->
    editor = atom.workspace.getActiveTextEditor()
    fn     = commands[className][commandName]

    editor.insertText faker[className][fn]()
