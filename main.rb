require 'bundler/setup'
require 'logger'
require 'settingslogic'

require_relative 'lib/mysensors_serial'
require_relative 'models/node'

$pwd  = File.dirname(File.expand_path(__FILE__))
$logger = Logger.new('logs/mysensors_to_mqtt.log', 'weekly')
class Settings < Settingslogic
  source ($pwd + "/config/config.yml")
end
original_formatter = Logger::Formatter.new
$logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}
$logger.level = Logger.const_get Settings.main.logger_level

# node =  Node.new("lol", "blub", "Fucker")
# node.save!
# puts Node.all.map {|x| x.id}

begin 

    serial = MysensorsSerial.new(Settings.serial)

    serial.reader
    

rescue Interrupt
    serial.close_connection
    logger.close
rescue Exception => e
    puts e
    $logger.error(e)
end

