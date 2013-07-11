class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :nickname
      t.string :email
      t.string :image_url
      t.string :github_url
      t.string :access_token

      t.timestamps
    end

    add_index :users, :uid, unique: true
  end
end
