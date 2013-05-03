require 'test_helper'

class MessageQueuesControllerTest < ActionController::TestCase
  setup do
    @message_queue = message_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_queue" do
    assert_difference('MessageQueue.count') do
      post :create, message_queue: { last_heartbeat: @message_queue.last_heartbeat, last_ingest: @message_queue.last_ingest, last_modify: @message_queue.last_modify, last_pid_ingested: @message_queue.last_pid_ingested, last_pid_modified: @message_queue.last_pid_modified, last_pid_purged: @message_queue.last_pid_purged, last_purge: @message_queue.last_purge, name: @message_queue.name }
    end

    assert_redirected_to message_queue_path(assigns(:message_queue))
  end

  test "should show message_queue" do
    get :show, id: @message_queue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_queue
    assert_response :success
  end

  test "should update message_queue" do
    put :update, id: @message_queue, message_queue: { last_heartbeat: @message_queue.last_heartbeat, last_ingest: @message_queue.last_ingest, last_modify: @message_queue.last_modify, last_pid_ingested: @message_queue.last_pid_ingested, last_pid_modified: @message_queue.last_pid_modified, last_pid_purged: @message_queue.last_pid_purged, last_purge: @message_queue.last_purge, name: @message_queue.name }
    assert_redirected_to message_queue_path(assigns(:message_queue))
  end

  test "should destroy message_queue" do
    assert_difference('MessageQueue.count', -1) do
      delete :destroy, id: @message_queue
    end

    assert_redirected_to message_queues_path
  end
end
