// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.tokeninput
//= require jquery.ui.widget
//= require jquery.fileupload
//= require readmore.min
//= require cropper.min
//= require loadjs
//= require bootstrap
//= require subscriber
//= require sticky_kit
//= require index
//= require holder
//= require class_forum
//= require class_landing
//= require edit_profile
//= require account_config
//= require_tree ./channels
//= require_tree ./contents
//= require bootstrap-progressbar.min
//= require i18n
//= require i18n/translations
//= require async_form
//= require jquery.raty
//= require ckeditor/init
//= require bootstrap-switch
//= require bootstrap-tagsinput

//= require channel_angular
//= require forum/forum_app
//= require forum/stateConfig
//= require_tree ./forum/directives
//= require_tree ./forum/filters
//= require_tree ./forum/controllers
//= require_tree ./forum/services
//= require forum/upload
//= require channel_view

//= require angular
//= require angular-animate
//= require angular-sanitize
//= require angular-resource
//= require moment-with-locales
//= require angular-moment.min
//= require angular-ui-router.min
//= require angular-rails-templates
//= require ui-bootstrap-tpls-0.12.1.min
//= require xeditable.min
//= require_tree ../templates

//= require rating
//= require see_more
//= require footer
//= require_tree ./courses

I18n.defaultLocale = "es";
I18n.locale = $('html').attr('lang');
