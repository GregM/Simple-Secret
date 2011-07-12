require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "save new content" do
    assert_difference 'Content.count' do
      c = Content.new
      c.content = "this is some content"
      c.expiration = "2011-04-19 02:28:00"
      assert c.save
      assert_equal(c.reload.content, "this is some content")
      assert_equal(c.reload.expiration, "2011-04-19 02:28:00")
      assert_equal(c.reload.code.length,6)
    end
  end
  
  test "user cannot assign code" do
    assert_difference 'Content.count' do
      c = Content.new(:content => "this", :expiration => "2011-04-19 02:28:00", :code => "123456")
      assert c.save
      assert_not_equal(c.reload.code, "123456")
    end
  end
end
