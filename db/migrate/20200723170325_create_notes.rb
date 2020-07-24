# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :tag, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
