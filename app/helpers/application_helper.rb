module ApplicationHelper
  def current_uri
    current_uri = request.env['PATH_INFO']
  end
end
