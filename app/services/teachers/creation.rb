# frozen_string_literal: true

module Teachers
  class Creation
    def initialize(context:, teacher_params:)
      @context = context
      @teacher_params = teacher_params
    end

    def run
      return teacher unless teacher.save

      authenticate_teacher

      teacher
    end

    private

    attr_reader :context, :teacher_params

    def teacher
      @teacher ||= Teacher.new(teacher_params)
    end

    def authenticate_teacher
      Auth::Create.new(context: context, teacher_id: teacher.id).run
    end
  end
end
