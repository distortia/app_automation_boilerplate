require 'calabash'
require 'allure-cucumber'
require 'watir-webdriver'
require 'rspec/expectations'
require 'rspec/matchers'
require 'page-object'

include AllureCucumber::DSL

Before do |scenario|
  if scenario.respond_to?(:scenario_outline)
    scenario = scenario.scenario_outline
  end

  AppLifeCycle.on_new_scenario(scenario)

  start_app
end

After do |scenario|
  # screenshot_embed if scenario.failed?
  if scenario.failed?
    datetime = DateTime.now.strftime("%d%b%Y%H%M%S")
    # attach_file(datetime, File.open(screenshot))
  end
  clear_app_data if android?

  #Create report
  # %x(allure generate ../../allure)
  # %x(allure report open)
end

module AppLifeCycle
  # Since this is a module, the methods in the Cucumber World are not
  # available inside the scope of this module. We can safely include Calabash
  # because we will not affect the scope outside this module. The methods are
  # loaded as class (static) methods.
  class << self
    include Calabash
  end

  DEFAULT_RESET_BETWEEN = :features # Filled in by calabash-webdriver gen
  DEFAULT_RESET_METHOD = :clear # Filled in by calabash-webdriver gen

  RESET_BETWEEN = if Calabash::Environment.variable('RESET_BETWEEN')
                    Calabash::Environment.variable('RESET_BETWEEN').downcase.to_sym
                  else
                    DEFAULT_RESET_BETWEEN
                  end

  RESET_METHOD = if Calabash::Environment.variable('RESET_METHOD')
                   Calabash::Environment.variable('RESET_METHOD').downcase.to_sym
                 else
                   DEFAULT_RESET_METHOD
                 end

  def self.on_new_scenario(scenario)
    # Ensure the app is installed at the beginning of the test,
    # if we never reset
    ensure_app_installed if @last_feature.nil? && RESET_BETWEEN == :never

    reset if should_reset?(scenario)

    @last_feature = scenario.feature
  end

  private

  def self.should_reset?(scenario)
    case RESET_BETWEEN
    when :scenarios
      true
    when :features
      scenario.feature != @last_feature
    when :never
      false
    else
      fail "Invalid reset between option '#{RESET_BETWEEN}'"
    end
  end

  def self.reset
    case RESET_METHOD
    when :reinstall
      install_app
    when :clear
      ensure_app_installed
      clear_app_data
    when '', nil
      fail 'No reset method given'
    else
      fail "Invalid reset method '#{RESET_METHOD}'"
    end
  end
end
