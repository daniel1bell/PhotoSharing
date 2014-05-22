var myApp = myApp || {};

myApp.toggleEmailSignup = function() {

  $('#email_signin_box').slideToggle("slow")

}



myApp.showUpdating = function() {
  $('.long_short').hide();
  $('#updatemessage').slideDown();
  $('#updatetext').slideDown();
};


myApp.setup = function() {
  $('#show_email_signin').on('click', myApp.toggleEmailSignup);
  $('#picture_upload_button').on('click', myApp.showUpdating);
}



$(myApp.setup);