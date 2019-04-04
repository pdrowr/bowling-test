class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :current_frame_number, default: 1
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
