require "json"
module Puppet::Parser::Functions
  newfunction(
  :json_reader, :type => :rvalue,
  :doc => "Return a hash from the given JSON file by absolute path filename") do |args|

  raise Puppet::ParseError, ("json_reader: wrong number of arguments (#{args.length}; must be 1)") if args.length != 1
  return JSON.parse(File.read(args[0]))
  end
end
