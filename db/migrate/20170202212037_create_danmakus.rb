class CreateDanmakus < ActiveRecord::Migration[5.0]
  def change
    create_table :danmakus do |t|
      t.text :content
      t.integer :status
      t.timestamps
    end
  end
end
