require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "return true if everything is ok" do
    new_category = Category.new(name: "new_name", description: "new_description")
    assert(new_category.valid?)
  end

  test "return false if anything is failed" do
    new_category = Category.new(description: "new_description")
    assert_not(new_category.valid?)
  end

  test "return false if anything is failed" do
    new_category = Category.new(name: "new_name")
    assert_not(new_category.valid?)
  end

  test "save and gathering" do
    new_category = Category.new(name: "new_name", description: "new_description")
    new_category.save()
    new_category_1 = Category.find_by(name: "new_name")
    assert_equal("new_description", new_category_1.description)
  end

  test "return true if names is unique" do
    new_category = Category.create(name: "MyName_3", description: "MyDescription_3")
    assert(new_category.valid?)
  end

  test "return false if names is not unique" do
    new_category = Category.create(name: "MyName_2", description: "MyDescription_2")
    assert_not(new_category.valid?)
  end


end
