class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :gid
      t.string :description
      t.string :html_url
      t.string :embed_url
      t.boolean :public_gist
      t.integer :user_id

      t.timestamps
    end

    add_index :gists, :gid, unique: true
  end
end
