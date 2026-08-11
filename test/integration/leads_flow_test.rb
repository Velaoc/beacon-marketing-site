require "test_helper"

class LeadsFlowTest < ActionDispatch::IntegrationTest
  test "landing page renders all marketing sections" do
    get root_path

    assert_response :success
    assert_select "h1", /Ship features people actually use/
    assert_select "section#features"
    assert_select "section#pricing"
    assert_select "section#faq"
    assert_select "section#signup"
  end

  test "signup creates a lead and redirects with a notice" do
    assert_difference -> { Lead.count }, 1 do
      post leads_path, params: { lead: { name: "Ada Lovelace", email: "ada@example.com" } }
    end

    assert_redirected_to root_path(anchor: "signup")
    follow_redirect!
    assert_response :success

    lead = Lead.last
    assert_equal "ada@example.com", lead.email
    assert_equal "Ada Lovelace", lead.name
    assert_equal "landing", lead.source
  end

  test "duplicate email is rejected without creating a second lead" do
    Lead.create!(name: "Ada", email: "ada@example.com")

    assert_no_difference -> { Lead.count } do
      post leads_path, params: { lead: { email: "ada@example.com" } }
    end

    assert_redirected_to root_path(anchor: "signup")
  end

  test "invalid email is rejected" do
    assert_no_difference -> { Lead.count } do
      post leads_path, params: { lead: { email: "not-an-email" } }
    end

    assert_redirected_to root_path(anchor: "signup")
  end
end
