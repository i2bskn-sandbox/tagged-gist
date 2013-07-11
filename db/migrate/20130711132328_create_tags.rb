class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, limit: 20
      t.integer :user_id
      t.integer :gist_id

      t.timestamps
    end

    add_index :tags, :name
    add_index :tags, :user_id
  end
end
