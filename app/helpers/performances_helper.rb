module PerformancesHelper
  def path_for(url)
    uri = Addressable::URI.heuristic_parse(url).normalize
    uri.path + (uri.query.present? ? "?#{uri.query}" : "")
  end
end
