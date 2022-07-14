require_relative "QuestionsDatabase.rb"
require_relative "reply.rb"
require_relative "user.rb"
require_relative "question_follow.rb"

class Question

    attr_accessor :id, :title, :body, :users_id
    
    def self.find_by_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        questions
        WHERE
        id = ?  
    SQL

    Question.new(x.first)
    end

    def self.find_by_author_id(author_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, author_id)

        SELECT
        *
        FROM
        questions
        WHERE
        users_id = ?  

        SQL

        questions = []
        x.each do |question|
            questions << Question.new(question)
        end
        return Question.new(x.first) if x.length == 1
        return questions
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @users_id = options['users_id']
    end

    def author
        User.find_by_id(@users_id)
    end

    def replies
        Reply.find_by_question_id(@id)
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end

end