require_relative '../spec_helper'

describe RepositoriesGetter do
  let(:data) do
    {
      'total_count' => 100,
      'items' => [
        {
          'html_url' => 'https://github.com/daniel-e',
          'description' => 'Tetris that fits into the boot sector.',
          "full_name" => 'daniel-e/tetros'
        },
        {
          'html_url' => 'https://github.com/robbyrussell/oh-my-zsh',
          'description' => 'A delightful community-driven...',
          "full_name" => 'robbyrussell/oh-my-zsh'
        }
      ]
    }
  end

  subject { described_class.new(options) }
  let!(:request_stub) do
    stub_request(
      :get,
      /#{described_class::API_URL}\?per_page=#{described_class::PAGE_SIZE}&q=tet/).
      to_return(status: 200, body: data.to_json)
  end
  let(:options) { { q: 'tet' } }

  describe '#all' do
    context 'empty query' do
      let(:options) { {} }

      it 'returns empty list if have not query' do
        expect(subject.list).to eq([])
      end
    end

    context 'with query' do
      it 'returns list of repositories' do
        request_stub
        items = data['items'].map { |item| OpenStruct.new(item) }

        expect(subject.list).to eq(items)
      end

      it 'get items by query' do
        subject.list

        expect(request_stub).to have_been_requested
      end
    end

    context 'with pagination' do
      let(:options) { { page: 2, q: 'z' } }

      it 'get items by page' do
        stub = stub_request(
          :get,
          /#{described_class::API_URL}\?page=2&per_page=#{described_class::PAGE_SIZE}&q=z/
        ).to_return(status: 200, body: data.to_json)

        subject.list

        expect(stub).to have_been_requested
      end
    end
  end

  describe '#total_count' do
    it 'returns count' do
      expect(subject.total_count).to eq(100)
    end

    context 'empty query' do
      let(:options) { {} }

      it 'returns zero if have not query' do
        expect(subject.total_count).to eq(0)
      end
    end
  end

  describe '#total_pages' do
    it 'returns count of pages' do
      expect(subject.total_pages).to eq(5)
    end
  end

  describe '#current_page' do
    let(:options) { { page: 2, q: 'z' } }

    it 'returns current_page' do
      expect(subject.current_page).to eq(2)
    end
  end
end
