#http://subtech.g.hatena.ne.jp/secondlife/20120305/1330954426

def pbcopy(str)
  IO.popen('pbcopy', 'r+') {|io| io.puts str }
  output.puts "-- Copy to clipboard --\n#{str}"
end

Pry.config.commands.command "hiscopy", "History copy to clipboard" do |n|
  pbcopy _pry_.input_array[n ? n.to_i : -1]
end

Pry.config.commands.command "copy", "Copy to clipboard" do |str|
  unless str
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n"
  end
  pbcopy str
end

Pry.config.commands.command "lastcopy", "Last result copy to clipboard" do
  pbcopy _pry_.last_result.chomp
end

## Settings
Pry.config.color = true
Pry.config.editor = "vim"

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

## Alias
Pry.config.commands.alias_command "lM", "ls -M"
# Ever get lost in pryland? try w!
Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.clr', '.clear'


## Below others cooperation

# refs: https://github.com/pry/pry/wiki/FAQ#wiki-awesome_print
if defined? AwesomePrint
  begin
    require 'awesome_print'
    Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
    # Pry.config.print = proc { |output, value| output.puts value.ai } #ページングなし
  rescue LoadError => err
    puts "no awesome_print :("
    puts err
  end
end

if defined?(PryDebugger) || defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry.config.commands.command(/^$/, "repeat last command") do
  _pry_.run_command Pry.history.to_a.last
end

if defined?(FactoryGirl)
  include FactoryGirl::Syntax::Methods
end

# vim: set filetype=ruby :
