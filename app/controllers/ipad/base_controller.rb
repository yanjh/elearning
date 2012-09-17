class Ipad::BaseController < ApplicationController
  filter_access_to :all
  layout 'ipad'
end