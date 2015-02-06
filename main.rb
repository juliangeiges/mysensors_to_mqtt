require 'bundler/setup'
require 'logger'
require 'settingslogic'
$pwd  = File.dirname(File.expand_path(__FILE__))

require_relative 'lib/message'
require_relative 'lib/mqtt'
require_relative 'lib/mysensors_serial'
require_relative 'models/node'




$logger = Logger.new( $pwd + '/logs/mysensors_to_mqtt.log', 'weekly')
class Settings < Settingslogic
  source ($pwd + "/config/config.yml")
end
original_formatter = Logger::Formatter.new
$logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}
$logger.level = Logger.const_get Settings.main.logger_level


# begin 
    mqtt = Mqtt.new(Settings.mqtt)
    while !mqtt.connected?
        sleep 1
    end
    serial = MysensorsSerial.new(Settings.serial, mqtt)
    serial.reader
    while !serial.ready?
        sleep 1
    end
    mqtt.serial = serial

    mqtt.get

    loop do 
        sleep 1
    end
    

# rescue Interrupt
#     serial.close_connection
#     $logger.close
# rescue Exception => e
#     puts e
#     #$logger.error(e)
#     serial.close_connection if $serial
#     #$logger.close if $logger
# end

