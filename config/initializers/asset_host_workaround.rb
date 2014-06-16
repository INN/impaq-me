if  (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR > 0) || Rails::VERSION::MAJOR > 4
  raise "Delete #{__FILE__}, this workaround is no longer needed. (See: https://github.com/rails/rails/pull/12622 which landed in 4.1)"
end

class ActionController::Base
  def self.helpers
    @helper_proxy ||= begin
      proxy = ActionView::Base.new
      proxy.config = config.inheritable_copy
      proxy.extend(_helpers)
    end
  end
end
