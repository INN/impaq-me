require 'addressable/uri'

class CleansUrls
  def initialize(url_string)
    (@url = Addressable::URI.heuristic_parse(url_string).normalize).tap do |url|
      strip_impaq_me_query_params!(url)
    end
  end

  def to_s
    @url.to_s
  end

  def inspect
    @url.to_s
  end

  def as_uri
    @url
  end

private

  def strip_impaq_me_query_params!(url)
    if !url.query_values.nil?
      url.query_values = url.query_values.except('shared_via_impaq_me')
      url.query_values = nil if url.query_values.size == 0
    end
    return url
  end
end
