# frozen_string_literal: true

class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :app_no
      t.string :app_name

      t.timestamps
    end
    add_index :apps, :app_no, unique: true
  end
end
