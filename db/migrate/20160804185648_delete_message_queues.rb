class DeleteMessageQueues < ActiveRecord::Migration[5.1]
  def change
    if( table_exists?(:message_queues) )
      drop_table :message_queues
    end
  end
end
