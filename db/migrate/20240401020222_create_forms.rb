class CreateForms < ActiveRecord::Migration[7.1]
  def change
    create_table :forms do |t|
      t.string :title
      t.boolean :can_answer, default: true

      t.timestamps
    end
  end
end
