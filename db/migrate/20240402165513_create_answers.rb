class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :preview, null: true
      t.references :form, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
