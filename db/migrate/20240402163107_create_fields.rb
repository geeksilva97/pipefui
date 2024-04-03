class CreateFields < ActiveRecord::Migration[7.1]
  def change
    create_table :fields, id: :uuid do |t|
      t.string :name
      t.integer :field_type
      t.boolean :is_required, default: false
      t.references :form, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
