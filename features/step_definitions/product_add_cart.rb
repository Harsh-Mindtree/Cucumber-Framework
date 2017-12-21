Given(/^I am on Amazon Home Page$/) do
  visit "https://www.amazon.in"
end

When(/^I login into Amazon$/) do
  find(:css , '#nav-logobar-greeting').click
  find(:css , '#ap_email').set 'usertwo2020@gmail.com'
  fill_in('Amazon password' , :with => 'admin12!@')
  find(:css , '#signInSubmit').click
end

Then(/^The added product should be present in the Cart$/) do
  find(:css , '#nav-button-cart').click
  expect(find(:css , 'div#sc-buy-box')['data-quantity'].to_i).to eq(1)
end