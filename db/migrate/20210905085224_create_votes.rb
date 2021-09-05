class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :voted, polymorphic: true, null: false
      t.references :voter, polymorphic: true, null: false

      t.timestamps
    end

    add_index :votes, [:voter_id, :voter_type, :voted_id], unique: true
    add_index :votes, [:voted_id, :voted_type, :voter_id], unique: true
  end
end
