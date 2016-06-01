require 'calabash/android'
require 'calabash/ios'
require 'require_all'
require 'allure-cucumber'
require 'rspec/expectations'
require 'rspec/matchers'
require 'page-object'
require 'data_magic'
require_rel '../pages/'
require_rel '../android/'
require_rel '../ios/'

platform = Calabash::Environment.variable('PLATFORM')

DataMagic.yml_directory = '../data'

include AllureCucumber::DSL

AllureCucumber.configure do |config|
  config.output_dir = 'allure'
end

case platform
when 'android'
  World(Calabash::Android)

  # Setup the default application
  Calabash::Application.default =
    Calabash::Android::Application.default_from_environment

  identifier = Calabash::Android::Device.default_serial
  server = Calabash::Android::Server.default

  # Setup the default device
  Calabash::Device.default =
    Calabash::Android::Device.new(identifier, server)
when 'ios'
  World(Calabash::IOS)

  # Setup the default application
  Calabash::Application.default =
    Calabash::IOS::Application.default_from_environment

  identifier =
      Calabash::IOS::Device.default_identifier_for_application(Calabash::Application.default)

  server = Calabash::IOS::Server.default

  # Setup the default device
  Calabash::Device.default =
    Calabash::IOS::Device.new(identifier, server)
else
  message = if platform.nil? || platform.empty?
              'No platform given'
            else
              "Invalid platform '#{platform}'. Expected 'android' or 'ios'"
            end

  failure_messages =
      [
        'ERROR! Unable to start the cucumber test:',
        message,
        "Use the profile 'android' or 'ios'"
      ]

  Calabash::Logger.error(failure_messages.join("\n"))
  exit(1)
end