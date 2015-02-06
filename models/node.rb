require 'yaml/store'

class Node
    attr_accessor :id, :sub_type, :comment, :name, :store, :lib_version, :sketch_name, :sketch_version
    
    STORE = YAML::Store.new $pwd + "/storage/nodes.yml"

    def initialize(sub_type = nil, comment= nil, name = nil)
        #@id = Node.serve_id
        @sub_type = sub_type
        @sub_type_1 = nil
        @sub_type_2 = nil
        @sub_type_3 = nil
        @sub_type_4 = nil
        @sub_type_5 = nil
        @sub_type_6 = nil
        @comment = comment
        @name = name
        @store = STORE
        @lib_version = nil
        @sketch_name = nil
        @sketch_version = nil
    end

    def save!
        @store.transaction do
            if self.id == nil
                self.id = Node.serve_id
            end
            @store[@id] = self
        end
    end

    def self.all
        STORE.transaction do
            Node.get_all
        end
    end

    def self.get(id)
        STORE.transaction do
            STORE[id]
        end
    end

    def set_sub_type(sub_type_id, type)
        case sub_type_id
            when 1
                @sub_type_1 = type
            when 2
                @sub_type_2 = type
            when 3
                @sub_type_3 = type
            when 4
                @sub_type_4 = type
            when 5
                @sub_type_5 = type
            when 6
                @sub_type_6 = type
        end
        save!
    end

    def get_sub_type(sub_type_id)
        case sub_type_id
            when 1
                @sub_type_1
            when 2
                @sub_type_2
            when 3
                @sub_type_3
            when 4
                @sub_type_4
            when 5
                @sub_type_5
            when 6
                @sub_type_6
        end
    end

    private 
    def self.serve_id
        nodes = Node.get_all
        if nodes.any?
            nodes.map{|x| x.id}.max + 1
        else
            1
        end
    end

    def self.get_all
        nodes = []
        STORE.roots.each do |root|
            nodes <<  STORE[root]
        end
        nodes
    end
end