class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.boolean :complete, default: false
      t.boolean :priority, default: false
      t.string :content
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
