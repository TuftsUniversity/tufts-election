class MessageQueue < ActiveRecord::Base
  attr_accessible :last_heartbeat, :last_ingest, :last_modify, :last_pid_ingested, :last_pid_modified, :last_pid_purged, :last_purge, :name
end
