class Field < ApplicationRecord
  belongs_to :form

  enum field_type: [:text, :textarea]
end
