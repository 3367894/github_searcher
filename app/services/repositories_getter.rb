class RepositoriesGetter
  API_URL = 'https://api.github.com/search/repositories'
  PAGE_SIZE = 20


  def initialize(options = {})
    @options = options
  end

  def list
    @list ||= raw_body['items'].map do |item|
      OpenStruct.new(item.slice('html_url', 'full_name', 'description'))
    end
  end

  def total_count
    @total_count ||= raw_body['total_count'] || 0
  end

  def current_page
    @current_page = (@options[:page] || 1).to_i
  end

  def total_pages
    @total_pages ||= (total_count / PAGE_SIZE.to_f).ceil
  end

  private

  def network_getter
    @network_getter ||= NetworkGetter.new(url: API_URL)
  end

  def raw_body
    @raw_body ||= if @options.key?(:q)
                    network_getter.json_body(@options.merge(per_page: PAGE_SIZE))
                  else
                    { 'items' => [], 'total_count' => 0 }
                  end
  end
end
