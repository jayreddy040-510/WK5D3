require_relative "QuestionsDatabase.rb"
require_relative "user.rb"


class QuestionLike

    def self.likers_for_question_id(question_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, question_id)

        SELECT
        u.fname, u.lname
        FROM
        question_likes ql
        JOIN 
        questions q ON q.id = ql.questions_id
        JOIN 
        users u ON u.id = ql.users_id
        WHERE
        q.id = ? 
    SQL

        questions = []

        x.each do |question|
            questions << User.new(question)
        end
        return User.new(x.first) if x.length == 1
        return questions
    end

    

    def self.num_likes_for_question_id(question_id)
    end
    
    
    
end