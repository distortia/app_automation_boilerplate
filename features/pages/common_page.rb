require 'yaml'

class CommonPage < Calabash::Page
  include DataMagic
  include RSpec::Matchers

  def random_email_generator
    random_email = ''
    possible_characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    6.times.map do
      random_email << possible_characters[rand((0..(possible_characters.length - 1)))]
    end
    random_email + '@my_domnain.qa'
  end

  def yaml_file
    YAML.load_file(File.join(__dir__, '/../../data/' + self.page_data_file + '.yml'))
  end

  def validate_data_for(data_key)
    data = yaml_file
    expected_data = data[data_key]
    raise "#{self.page_data_file}.yml data missing key: #{data_key}" if expected_data.nil?
    expected_data.each do |element, value|
      if element.start_with? 'img'
        expect(validate_img element).to eq true
      elsif element.start_with? 'input_text'
        expect(validate_placeholder element).to eq value
      else
        expect(validate_text element).to eq value
      end
    end
  end

  def validate_text(element)
    text = (query self.send(element)).first["text"]
    data_cleaner text
  end

  def validate_img(element)
    true if view_exists? self.send(element)
  end

  def validate_placeholder(element)
    if android?
      query((self.send element), :Hint).first
    else
      query((self.send element), :text).first
    end
  end

  def class_for(page)
    page = page.split
    page.each do |fragment|
      fragment[0] = fragment[0].capitalize!
    end
    page = page.join
    Object.const_get(page + 'Page')
  end

  def data_cleaner(text)
    text.gsub("\n", ' ')
  end
end
