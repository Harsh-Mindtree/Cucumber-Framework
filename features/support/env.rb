require 'selenium-webdriver'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'site_prism'
require 'capybara/poltergeist'
require 'appium_capybara'
require 'pry'


def appium_caps
  {
    'Nexus5'=> { platformName: "android", deviceName: "Nexus 5", versionNumber: "5.1", browserName: "Chrome"},
    'SGS 6'=> { platformName: "android", deviceName: "02157df23bc41912", versionNumber: "5.1.1", browserName: "chrome"},
    'SM-N920G' => { platformName: 'Android', deviceName: 'Galaxy Note5', udid: '836f4a42344d5836', versionNumber: '6.0.1', browserName: 'chrome' }
  }
end


appium_port = ENV['APPIUM_PORT'] || '4723'
Capybara.register_driver current_driver do |app|
        caps = ENV['HIVE'] == 'true' ? appium_caps.fetch('Hive CI') : appium_caps.fetch(fetch_device_attached(ENV['DEVICE']))
        puts caps.to_s
        url = "http://localhost:#{appium_port}/wd/hub/" # Url to your running appium server
        appium_lib_options = { server_url: url }
        all_options = { appium_lib:  appium_lib_options, caps: caps }
        Appium::Capybara::Driver.new app, all_options
end

def fetch_device_attached(device)
    device_serial_no = ENV['ADB_DEVICE_ARG']
    if device == 'android'
        device_attached = case RUBY_PLATFORM
        when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        `adb shell getprop ro.product.model`
        else
        `adb -s #{device_serial_no} shell getprop ro.product.model`
    end
    device_attached.strip
    elsif device == 'iOS'
    device_attached = 'iPhone 6'
    else
    puts 'Not able to recognize device'
end

Capybara.default_driver = :appium



