class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.datetime :date, :null => false
      t.string :related_link, :limit => 255, :null => false
      t.float :percentage, :null => false
      
      t.references :tag, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
