# frozen_string_literal: true

module Auth
  class Validate
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def run
      return nil unless teacher&.authenticate(password)

      teacher.id
    end

    private

    attr_reader :email, :password

    def teacher
      @teacher ||= Teacher.find_by(email: email)
    end
  end
end
