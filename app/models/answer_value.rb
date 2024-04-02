class AnswerValue < ApplicationRecord
  belongs_to :answer
  belongs_to :field
  belongs_to :form
end
