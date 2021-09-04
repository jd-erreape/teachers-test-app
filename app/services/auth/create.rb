# frozen_string_literal: true

module Auth
  class Create
    def initialize(context:, teacher_id:)
      @context = context
      @teacher_id = teacher_id
    end

    def run
      context.session[:teacher_id] = teacher_id
    end

    private

    attr_reader :context, :teacher_id
  end
end
