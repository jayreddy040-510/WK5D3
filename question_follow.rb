require_relative "QuestionsDatabase.rb"
require_relative "user.rb"
require_relative "question.rb"

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

    def self.followers_for_question_id(questions_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, questions_id)

        SELECT
        fname, lname
        FROM
        question_follows
        JOIN 
        questions ON questions.id = question_follows.questions_id
        JOIN 
        users ON users.id = question_follows.users_id
        WHERE
        questions_id = ? 
    SQL
   
        question_follows = []

        x.each do |user|
            question_follows << User.new(user)
        end
        return User.new(x.first) if x.length == 1
        return question_follows
    end

    def self.followed_questions_for_user_id(users_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, users_id)

        SELECT
        q.title, q.body
        FROM
        question_follows qf
        JOIN 
        questions q ON q.id = qf.questions_id
        JOIN 
        users u ON u.id = qf.users_id
        WHERE
        u.id = ? 
    SQL

        questions = []

        x.each do |question|
            questions << Question.new(question)
        end
        return Question.new(x.first) if x.length == 1
        return questions
    end

    def self.most_followed_questions(n)
        x = QuestionsDatabase.instance.execute(<<-SQL, n)

        SELECT
        q.title, q.body
        FROM
        question_follows qf
        JOIN 
        questions q ON q.id = qf.questions_id
        JOIN 
        users u ON u.id = qf.users_id
        GROUP BY
        qf.questions_id
        ORDER BY
        COUNT(qf.users_id) DESC
        LIMIT
        ?
    SQL

    # p x
        questions = []

        x.each do |question|
            questions << Question.new(question)
        end
        return Question.new(x.first) if x.length == 1
        return questions
    end

    def initialize(options)
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end
end