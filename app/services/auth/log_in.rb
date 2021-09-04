# frozen_string_literal: true

module Auth
  class LogIn
    def initialize(context:, email:, password:)
      @context = context
      @email = email
      @password = password
    end

    def run
      return false if teacher_id.blank?

      create_session(teacher_id)

      true
    end

    private

    attr_reader :context, :email, :password

    def teacher_id
      @teacher_id ||= Validate.new(email: email, password: password).run
    end

    def create_session(teacher_id)
      Create.new(context: context, teacher_id: teacher_id).run
    end
  end
end
