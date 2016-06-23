require 'spec_helper'

describe DscLcmConfiguration do
  it 'has a version number' do
    expect(DscLcmConfiguration::VERSION).not_to be nil
  end

  it 'defaults to the LCM base config' do
    expect(DscLcmConfiguration::LcmBase).to receive(:new)
    expect(DscLcmConfiguration::LcmV4).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV5).to_not receive(:new)
    DscLcmConfiguration::Factory.create()
  end
end
