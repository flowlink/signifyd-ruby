require 'spec_helper'

describe Signifyd do
  let(:hash) { SignifydRequests.valid_case }
  let(:json) { JSON.dump(hash) }
  
  context '.verify_ssl_certs' do
    context 'when calling for the verify_ssl_certs' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
      }
      
      subject {
        Signifyd.verify_ssl_certs = true
      }
      
      it { should be_true }
      it { should_not be_nil }
      it { expect(subject).to eq(true) }
    end
  end
  
  context '.verify_ssl_certs=' do
    context 'when setting the verify_ssl_certs' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
        Signifyd.verify_ssl_certs = true
      }
      
      subject { 
        Signifyd.verify_ssl_certs = false
      }
      
      it { should be_false }
      it { should_not be_nil }
      it { expect(subject).to eq(false) }
    end
  end
  
  context '.api_base=' do
    context 'when setting the api_base' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
        Signifyd.api_base = 'https://api.signifyd.com'
      }
      
      subject { 
        Signifyd.api_base = 'https://signifyd.com'
      }
      
      it { should be_true }
      it { should_not be_nil }
      it { expect(subject).to eq('https://signifyd.com') }
    end
  end
  
  context '.api_base' do
    context 'when calling for the api_base' do 
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
      }
      
      subject {
        Signifyd.api_base
      }
      
      it { should be_true }
      it { should_not be_nil }
      it { expect(subject).to eq('https://api.signifyd.com') }
    end
  end
  
  context '.api_version=' do
    context 'when setting the api_version' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
        Signifyd.api_version = '/v1' 
      }
      
      subject { 
        Signifyd.api_version = '/v2' 
      }
      
      it { should be_true }
      it { should_not be_nil }
      it {
        expect(subject).to eq('/v2')
      }
    end
  end
  
  context '.api_version' do    
    context 'when calling for the api_version' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
      }
      
      subject {
        Signifyd.api_version
      }
      
      it { should be_true }
      it { should_not be_nil }
      it {
        expect(subject).to eq('/v1')
      }
    end
  end
  
  context '.api_key' do
    context 'when setting an invalid API key' do
      context 'and when checking with the .configured? method' do
        subject {
          Signifyd.configured?
        }

        it { should_not be_nil }
        it { should be_false }
      end
    
      context 'and when checking the actual value' do
        subject {
          Signifyd.api_key
        }

        it { should be_nil }
        it { should be_false }
      end
    end
    
    context 'when setting a valid API key' do
      before { 
        Signifyd.api_key = SIGNIFYD_API_KEY 
      }
      
      after { 
        Signifyd.api_key = nil 
      }

      subject {
        Signifyd.configured?
      }

      it { should_not be_nil }
      it { should be_true }
    end
  end
  
  context '.request' do    
    context 'with a valid API key set' do
      before {
        Signifyd.api_key = SIGNIFYD_API_KEY
        
        stub_request(:post, "https://#{Signifyd.api_key}@api.signifyd.com/v1/cases").
          with(:body => json, :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>json.size, 'Content-Type'=>'application/json', 'User-Agent'=>'Signifyd Ruby v1'}).
          to_return(:status => 201, :body => "{\"investigationId\":14065}", :headers => {})
      }
    
      after {
        Signifyd.api_key = nil
      }
      
      subject {
        Signifyd.request(:post, '/v1/cases', hash)
      }
      
      it { should_not be_nil }
      it { should be_true }
    end
  end
end