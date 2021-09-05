# frozen_string_literal: true

# We are disabling this Rubocop rule here because we really want to
# use Course as the namespace for the service, however, given that
# we already have Course ActiveRecord class, we cannot use Course
# as a module as well

# rubocop:disable Style/ClassAndModuleChildren

# Service in charge of creating a Course by a given teacher
# and to register that teacher within the course if the
# creation succeed
class Course::Creation
  def initialize(teacher:, course_params:)
    @teacher = teacher
    @course_params = course_params
  end

  # It creates the course and register the teacher within it
  # if the preconditions are not met or the course created
  # is not valid, it will return an instance of the Course class
  # that will return false when asked if valid? so we ensure
  # the type returned by the service is always a Course instance
  def run
    return invalid_course unless teacher_valid? && course_params

    TeacherCourse.create(teacher: teacher, course: course) if course.valid?

    course
  end

  private

  attr_reader :teacher, :course_params

  def teacher_valid?
    teacher&.instance_of?(Teacher)
  end

  def invalid_course
    Course.new
  end

  def course
    @course ||= Course.create(course_params)
  end
end

# rubocop:enable Style/ClassAndModuleChildren
