# frozen_string_literal: true

# Service in charge of creating a Teacher given its params
# and delegating to the Auth Creation service the log in
# process for this teacher if the creation succeed
module Teachers
  class Creation
    def initialize(context:, teacher_params:)
      @context = context
      @teacher_params = teacher_params
    end

    # It creates the teacher and delegates within the
    # Auth Creation service, if the teacher is not valid
    # we still return the teacher (without performing)
    # the authentication so whatever client using the
    # service could know why the process didnt succeed
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
