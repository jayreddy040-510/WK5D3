require_relative "QuestionsDatabase.rb"
require_relative "user.rb"

class Reply

    attr_accessor :id, :body, :parent_id, :users_id, :questions_id

    def self.all
        replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        replies.map {|u| Reply.new(u) }
    end
    
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


    def self.find_by_parent_id(parent_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, parent_id)

        SELECT
        *
        FROM
        replies
        WHERE
        parent_id = ?  
    SQL

        Reply.new(x.first)
    end



    def self.find_by_user_id(user_id)
        x = QuestionsDatabase.instance.execute(<<-SQL, user_id)

        SELECT
        *
        FROM
        replies
        WHERE
        users_id = ?  
    SQL

        replies = []

        x.each do |reply|
            replies << Reply.new(reply)
        end
        return Reply.new(x.first) if x.length == 1
        return replies
    end

    def self.find_by_question_id(id)
        x = QuestionsDatabase.instance.execute(<<-SQL, id)

        SELECT
        *
        FROM
        replies
        WHERE
        questions_id = ?  
    SQL

        replies = []
        x.each do |reply|
            replies << Reply.new(reply)
        end
        return Reply.new(x.first) if x.length == 1
        return replies
    end



    def initialize(options)
        @id = options['id']
        @body = options['body']
        @parent_reply_id = options['parent_id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end

    def author
        User.find_by_id(@users_id)
    end

    def question
        Question.find_by_id(@questions_id)
    end

    def parent_reply
        Reply.find_by_id(@parent_reply_id)
    end

    def child_replies
        Reply.find_by_parent_id(self.id)
    end
end