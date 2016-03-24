faker    = require 'faker'
fs = require 'fs'
path = require 'path'

module.exports =
  activate: (state) ->
    @commandsJson = {}
    fs.readFile path.resolve(__dirname, '..', 'commands.json'),
    (error, content) =>
      @commandsJson = JSON.parse content
      for className of @commandsJson.commands
        for commandName of @commandsJson.commands[className]
          console.log(className, commandName)
          createCommands(className, commandName)

createCommands = (className, commandName) ->
  @commands = atom.commands.add 'atom-workspace',
  "faker:-#{className}-#{commandName}", ->
    @commandsJson = {}
    fs.readFile path.resolve(__dirname, '..', 'commands.json'),
    (error, content) =>
      @commandsJson = JSON.parse content
      editor = atom.workspace.getActiveTextEditor()
      fn     = @commandsJson.commands[className][commandName]
      editor.insertText faker[className][fn]()
