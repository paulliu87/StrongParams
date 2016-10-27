class CreateHighScores < ActiveRecord::Migration[5.0]
  def change
    create_table :high_scores do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
