class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :notes
      t.date :due

      t.timestamps
    end
  end
end
