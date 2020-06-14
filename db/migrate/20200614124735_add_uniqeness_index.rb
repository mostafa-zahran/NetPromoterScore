class AddUniqenessIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :promoter_scores, [:respondent_id, :respondent_class, :object_id, :object_class, :touchpoint], unique: true, name: 'promoter_scores_record_uniqness'
  end
end
