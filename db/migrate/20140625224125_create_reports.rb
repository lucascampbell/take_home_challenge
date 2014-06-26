class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.timestamps
    end
  end
  add_column :items, :report_id, :integer
end
