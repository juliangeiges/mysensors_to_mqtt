require 'serialport'

class MysensorsSerial


    def initialize(settings, mqtt)
        @settings = settings
        @serial_port = SerialPort.new(@settings.port, @settings.baudrate, @settings.data_bits, @settings.stop_bits, SerialPort::NONE)
        @mqtt = mqtt
        @ready = false
    end

    def reader
        # @serial_port.gets do |sp|
        #     loop do 
        #         puts sp
        #         puts sp.length
        #         sleep 0.1
        #     end
        # end
        while true do
            message = @serial_port.gets
            $logger.debug(message)
            puts message if @settings.debug
            ($logger.error("non parsable message #{message}") if !Message.new(message,self, @mqtt) ) if message
            sleep 0.2
        end
        
    end

    def send(message)
        @serial_port.puts(message)
    end

    def set_ready
        @ready = true
    end
    def ready?
        @ready
    end


    #close the serial connection
    def close_connection
        puts "closing connection"
        @serial_port.close
    end

    # def init_node_settings
    #     @nodes = {}
    #     file = File.open("#{$pwd}/#{settings.node_settings_file}")

    #     file.close
    # end

    # def write_node_setting(id, )

end