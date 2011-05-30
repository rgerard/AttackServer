class ApplicationController < ActionController::Base
  helper :all
  
  protect_from_forgery :unless => :iphone_request?
  
  before_filter :ensure_domain
  before_filter :adjust_format_for_mobilesafari  

  def ensure_domain
	# HTTP 301 is a "permanent" redirect
	redirect_to "http://www.antambush.com", :status => 301
  end
  

  private
  
  def adjust_format_for_mobilesafari
    if request.env["HTTP_USER_AGENT"] && 
       (request.env["HTTP_USER_AGENT"].match(/iPhone|Darwin/) || request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/])
      request.format = :mobilesafari
    end
  end
  
  def iphone_request?
    request.env["HTTP_USER_AGENT"] && (request.env["HTTP_USER_AGENT"].match(/iPhone|Darwin/) || request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/])
  end
end