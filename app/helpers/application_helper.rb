# frozen_string_literal: true

module ApplicationHelper
  DISABLED_CLASS = 'disabled'

  def disable_status(current_teacher)
    current_teacher ? '' : DISABLED_CLASS
  end
end
