require "test_helper"

class OperationTest < ActiveSupport::TestCase

#tests for validates

  test "return true if everything is ok" do
    new_operation = Operation.new(amount: 10.5, 
                                  odate: "2023-02-10", 
                                  description: "some_description", 
                                  category_id: Category.last.id, 
                                  types: 2)
    assert(new_operation.valid?)
  end

  test "return false if amount is not definded" do
    new_operation = Operation.new(odate: "2023-02-10", 
                                  description: "some_descrption", 
                                  category_id: Category.last.id, 
                                  types: 2)
    assert_not(new_operation.valid?)
  end

  test "return false if amount is not digit" do
    new_operation = Operation.new(amount: "text",
                                  odate: "2023-02-10", 
                                  description: "some_descrption", 
                                  category_id: Category.first.id, 
                                  types: 2)
      assert_not(new_operation.valid?)
  end

  test "return false if odate is not definded" do
    new_operation = Operation.new(amount: 10.5,                                 
                                  description: "some_descrption", 
                                  category_id: Category.first.id, 
                                  types: 2)
    assert_not(new_operation.valid?)
  end

  test "return false if description is not definded" do
    new_operation = Operation.new(amount: 10.5,
                                  odate: "2023-02-10",                           
                                  category_id: Category.first.id, 
                                  types: 2)
    assert_not(new_operation.valid?)
  end

  test "return false if types is not digit" do
    new_operation = Operation.new(amount: 10.5,
                                  odate: "2023-02-10", 
                                  description: "some_descrption",                          
                                  category_id: Category.first.id,
                                  types: "text")
    assert_not(new_operation.valid?)
  end

  test "return false if types out of range" do
    new_operation = Operation.new(amount: 10.5,
                                  odate: "2023-02-10", 
                                  description: "some_descrption",                          
                                  category_id: Category.first.id,
                                  types: 3)
    assert_not(new_operation.valid?)
  end

#tests for methods by report

  test "return sum of amount by category for given range of dates" do
    start_date = "2023-01-12"
    end_date = "2023-01-13"
    type_operations = 1


    first_result = Operation.model_report_by_category(start_date, end_date, type_operations)
    result = Hash[first_result.map { |k, v| [k, v.to_f] }]

    assert_equal({ "MyName_1" => 20.0, "MyName_3" => 10.0 }, result )
  end
  
  test "return sum of amount by dates for given range of dates" do
    start_date = "2023-01-12"
    end_date = "2023-01-13"
    category_id = 2

    first_result = Operation.model_report_by_dates(start_date, end_date, category_id)
    result = Hash[first_result.map { |k, v| [k.to_date.to_s, v.to_f] }]

    assert_equal({ "2023-01-12" => 10.0, "2023-01-13" => 15.0 }, result )
  end

  test "return false if given range of dates is not valid for sum amount by category" do
    start_date = "2023-01-14"
    end_date = "2023-01-15"
    type_operations = 1

    first_result = Operation.model_report_by_category(start_date, end_date, type_operations)
    result = Hash[first_result.map { |k, v| [k, v.to_f] }]

    assert_not_equal({ "MyName_1" => 0.0, "MyName_2" => 0.0 }, result )
  end
  
  test "return false if given range of dates is not valid for sum amount by dates" do
    start_date = "2023-01-14"
    end_date = "2023-01-15"
    category_id = 2

    first_result = Operation.model_report_by_dates(start_date, end_date, category_id)
    result = Hash[first_result.map { |k, v| [k.to_date.to_s, v.to_f] }]

    assert_not_equal({ "2023-01-14" => 0.0, "2023-01-15" => 0.0 }, result )
  end

end
