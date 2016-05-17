Given(/^I am (?:a|an) (?:.*) user$/) do
  @current_page = page(HomePage)
end

When(/^I pan left$/) do
  pan_left '*'
end

When(/^I pan right$/) do
  pan_right '*'
end

When(/^I pan left (\d+) times$/) do |digit|
  (digit.to_i).times do
    pan_left '*'
    ; sleep 0.1
  end
end

Then(/^I press the android back button$/) do
  go_back
end

Then(/^the app is closed$/) do
  sleep 0.5
  (query '*').empty?
end

And(/^I am on the (.*) page$/) do |page|
  page_name = page(@current_page.class_for page)
  page_name.await
  @current_page = page_name
end

Then(/^the page contains the correct data for the (.*)$/) do |content|
  @current_page.validate_data_for(content.gsub(' ', '_'))
end

When(/^I navigate to the (.*) page$/) do |page|
  route = @current_page.route_for(page)
  @current_page.navigate_to_page(route)
  @current_page = page(@current_page.class_for page)
end

And(/^I fill out the (.*) field with (.*)$/) do |field, text|
  @current_page.enter_text_in(@current_page.send('input_text_' + field.gsub(' ','_')), text)
end

And(/^I tap the (.*) button/) do |button|
  @current_page.tap(@current_page.send('btn_' + button.gsub(' ', '_')))
end

Then(/^the (.*) text field contains (.*)$/) do |text_field, text|
  text_field = @current_page.send('input_text_'+ text_field.gsub(' ', '_'))
  query = @current_page.query(text_field)
  query_text = query.first['text']
  expect(query_text).to eq text
end

And(/^I wait for the (.*) to (.*)$/) do |element, visibility|
  @current_page.wait_for_no_view(@current_page.send(element.gsub(' ', '_'))) if visibility == "not be visible"
  @current_page.wait_for_view(@current_page.send(element.gsub(' ', '_'))) if visibility == "be visible"
end

And(/^tap the keyboard action key$/) do
  @current_page.tap_keyboard_action_key
end

And(/^I tap the (.*) text field$/) do |text_field|
  @current_page.tap(@current_page.send('input_text_' + text_field.gsub(' ', '_')))
end

And(/^I dismiss the keyboard$/) do
  @current_page.dismiss_keyboard
end
