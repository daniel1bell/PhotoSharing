var myApp = myApp || {};

myApp.toggleEmailSignup = function() {

  $('#email_signin_box').slideToggle("slow")

}


myApp.setup = function() {
  $('#show_email_signin').on('click', myApp.toggleEmailSignup);
}

$(myApp.setup);