require 'optparse'

module Rlogparser
  class CLI
    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :input_file     => 'production.log',
        :ip_addresses => %w(99.48.184.49 99.181.31.201),
        :controllers => %w(CartsController#create CartsController#incremental_cart_add),
        :input_dir => '/mnt/app/shared/log'
      }
      mandatory_options = %w(guid)

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Parses a rails logfile from the Runa Runtime
          Guid must be supplied
          
          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-f", "--input_file=INPUT_FILE", String,
                "Logfile to parse",
                "Default: option[:input_file]") { |arg| options[:input_file] = arg }
        opts.on("-f", "--input_dir=INPUT_DIR", String,
                "Logfile Directory",
                "Default: option[:input_dir]") { |arg| options[:input_dir] = arg }
        opts.on("-g", "--guid=INPUT_DIR", String,
                "Merchant GUID",
                "Default: option[:guid]") { |arg| options[:guid] = arg }
        opts.on("-i", "--ip_addresses=IP_ADDRESSES", String,
                "Comma seprated list of Client IP Address[es] ",
                "Default: option[:ip_addresses]") { |arg| options[:ip_addresses] = arg.split(",") }
        opts.on("-c", "--controllers=CONTROLLERS", String,
                "Comma seprated list of Client IP Address[es] ",
                "Default: option[:controllers]") { |arg| options[:controllers] = arg.split(",") }

        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end


      # do stuff
      stdout.puts "options: #{options.inspect}"
    end
  end
end