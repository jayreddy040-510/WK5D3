require_relative "QuestionsDatabase.rb"

class Reply

    attr_accessor :body, :parent_id, :users_id, :questions_id
    
    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        replies
        WHERE
        id = ?  
    SQL

    Reply.new(x.first)
    end

    def initialize(options)
        @body = options['body']
        @parent_id = options['parent_id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end
end