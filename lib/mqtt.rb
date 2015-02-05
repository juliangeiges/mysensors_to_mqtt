require 'mqtt'

class Mqtt

    def initialize(settings)
        @settings = settings
        @broker_header = {
            :host => @settings.broker_ip,
            :port => @settings.broker_port,
            :username => @settings.broker_name,
            :password => @settings.broker_pass
        }
        @client = MQTT::Client.connect(@broker_header)
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
        #todo
    end





end