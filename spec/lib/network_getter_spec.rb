require_relative '../spec_helper'

describe NetworkGetter do
  subject { described_class.new(url: 'https://api.github.com/search/repositories') }
  before(:each) do
    stub_request(:get, /api.github.com/).
      to_return(status: 200, body: "{\"total_count\":1635,\"incomplete_results\":false}")
  end
  let(:body) do
    {
      'total_count' => 1635,
      'incomplete_results' => false
    }
  end

  it 'returns json body' do
    expect(subject.json_body({ q: 'test' })).to eq(body)
  end
end
