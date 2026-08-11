class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :name, null: false, default: ""
      t.string :email, null: false
      t.string :source, null: false, default: "landing"
      t.timestamps
    end

    add_index :leads, :email
  end
end
