require 'test/unit'
require 'redcarpet_checkboxes'

class RedcarpetCheckboxesTest < Test::Unit::TestCase

  def setup
    @m ||= CheckboxMarkdown.new(Redcarpet::Render::HTML.new())
  end

  def test_proper_markdown_inheritance
    assert @m.is_a? CheckboxMarkdown
    assert @m.is_a? Redcarpet::Markdown # Superclass
  end

  def test_standard_markdown
    assert_equal @m.render("## Hello"), "<h2>Hello</h2>\n"
    assert_equal @m.render("**Bold**"), "<p><strong>Bold</strong></p>\n"
  end

  def test_checkbox_existence
    assert_match /<input.* \/>/,    @m.render("- [ ]")
    assert_match /type="checkbox"/, @m.render("- [ ]")
  end

  def test_checkbox_check_attribute
    assert_match /checked="checked"/,     @m.render("- [x]")
    assert_no_match /checked="checked"/,  @m.render("- [ ]")
  end

  def test_checkbox_data_setting
    assert_match(/data-remote="true"/,  @m.render("- [ ]") { |updated_text| {remote: true} })
    assert_match(/data-method="put"/,   @m.render("- [x]") { |updated_text| {remote: true, method: :put} })
  end
end
