require 'test_helper'

class DiscountCodeTest < Test::Unit::TestCase
  def setup
    super
    fake 'price_rules/102586120/discount_codes/1002091923', body: load_fixture('discount_code')

    @discount_code = ShopifyAPI::DiscountCode.find(1002091923, params: {price_rule_id: 102586120})
  end

  def test_get_discount_code
    fake 'price_rules/102586120/discount_codes', method: :get, status: 200, body: load_fixture('discount_code')
    discount_code = ShopifyAPI::DiscountCode.find 1002091923, params: { price_rule_id: 102586120 }

    assert_equal 1002091923, discount_code.id
  end

  def test_get_all_discount_codes
    fake 'price_rules/102586120/discount_codes', method: :get, status: 200, body: load_fixture('discount_codes')
    discount_codes = ShopifyAPI::DiscountCode.all params: { price_rule_id: 102586120 }

    assert_equal 1, discount_codes.length
    assert_equal 1002091923, discount_codes.first.id
  end

  def test_create_discount_code
    fake 'price_rules/102586120/discount_codes', method: :post, status: 201, body: load_fixture('discount_code')
    discount_code = ShopifyAPI::DiscountCode.new
    discount_code.prefix_options[:price_rule_id] = 102586120
    discount_code.code = "SUMMERSALE10"
    discount_code.save

    assert_equal '{"discount_code":{"code":"SUMMERSALE10"}}', FakeWeb.last_request.body
  end

  def test_update_discount_code
    discount_code_response = ActiveSupport::JSON.decode(load_fixture('discount_code'))
    discount_code_response['discount_code']['code'] = "WINTERSALE50"
    @discount_code.code = "WINTERSALE50"

    fake 'price_rules/102586120/discount_codes/1002091923', method: :put, status: 200, body: ActiveSupport::JSON.encode(discount_code_response)

    @discount_code.save

    assert_equal discount_code_response['discount_code']['code'], @discount_code.code
  end

  def test_delete_discount_code
    fake 'price_rules/102586120/discount_codes/1002091923', method: :delete, body: 'destroyed'

    assert @discount_code.destroy
  end

  def test_lookup_discount_code
    fake 'discount_code/lookup', method: :get, status: 303, body: load_fixture('discount_code'), url: 'https://this-is-my-test-shop.myshopify.com/admin/discount_codes/lookup.json?code=SUMMERSALE10'

    begin
      result = ShopifyAPI::DiscountCode.lookup(code: "SUMMERSALE10")
    rescue ActiveResource::Redirection
      response = ShopifyAPI::Base.connection.http.session.response
      assert_equal 303, response.status
      assert_match(
        /https:\/\/.*\/admin\/price_rules\/#{@discount_code.price_rule.id}\/discount_codes\/#{@discount_code.id}/,
        response.headers['location']
      )
    end
  end
end
