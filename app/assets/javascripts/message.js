$(function() {

  function buildHTML(message) {
  var image = `<div class="right__body__messages__list__message--image">
                <img src="${ message.image }" alt="image">
              </div>`;

    if(message.body && message.image) {
      var html = `<div class="right__body__messages__list__message" data-message-id='${ message.data }'>
                    <div class="right__body__messages__list__message--name">
                      ${ message.user_name }
                    </div>
                    <div class="right__body__messages__list__message--time">
                      ${ message.date }
                    </div>
                    <div class="right__body__messages__list__message--body">
                      ${ message.body }
                    </div>
                    ${ image }
                  </div>`;
    } else if (message.body) {
      var html = `<div class="right__body__messages__list__message" data-message-id='${ message.data }'>
                    <div class="right__body__messages__list__message--name">
                      ${ message.user_name }
                    </div>
                    <div class="right__body__messages__list__message--time">
                      ${ message.date }
                    </div>
                    <div class="right__body__messages__list__message--body">
                      ${ message.body }
                    </div>
                  </div>`;
    } else if (message.image) {
      var html = `<div class="right__body__messages__list__message" data-message-id='${ message.data }'>
                    <div class="right__body__messages__list__message--name">
                      ${ message.user_name }
                    </div>
                    <div class="right__body__messages__list__message--time">
                      ${ message.date }
                    </div>
                    <div class="right__body__messages__list__message--body">
                    </div>
                    ${ image }
                  </div>`;
    }
      return html;
  };

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href

    $.ajax({
      url: href,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
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

  var interval = setInterval(function() {
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      var href = window.location.href
      var data = $('.right__body__messages__list__message').last().data('message-id');
      console.log(data);
  $.ajax({
    url: href,
    data: {
      data_id: data
    },
    dataType: 'json'
  })
  .done(function(json) {
    // console.log(json);
    // console.log(json.messages);
    json.forEach(function(message) {
      console.log(message);
      var insertHTML = buildHTML(message);
      $(".right__body__messages__list__message").html(insertHTML);
    });
    })
    .fail(function(json) {
      alert("自動更新に失敗しました");
    })
  } else {
    clearInterval(interval);
   }} , 30000 );
});