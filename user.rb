require_relative "QuestionsDatabase.rb"
require 'byebug'

class User

    attr_accessor :fname, :lname

    def self.all
        users = QuestionsDatabase.instance.execute("SELECT * FROM users")
        users.map {|u| User.new(u) }
    end

    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        users
        WHERE
        id = ?    
    SQL

    User.new(x.first)
    end

    def self.find_by_name(fname)
        x = QuestionsDatabase.instance.execute(<<-SQL, fname)

        SELECT
        *
        FROM
        users
        WHERE
        fname = ?   
    SQL

    User.new(x.first)
    end

    def initialize(options)
        @fname = options['fname']
        @lname = options['lname']
       
    end
    
    
end