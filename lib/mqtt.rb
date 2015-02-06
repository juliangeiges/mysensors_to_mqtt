require 'mqtt'

class Mqtt
    attr_accessor :serial

    def initialize(settings)
        @settings = settings
        @serial = nil
        @broker_header = {
            :host => @settings.broker_ip,
            :port => @settings.broker_port,
            :username => @settings.broker_name,
            :password => @settings.broker_pass
        }
        @client = MQTT::Client.connect(@broker_header)
    end

    def connected?
        @client.connected?
    end

    def reconnect
        if !@client.connected?
          @client = MQTT::Client.connect(@broker_header)
          sleep 0.5
        end
    end

    def publish(channel, msg)
        published = false
        while !published
          if @client.connected?
            @client.publish(channel, msg)
            published = true
          else
            self.reconnect
          end
          sleep 0.5
        end
    end

    def put(topic, message)
        reconnect
        begin
          @client.publish("#{@settings.client_name}/#{topic}", message)
        rescue Exception => e
          puts "put rescued + #{e}"
        end
    end

    def get
        Thread.new{
            puts "started mqtt getter"
            while true
                reconnect 
                begin
                    @client.get("#{@settings.client_name}/#") do |topic,message|
                        ary = []
                        ary.push(topic)
                        ary.push(message.chomp)
                        $logger.error("non parsable mqtt message #{ary}") if !Message.new(ary,@serial, self, true)
                    end
                
                rescue Exception => e
                  puts "get rescued + #{e}"
                end
                sleep 0.2
            end
        }
    end



end