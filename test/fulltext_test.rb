
require File.expand_path("../test_helper", __FILE__)

class FulltextTest < AttrSearchable::TestCase
  def test_complex
    product1 = FactoryGirl.create(:product, :title => "word1")
    product2 = FactoryGirl.create(:product, :title => "word2 word3")
    product3 = FactoryGirl.create(:product, :title => "word2")

    results = Product.search("title:word1 OR (title:word2 -title:word3)")

    assert_includes results, product1
    refute_includes results, product2
    assert_includes results, product3
  end

  def test_mixed
    expected = FactoryGirl.create(:product, :title => "Expected title", :stock => 1)
    rejected = FactoryGirl.create(:product, :title => "Expected title", :stock => 0)

    results = Product.search("title:Expected title:Title stock > 0")

    assert_includes results, expected
    refute_includes results, rejected
  end
end

