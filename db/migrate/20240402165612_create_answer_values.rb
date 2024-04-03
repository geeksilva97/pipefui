class CreateAnswerValues < ActiveRecord::Migration[7.1]
  def change
    create_table :answer_values do |t|
      t.string :field_name
      t.string :field_value
      t.references :answer, null: false, foreign_key: {on_delete: :cascade}
      t.references :field, null: false, type: :uuid, foreign_key: {on_delete: :nullify}
      t.references :form, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
