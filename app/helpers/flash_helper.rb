# frozen_string_literal: true

module FlashHelper
  SUCCESS_CLASS = 'success'
  ERROR_CLASS = 'danger'

  def flash_class(flash_level)
    {
      'notice' => SUCCESS_CLASS,
      'alert' => ERROR_CLASS
    }.fetch(flash_level, SUCCESS_CLASS)
  end
end
