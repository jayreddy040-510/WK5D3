require_relative "QuestionsDatabase.rb"

class Questions

    attr_accessor :title, :body, :users_id
    
    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        questions
        WHERE
        id = ?  
    SQL

    Questions.new(x)
    end


    def initialize(options)

        @title = options['title']
        @body = options['body']
        @users_id = options['users_id']

    end
end