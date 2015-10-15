class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :link_url
      t.integer :http_response
      t.integer :site_id
      t.timestamps null: false
    end
  end
end
