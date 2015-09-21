class Reviews

  init: ->
    @bindNewReviewForm()

  bindNewReviewForm: ->

    $(document).on 'submit', '#review-form', (event) ->
      event.preventDefault()
      $form = $(event.currentTarget)
      $data = new FormData($form[0])
      $.ajax
        url: $form.attr('action'),
        data: $data,
        dataType: 'json',
        processData: false,
        contentType: false,
        type: "POST"
        error: (data, status, xhr) ->
          alert "Error posting your review."
        success: (data, status, xhr) ->
          $('#review-form-section').replaceWith(data['form'])
          if data['review']
            $('#reviews-list').append(data['review'])

  constructor: ->
    @init()

new Reviews()
