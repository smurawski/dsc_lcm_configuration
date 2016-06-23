require "spec_helper"

describe DscLcmConfiguration do
  it "has a version number" do
    expect(DscLcmConfiguration::VERSION).not_to be nil
  end

  it "defaults to the LCM base config" do
    expect(DscLcmConfiguration::LcmBase).to receive(:new)
    expect(DscLcmConfiguration::LcmV4).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV5).to_not receive(:new)
    DscLcmConfiguration::Factory.create()
  end

  it "returns LcmV4 for `wmf4_with_update`" do
    expect(DscLcmConfiguration::LcmBase).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV4).to receive(:new)
    expect(DscLcmConfiguration::LcmV5).to_not receive(:new)
    DscLcmConfiguration::Factory.create("wmf4_with_update")
  end

  it "returns LcmV4 for `4`" do
    expect(DscLcmConfiguration::LcmBase).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV4).to receive(:new)
    expect(DscLcmConfiguration::LcmV5).to_not receive(:new)
    DscLcmConfiguration::Factory.create("4")
  end

  it "returns LcmV5 for `wmf5`" do
    expect(DscLcmConfiguration::LcmBase).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV4).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV5).to receive(:new)
    DscLcmConfiguration::Factory.create("wmf5")
  end

  it "returns LcmV4 for `5`" do
    expect(DscLcmConfiguration::LcmBase).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV4).to_not receive(:new)
    expect(DscLcmConfiguration::LcmV5).to receive(:new)
    DscLcmConfiguration::Factory.create("5")
  end
end
