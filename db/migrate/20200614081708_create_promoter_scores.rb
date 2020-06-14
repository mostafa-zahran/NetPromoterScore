class CreatePromoterScores < ActiveRecord::Migration[5.2]
  def change
    create_table :promoter_scores do |t|
      t.integer :score, null: false
      t.string :touchpoint, null: false
      t.string :respondent_class, null: false
      t.integer :respondent_id, null: false
      t.string :object_class, null: false
      t.integer :object_id, null: false
      t.timestamps
      t.index %i[respondent_class respondent_id]
      t.index %i[object_class object_id]
    end
  end
end
