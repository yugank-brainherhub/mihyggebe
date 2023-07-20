# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      # t.references :care, foreign_key: true
      t.string :subscriptionId
      t.string :planId
      t.timestamps
    end
  end
end
