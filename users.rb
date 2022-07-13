require_relative "QuestionsDatabase.rb"

class Users

    attr_accessor :fname, :lname

    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        users
        WHERE
        id = ?    
    SQL

    Users.new(x)
    end

    def self.find_by_name(name)
        x = QuestionsDatabase.instance.execute(<<-SQL, name)

        SELECT
        *
        FROM
        users
        WHERE
        name = ?   
    SQL

    Users.new(x)
    end

    def initialize(options)
        @fname = options['fname']
        @lname = options['lname']
       
    end
    
    
end