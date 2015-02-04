require 'yaml/store'

class Node
    attr_accessor :id, :sub_type, :comment, :name, :store

    STORE = YAML::Store.new "storage/nodes.yml"

    def initialize(sub_type, comment= nil, name = nil)
        #@id = Node.serve_id
        @sub_type = sub_type
        @comment = comment
        @name = name
        @store = STORE
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

    def get
        store = STORE
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