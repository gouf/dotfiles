Pry.config.theme = 'pry-cold'

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 's', 'step'
end

begin
  require 'awesome_print'
rescue LoadError
  # Do Nothing
else
  AwesomePrint.pry!
end
