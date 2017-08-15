require 'spec_helper'
require 'routemaster/client/subscription'

describe Routemaster::Client::Subscription do
  describe '#initialize' do
    let(:options) {{ 
      'subscriber' => 'alice', 
      'callback'   => 'https://example.com/events',
      'topics'     => %w[widgets],
      'events'     => {},
    }}

    subject { described_class.new(options) }
    
    it 'passes' do
      expect { subject }.not_to raise_error
    end
  end
end