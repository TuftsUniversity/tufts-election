class DeleteMessageQueues < ActiveRecord::Migration
  def change
    drop_table :message_queues
  end
end
