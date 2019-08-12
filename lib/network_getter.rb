class NetworkGetter
  def initialize(url:)
    @url = url
  end

  def json_body(params)
    JSON.parse(response(params).body)
  rescue StandardError
    nil
  end

  private

  def response(params)
    Faraday.new(@url, params: params).get
  end
end
