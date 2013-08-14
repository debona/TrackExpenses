require 'test_helper'

class BanksControllerTest < ActionController::TestCase
  setup do
    @bank = banks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank" do
    assert_difference('Bank.count') do
      post :create, bank: { column_separator: @bank.column_separator, date_index: @bank.date_index, name: @bank.name, title_index: @bank.title_index, value: @bank.value }
    end

    assert_redirected_to bank_path(assigns(:bank))
  end

  test "should show bank" do
    get :show, id: @bank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank
    assert_response :success
  end

  test "should update bank" do
    patch :update, id: @bank, bank: { column_separator: @bank.column_separator, date_index: @bank.date_index, name: @bank.name, title_index: @bank.title_index, value: @bank.value }
    assert_redirected_to bank_path(assigns(:bank))
  end

  test "should destroy bank" do
    assert_difference('Bank.count', -1) do
      delete :destroy, id: @bank
    end

    assert_redirected_to banks_path
  end
end
