# frozen_string_literal: true

module Auth
  class Destroy
    def initialize(context:)
      @context = context
    end

    def run
      context.session[:teacher_id] = nil
    end

    private

    attr_reader :context
  end
end
