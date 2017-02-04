class CreateDanmakus < ActiveRecord::Migration
  def change
    create_table :danmakus do |t|
      t.text :content
      t.string :color
      t.string :status
      t.timestamps
    end
  end
end
