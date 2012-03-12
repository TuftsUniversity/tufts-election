class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|

      t.timestamps
    end
  end
end
