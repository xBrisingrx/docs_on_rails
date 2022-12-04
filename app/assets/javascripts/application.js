//= require rails-ujs
//= require activestorage

//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap
//= require unify/hs.megamenu
//= require unify/hs.core
//= require unify/components/hs.header
//= require unify/helpers/hs.hamburgers
//= require vendor/datatables
//= require vendor/noty/noty.min
//= require vendor/select2/select2.full


$(document).on('ready', function () {
  // initialization of header
  $.HSCore.components.HSHeader.init($('#js-header'));
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  $('.js-mega-menu').HSMegaMenu({
   event: 'hover',
   pageContainer: $('.container'),
   breakpoint: 991
  });
});