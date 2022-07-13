require_relative "QuestionsDatabase.rb"

class QuestionFollow

    attr_accessor :users_id, :questions_id
    
    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        question_follows
        WHERE
        id = ?  
    SQL

    QuestionFollow.new(x.first)
    end

    def initialize(options)
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end
end