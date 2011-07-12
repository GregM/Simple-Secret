class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.text :content
      t.datetime :expiration
      t.text :code
      t.integer :views

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
