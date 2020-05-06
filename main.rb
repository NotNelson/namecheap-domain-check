# A simple way to check available .COM's (in first instance)
# NameCheap API + DataMuse for word generation.
# 02/06/2019
require_relative 'functions'

if ARGV.length < 1
  puts 'You need help.' + '

== Check manually ==

To input manual domain names and check for availability
use the -s flag and input a comma separated list of do-
main names after.

╔═════════════════════════════════════════════════════╗
║ eg: '.colorize(:yellow) + './main.rb' + ' -s '.colorize(:red) + '"test1.com, test2.net, test3.org"'.colorize(:green) + '  ║
╚═════════════════════════════════════════════════════╝

== Generate domains ==

To generate a list of domain names and check availabil-
ity use the -g flag and input a first word to  be  used
as a fixed portion of the generated URL and a second w-
ord to create additional words by association.  Finally
use  the -e flag and input a top level domain to  check
availability.

╔═════════════════════════════════════════════════════╗
║ eg: '.colorize(:yellow) + './main.rb' + ' -g '.colorize(:red) + '"secret" "words"'.colorize(:green) + ' -e '.colorize(:red) + 'com'.colorize(:green) + '            ║
╚═════════════════════════════════════════════════════╝'.colorize(:yellow)
  exit
end

puts "
▄█     █▄      ███        ▄████████ ████████▄  ███▄▄▄▄
███     ███ ▀█████████▄   ███    ███ ███   ▀███ ███▀▀▀██▄
███     ███    ▀███▀▀██   ███    █▀  ███    ███ ███   ███
███     ███     ███   ▀  ▄███▄▄▄     ███    ███ ███   ███
███     ███     ███     ▀▀███▀▀▀     ███    ███ ███   ███
███     ███     ███       ███        ███    ███ ███   ███
███ ▄█▄ ███     ███       ███        ███   ▄███ ███   ███
 ▀███▀███▀     ▄████▀     ███        ████████▀   ▀█   █▀

" + "WTF Domain Name".colorize(:light_green) + "
A  domain  name  generator and checker  for  busy  souls.
=========================================================
"

if ARGV[0] == "-s"
  domains = ARGV[1]
  check_availability(domains.gsub(' ', ''))
elsif ARGV[0] == "-g"
  if ARGV[ARGV.count - 2] == '-e'
    extension = ARGV[ARGV.count - 1]
  else
    extension = 'com'
  end
  word = ARGV[1]
  concept = ARGV[2]
  generate_names(word, concept, extension)
else
  exit
end
