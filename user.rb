require_relative "QuestionsDatabase.rb"
require_relative "question.rb"
require_relative "reply.rb"
require_relative "question_follow.rb"

class User

    attr_accessor :id, :fname, :lname

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
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
       
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end
    
end