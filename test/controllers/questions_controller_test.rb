require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_question_url
    assert_response :success
  end
end
