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
//= require vendor/datatables/datatables
//= require vendor/noty/noty
//= require vendor/select2/select2.full
//= require custom

//= require vendor/jquery-validate/jquery.validate
//= require vendor/jquery-validate/additional-methods

//= require companies
//= require people
//= require profiles
//= require documents
//= require documents_profiles
//= require people_profiles
//= require vehicles_profiles
//= require status_documentation
//= require document_renovations
//= require reasons_to_disables
//= require vehicles
//= require vehicle_brands
//= require vehicle_models
//= require vehicle_types
//= require jobs
//= require zone_job_profiles
//= require zone_job_profile_docs
//= require insurances
//= require vehicle_insurances
//= require users
//= require clothes
//= require cost_centers
//= require vehicle_states
//= require zones
//= require cost_center_documents
//= require assignation_statuses
//= require vehicles_cost_centers
//= require assignments
//= require reports

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