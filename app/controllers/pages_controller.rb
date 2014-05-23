class PagesController < ApplicationController
  include HighVoltage::StaticPage
  load_and_authorize_resource
  
end

