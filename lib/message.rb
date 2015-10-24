class Message
    #constants defined acording mysensors api http://www.mysensors.org/download/serial_api_14
    #Type of message sent
    MESSAGE_TYPES = {
        :presentation => 0, #Sent by a node when they present attached sensors. This is usually done in setup() at startup.
        :set => 1, #This message is sent from or to a sensor when a sensor value should be updated
        :req => 2, #Requests a variable value (usually from an actuator destined for controller).
        :internal => 3, #This is a special internal message. See table below for the details
        :stream =>  4,#Used for OTA firmware updates
    }

    #When a presentation message is sent, sub-type has to be set to one the following:
    PRESENTATIONS = {
        :S_DOOR =>      0,   #Door and window sensors
        :S_MOTION =>    1,   #Motion sensors
        :S_SMOKE =>     2,   #Smoke sensor
        :S_LIGHT =>     3,   #Light Actuator (on/off)
        :S_BINARY =>    3,   #Binary device (on/off), Alias for S_LIGHT
        :S_DIMMER =>    4,   #Dimmable device of some kind
        :S_COVER =>     5,   #Window covers or shades
        :S_TEMP =>      6,   #Temperature sensor
        :S_HUM =>       7,   #Humidity sensor
        :S_BARO =>      8,   #Barometer sensor (Pressure)
        :S_WIND =>      9,   #Wind sensor
        :S_RAIN =>      10,  #Rain sensor
        :S_UV =>        11,  #UV sensor
        :S_WEIGHT =>    12,  #Weight sensor for scales etc.
        :S_POWER =>     13,  #Power measuring device, like power meters
        :S_HEATER =>    14,  #Heater device
        :S_DISTANCE =>  15,  #Distance sensor
        :S_LIGHT_LEVEL =>   16,  #Light sensor
        :S_ARDUINO_NODE =>  17,  #Arduino node device
        :S_ARDUINO_REPEATER_NODE => 18,  #Arduino repeating node device
        :S_LOCK =>      19,  #Lock device
        :S_IR =>        20,  #Ir sender/receiver device
        :S_WATER =>     21,  #Water meter
        :S_AIR_QUALITY =>   22,  #Air quality sensor e.g. MQ-2
        :S_CUSTOM =>    23,  #Use this for custom sensors where no other fits.
        :S_DUST =>      24,  #Dust level sensor
        :S_SCENE_CONTROLLER =>  25,  #Scene controller device

        :S_RGB_LIGHT  =>        26,          #RGB light   V_RGB, V_WATT
        :S_RGBW_LIGHT    =>     27,          #RGBW light (with separate white component)  V_RGBW, V_WATT
        :S_COLOR_SENSOR  =>     28,          #Color sensor    V_RGB
        :S_HVAC  =>             29,          #Thermostat/HVAC device  V_HVAC_SETPOINT_HEAT, V_HVAC_SETPOINT_COLD, V_HVAC_FLOW_STATE, V_HVAC_FLOW_MODE, V_HVAC_SPEED
        :S_MULTIMETER    =>     30,          #Multimeter device   V_VOLTAGE, V_CURRENT, V_IMPEDANCE
        :S_SPRINKLER =>         31,          #Sprinkler device    V_STATUS (turn on/off), V_TRIPPED (if fire detecting device)
        :S_WATER_LEAK    =>     32,          #Water leak sensor   V_TRIPPED, V_ARMED
        :S_SOUND =>             33,          #Sound sensor    V_LEVEL (in dB), V_TRIPPED, V_ARMED
        :S_VIBRATION =>         34,          #Vibration sensor    V_LEVEL (vibration in Hz), V_TRIPPED, V_ARMED
        :S_MOISTURE  =>         35,          #Moisture sensor V_LEVEL (water content or moisture in percentage?), V_TRIPPED, V_ARMED
    }

    #When a set or request message is being sent, the sub-type has to be one of the following:
    SET_REQ = {
        :V_TEMP =>      0,   #Temperature
        :V_HUM =>       1,   #Humidity
        :V_STATUS =>     2,   #Light status. 0=off 1=on
        :V_PERCENTAGE =>    3,   #Dimmer value. 0-100%
        :V_PRESSURE =>  4,   #Atmospheric Pressure
        :V_FORECAST =>  5,   #Whether forecast. One of "stable", "sunny", "cloudy", "unstable", "thunderstorm" or "unknown"
        :V_RAIN =>      6,   #Amount of rain
        :V_RAINRATE =>  7,   #Rate of rain
        :V_WIND =>      8,   #Windspeed
        :V_GUST =>      9,   #Gust
        :V_DIRECTION => 10,  #Wind direction
        :V_UV =>        11,  #UV light level
        :V_WEIGHT =>    12,  #Weight (for scales etc)
        :V_DISTANCE =>  13,  #Distance
        :V_IMPEDANCE => 14,  #Impedance value
        :V_ARMED =>     15,  #Armed status of a security sensor. 1=Armed, 0=Bypassed
        :V_TRIPPED =>   16,  #Tripped status of a security sensor. 1=Tripped, 0=Untripped
        :V_WATT =>      17,  #Watt value for power meters
        :V_KWH =>       18,  #Accumulated number of KWH for a power meter
        :V_SCENE_ON =>  19,  #Turn on a scene
        :V_SCENE_OFF => 20,  #Turn of a scene
        :V_HEATER =>    21,  #Mode of header. One of "Off", "HeatOn", "CoolOn", or "AutoChangeOver"
        :V_HEATER_SW => 22,  #Heater switch power. 1=On, 0=Off
        :V_LIGHT_LEVEL =>   23,  #Light level. 0-100%
        :V_VAR1 =>      24,  #Custom value
        :V_VAR2 =>      25,  #Custom value
        :V_VAR3 =>      26,  #Custom value
        :V_VAR4 =>      27,  #Custom value
        :V_VAR5 =>      28,  #Custom value
        :V_UP =>        29,  #Window covering. Up.
        :V_DOWN =>      30,  #Window covering. Down.
        :V_STOP =>      31,  #Window covering. Stop.
        :V_IR_SEND =>   32,  #Send out an IR-command
        :V_IR_RECEIVE =>    33,  #This message contains a received IR-command
        :V_FLOW =>      34,  #Flow of water (in meter)
        :V_VOLUME =>    35,  #Water volume
        :V_LOCK_STATUS =>   36,  #Set or get lock status. 1=Locked, 0=Unlocked
        :V_DUST_LEVEL =>    37,  #Dust level
        :V_VOLTAGE =>   38,  #Voltage level
        :V_CURRENT =>   39,  #Current level

        :V_RGB   =>     40,  #RGB value transmitted as ASCII hex string (I.e "ff0000" for red)    S_RGB_LIGHT, S_COLOR_SENSOR
        :V_RGBW  =>     41,  #RGBW value transmitted as ASCII hex string (I.e "ff0000ff" for red + full white)    S_RGBW_LIGHT
        :V_ID    =>     42,  #Optional unique sensor id (e.g. OneWire DS1820b ids)    S_TEMP
        :V_UNIT_PREFIX   => 43,  #Allows sensors to send in a string representing the unit prefix to be displayed in GUI. This is not parsed by controller! E.g. cm, m, km, inch. S_DISTANCE, S_DUST, S_AIR_QUALITY
        :V_HVAC_SETPOINT_COOL    => 44,  #HVAC cold setpoint  S_HVAC
        :V_HVAC_SETPOINT_HEAT    => 45,  #HVAC/Heater setpoint    S_HVAC, S_HEATER
        :V_HVAC_FLOW_MODE    => 46,  #Flow mode for HVAC ("Auto", "ContinuousOn", "PeriodicOn")   S_HVAC
    }


    # The internal messages are used for different tasks in the communication between sensors, the gateway to controller and between sensors and the gateway.
    # When an internal messages is sent, the sub-type has to be one of the following:
    INTERNALS = {
        :I_BATTERY_LEVEL => 0,   #Use this to report the battery level (in percent 0-100).
        :I_TIME =>          1,   #Sensors can request the current time from the Controller using this message. The time will be reported as the seconds since 1970
        :I_VERSION  =>      2,   #Sensors report their library version at startup using this message type
        :I_ID_REQUEST =>    3,   #Use this to request a unique node id from the controller.
        :I_ID_RESPONSE =>   4,   #Id response back to sensor. Payload contains sensor id.
        :I_INCLUSION_MODE =>    5,   #Start/stop inclusion mode of the Controller (1=start, 0=stop).
        :I_CONFIG =>        6,   #Config request from node. Reply with (M)etric or (I)mperal back to sensor.
        :I_FIND_PARENT =>   7,   #When a sensor starts up, it broadcast a search request to all neighbor nodes. They reply with a I_FIND_PARENT_RESPONSE.
        :I_FIND_PARENT_RESPONSE =>  8,   #Reply message type to I_FIND_PARENT request.
        :I_LOG_MESSAGE =>   9,   #Sent by the gateway to the Controller to trace-log a message
        :I_CHILDREN =>      10,  #A message that can be used to transfer child sensors (from EEPROM routing table) of a repeating node.
        :I_SKETCH_NAME =>   11,  #Optional sketch name that can be used to identify sensor in the Controller GUI
        :I_SKETCH_VERSION =>    12,  #Optional sketch version that can be reported to keep track of the version of sensor in the Controller GUI.
        :I_REBOOT =>        13,  #Used by OTA firmware updates. Request for node to reboot.
        :I_GATEWAY_READY => 14,  #Send by gateway to controller when startup is complete.
    }

    def initialize(message_content, serial, mqtt, output)
        @output = output
        @mqtt = mqtt
        @serial = serial
        @message_content = message_content
        #parse serial message
        if !@output
            @splitted_message = Message.splitt_message(@message_content)
            @node_id = @splitted_message[0]
            @child_sensor_id=  @splitted_message[1]
            @message_type = MESSAGE_TYPES.invert[@splitted_message[2].to_i]
            @ack = @splitted_message[3]
            @sub_type =  sub_type
            @payload = @splitted_message[5]
        #parse mqtt message
        else
            @splitted_message = Message.splitt_mqtt_message(@message_content)
            @node_id = @splitted_message[1]
            @child_sensor_id=  @splitted_message[2]
            @message_type = @splitted_message[3].to_sym #MESSAGE_TYPES.invert[@splitted_message[2].to_i]
            @ack = @splitted_message[4]
            @sub_type =  @splitted_message[5].to_sym
            @payload = @splitted_message[6]
        end

        case @message_type
            when :presentation
                message_presentation
            when :set
                 message_set
            when :req
                 log_because_not_implemented("message_type req", @message_content)
            when :internal
                #log_because_not_implemented("message_type internal", @message_content)
                message_internal
            else
                log_because_not_implemented("message_type", @message_content)
        end 
    end

    def self.new(message_content, serial,  mqtt, output)
        if !output
            if !Message.parseable?(message_content)
                return false
            else
                super(message_content, serial, mqtt, output)
            end
        else
            if !Message.mqtt_parseable?(message_content)
                return false

            else
                super(message_content, serial, mqtt, output )
            end
        end
    end

    def sub_type
        case @message_type
            when :presentation
                PRESENTATIONS.invert[@splitted_message[4].to_i]
            when :set
                SET_REQ.invert[@splitted_message[4].to_i]
            when :req
                SET_REQ.invert[@splitted_message[4].to_i]
            when :internal
                INTERNALS.invert[@splitted_message[4].to_i]
            else
                nil
                log_because_not_implemented("message_type", @message_content)
        end 
    end

    def sub_type_from_string_to_i
        case @message_type
            when :presentation
                PRESENTATIONS[@sub_type]
            when :set
                SET_REQ[@sub_type]
            when :req
                SET_REQ[@sub_type]
            when :internal
                INTERNALS[@sub_type]
            else
                nil
                log_because_not_implemented("message_type", @message_content)
        end 
    end

    def message_presentation
        if @serial.ready? && @output.nil?
            node = Node.get(@node_id.to_i)
            node.set_sub_type(@child_sensor_id.to_i, @sub_type)
            #@mqtt.put("#{@node_id}/#{@child_sensor_id}/presentation", "#{@sub_type}")
            send_mqtt_msg
        end
    end

    def message_set
        if @serial.ready?
            if @output
                send_serial_msg()
            else
                #@mqtt.put("#{@node_id}/#{@child_sensor_id}/set/#{@sub_type}", "#{@payload}" )
                send_mqtt_msg()
            end
        end
    end

    def message_internal
        if !@output
            case @sub_type #message subtype
                when :I_BATTERY_LEVEL
                    #todo
                    # look up node id etc.. and send to mqtt
                    log_because_not_implemented("internal message", @message_content)
                when :I_TIME
                    #todo
                    # don`t know how to implement, never seen a message like this
                    log_because_not_implemented("internal message", @message_content)
                when :I_VERSION
                    #todo
                    # look up node id etc. and send to mqtt
                    log_because_not_implemented("internal message", @message_content)
                when :I_ID_REQUEST    
                    i_id_request() if @serial.ready?
                when :I_ID_RESPONSE
                    # should not an incoming message, therefore no need for implementation here
                    log_because_not_implemented("internal message", @message_content)
                when :I_INCLUSION_MODE
                    # inclution mode needs not to be implemented
                   log_because_not_implemented("internal message", @message_content)
                when :I_CONFIG
                    #todo
                    # answer with metric
                    log_because_not_implemented("internal message", @message_content)
                when :I_FIND_PARENT
                    # no need for implementation
                    log_because_not_implemented("internal message", @message_content)
                when :I_FIND_PARENT_RESPONSE
                    # no need for implementation
                    log_because_not_implemented("internal message", @message_content)
                when :I_LOG_MESSAGE
                    #don`t know how to implement that
                    log_because_not_implemented("internal message", @message_content)
                when :I_CHILDREN
                    # no need for implementation
                    log_because_not_implemented("internal message", @message_content)
                when :I_SKETCH_NAME
                     i_sketch_name if @serial.ready?
                when :I_SKETCH_VERSION
                     i_sketch_version if @serial.ready?
                when :I_REBOOT
                    # at the moment no OTA updates, so no implementation needed
                    log_because_not_implemented("internal message", @message_content)
                when :I_GATEWAY_READY
                    i_gateway_ready
                else
                    $logger.error("unkown internal message: #{@message_content}")
            end
        end

    end




    #internal msg stuff
    def i_id_request
        #@mqtt.put("#{@node_id}/#{@child_sensor_id}/internal/id_request", "")
        send_mqtt_msg()
        node = Node.new()
        node.save!
        send_serial_msg(nil, nil, nil, nil, INTERNALS[:I_ID_RESPONSE], node.id)
        $logger.info("New node has requested an id, has been given #{node.id}")
    end

    def i_id_response
        #@mqtt.put("#{@node_id}/#{@child_sensor_id}/internal/#{@sub_type}", "#{node.id}" )
        send_mqtt_msg(nil, nil, nil, nil, nil, node.id)
    end

    def i_gateway_ready
        @serial.set_ready
        #@mqtt.put("#{@node_id}/#{@child_sensor_id}/internal/#{@sub_type}","")
        send_mqtt_msg
    end

    def i_sketch_name
        node = Node.get(@node_id.to_i)
        node.sketch_name = @payload
        node.save!
        #@mqtt.put("#{@node_id}/#{@child_sensor_id}/internal/#{@sub_type}", "#{@payload}")
        send_mqtt_msg
    end

    def i_sketch_version
        node = Node.get(@node_id.to_i)
        node.sketch_version = @payload
        node.save!
        #@mqtt.put("#{@node_id}/#{@child_sensor_id}/internal/#{@sub_type}", "#{@payload}")
        send_mqtt_msg

    end




    

    def log_because_not_implemented(thing, message)
        $logger.error("not implemented #{thing} for message: #{message}")
    end



    


    private 

    def send_mqtt_msg(node_id = nil, child_sensor_id = nil, message_type = nil, ack = nil, sub_type = nil, payload = nil)
        m_node_id = node_id.nil? ? @node_id : node_id
        m_child_sensor_id = child_sensor_id.nil? ? @child_sensor_id : child_sensor_id
        m_message_type = message_type.nil? ? @message_type : message_type
        m_ack = ack.nil? ? @ack : ack
        m_sub_type = sub_type.nil? ? @sub_type : sub_type
        m_payload = payload.nil? ? @payload : payload
        
        @mqtt.put("#{m_node_id}/#{m_child_sensor_id}/#{m_message_type}/#{m_ack}/#{m_sub_type}", "#{m_payload}")
    end

    def send_serial_msg(node_id = nil, child_sensor_id = nil, message_type = nil, ack = nil, sub_type = nil, payload = nil)
        m_node_id = node_id.nil? ? @node_id : node_id
        m_child_sensor_id = child_sensor_id.nil? ? @child_sensor_id : child_sensor_id
        m_message_type = message_type.nil? ? MESSAGE_TYPES[@message_type] : message_type
        m_ack = ack.nil? ? @ack : ack
        m_sub_type = sub_type.nil? ? sub_type_from_string_to_i : sub_type
        m_payload = payload.nil? ? @payload : payload
        msg = "#{m_node_id};#{m_child_sensor_id};#{m_message_type};#{m_ack};#{m_sub_type};#{m_payload}"
        puts "send message: #{msg}"
        @serial.send(msg)

    end

    def self.parseable?(message_content)
        Message.splitt_message(message_content).length == 6 ? true : false
    end

    def self.mqtt_parseable?(message_content)
        result = true
        result = false if message_content.length != 2
        result = false if Message.splitt_mqtt_message(message_content).length != 7
        result
    end

    def self.splitt_mqtt_message(message_content)
        ary = message_content[0].split("/")
        ary.push(message_content[1])
        ary
    end
    
    def self.splitt_message(message_content)
        message_content.split(';')
    end

end