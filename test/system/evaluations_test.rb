require "application_system_test_case"

class EvaluationsTest < ApplicationSystemTestCase
  setup do
    @evaluation = evaluations(:one)
  end

  test "visiting the index" do
    visit evaluations_url
    assert_selector "h1", text: "Evaluations"
  end

  test "creating a Evaluation" do
    visit evaluations_url
    click_on "New Evaluation"

    fill_in "", with: @evaluation.
    fill_in "Comment", with: @evaluation.comment
    fill_in "Evaluate1", with: @evaluation.evaluate1
    fill_in "Evaluate2", with: @evaluation.evaluate2
    fill_in "Evaluate3", with: @evaluation.evaluate3
    fill_in "Evaluate4", with: @evaluation.evaluate4
    fill_in "School num", with: @evaluation.school_num
    click_on "Create Evaluation"

    assert_text "Evaluation was successfully created"
    click_on "Back"
  end

  test "updating a Evaluation" do
    visit evaluations_url
    click_on "Edit", match: :first

    fill_in "", with: @evaluation.
    fill_in "Comment", with: @evaluation.comment
    fill_in "Evaluate1", with: @evaluation.evaluate1
    fill_in "Evaluate2", with: @evaluation.evaluate2
    fill_in "Evaluate3", with: @evaluation.evaluate3
    fill_in "Evaluate4", with: @evaluation.evaluate4
    fill_in "School num", with: @evaluation.school_num
    click_on "Update Evaluation"

    assert_text "Evaluation was successfully updated"
    click_on "Back"
  end

  test "destroying a Evaluation" do
    visit evaluations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Evaluation was successfully destroyed"
  end
end
