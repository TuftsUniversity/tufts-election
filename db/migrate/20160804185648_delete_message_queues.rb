class DeleteMessageQueues < ActiveRecord::Migration
  def change
    if( table_exists?(:message_queues) )
      drop_table :message_queues
    end
  end
end
