require 'spec_helper'

describe RepositoriesController, type: :controller do
  let!(:request_stub) do
    stub_request(
      :get,
      /#{RepositoriesGetter::API_URL}/).
      to_return(status: 200, body: { 'total_count' => 0, 'items' => [] }.to_json)
  end

  describe 'GET list of repositories' do
    it 'has success request' do
      get '/', q: 'a'
      expect(last_response.status).to eq(200)
    end

    it 'has error if has not required parameter' do
      get '/'
      expect(last_response.status).to eq(400)
    end

    it 'has error if per_page not integer' do
      get '/', q: 'a', page: 'a'
      expect(last_response.status).to eq(400)
    end
  end
end
