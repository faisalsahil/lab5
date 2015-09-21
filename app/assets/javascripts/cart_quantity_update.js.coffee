class CartQuantityUpdate

  initCartQuantitySelectBindings: ->
    $(document).on 'change', '[data-behaviour=cart-quantity-select]', (event) ->
      $select = $(event.currentTarget)
      selected_quantity = $select.find('option:selected').first().val()
      product_id = $select.data('product-id')
      url = "#{$select.data("cart-path")}/?product_id=#{product_id}&quantity=#{selected_quantity}"

      $.ajax
        url: url
        type: "PUT"
        error: (data, status, xhr) ->
          alert "Error updating quantity"
        success: (data, status, xhr) ->
          $('.cart-table').replaceWith(data['content'])

      false

  constructor: ->
    @initCartQuantitySelectBindings()

new CartQuantityUpdate()
