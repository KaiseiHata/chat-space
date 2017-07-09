$(function() {

  function buildHTML(message) {
    var html = `<div class="right__body__messages__list__message">
                  <div class="right__body__messages__list__message--name">
                    ${ message.user_name }
                  </div>
                  <div class="right__body__messages__list__message--time">
                     ${ message.date }
                  </div>
                  <div class="right__body__messages__list__message--body">
                     ${ message.body }
                  </div>
                </div>`
    return html;
  };

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href;

    $.ajax({
      url: href,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.right__body__messages__list').append(html);
      $('.right__footer').animate({scrollTop: $('right__body__messages__list__message')});
      $('#new_message')[0].reset();
    })
    .fail(function() {
      alert('error');
    });
    return false;
  });
});