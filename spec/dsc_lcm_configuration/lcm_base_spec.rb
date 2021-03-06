# -*- encoding: utf-8 -*-

require "spec_helper"

describe DscLcmConfiguration::LcmBase do

  let(:base_config_settings) do
    {
      :allow_module_overwrite => false,
      :certificate_id => "$null",
      :configuration_mode => "ApplyAndAutoCorrect",
      :configuration_mode_frequency_mins => 30,
      :reboot_if_needed => false,
      :refresh_mode => "PUSH",
      :refresh_frequency_mins => 15,
    }
  end

  describe "Default LCM Properties" do

    let(:lcm) { DscLcmConfiguration::Factory.create("wmf4") }

    it "allow_module_overwrite defaults to false" do
      expect(lcm.allow_module_overwrite).to eq(base_config_settings[:allow_module_overwrite])
    end

    it "certificate_id defaults to $null" do
      expect(lcm.certificate_id).to eq(base_config_settings[:certificate_id])
    end

    it "configuration_mode defaults to ApplyAndAutoCorrect" do
      expect(lcm.configuration_mode).to eq(base_config_settings[:configuration_mode])
    end

    it "configuration_mode_frequency_mins defaults to 30" do
      expect(lcm.configuration_mode_frequency_mins).to eq(base_config_settings[:configuration_mode_frequency_mins])
    end

    it "reboot_if_needed defaults to false" do
      expect(lcm.reboot_if_needed).to eq(base_config_settings[:reboot_if_needed])
    end

    it "refresh_mode defaults to PUSH" do
      expect(lcm.refresh_mode).to eq(base_config_settings[:refresh_mode])
    end

    it "refresh_frequency_mins defaults to 15" do
      expect(lcm.refresh_frequency_mins).to eq(base_config_settings[:refresh_frequency_mins])
    end
  end

  describe "Base LCM Script" do
    let(:lcm) { DscLcmConfiguration::Factory.create("wmf4") }
    let(:base_config_script) do
      <<-EOH
        configuration SetupLCM
        {
          LocalConfigurationManager
          {
            AllowModuleOverwrite = [bool]::Parse('false')
            CertificateID = $null
            ConfigurationMode = 'ApplyAndAutoCorrect'
            ConfigurationModeFrequencyMins = 30
            RebootNodeIfNeeded = [bool]::Parse('false')
            RefreshFrequencyMins = 15
            RefreshMode = 'PUSH'
          }
        }
      EOH
    end

    it "generates a default LCM configuration script" do
      expect(lcm.lcm_configuration_script).to eq(base_config_script)
    end

    it "returns standard config options" do
      expect(lcm.lcm_config).to eq(base_config_settings)
    end
  end

  describe "With config" do
    let(:lcm_config) { { :allow_module_overwrite => true, :configuration_mode => "ApplyOnly" } }
    let(:lcm_with_config) { DscLcmConfiguration::Factory.create("wmf4", lcm_config) }
    let(:updated_config_script) do
      <<-EOH
        configuration SetupLCM
        {
          LocalConfigurationManager
          {
            AllowModuleOverwrite = [bool]::Parse('true')
            CertificateID = $null
            ConfigurationMode = 'ApplyOnly'
            ConfigurationModeFrequencyMins = 30
            RebootNodeIfNeeded = [bool]::Parse('false')
            RefreshFrequencyMins = 15
            RefreshMode = 'PUSH'
          }
        }
      EOH
    end
    let(:updated_config_settings) do
      {
        :allow_module_overwrite => true,
        :certificate_id => "$null",
        :configuration_mode => "ApplyOnly",
        :configuration_mode_frequency_mins => 30,
        :reboot_if_needed => false,
        :refresh_mode => "PUSH",
        :refresh_frequency_mins => 15,
      }
    end

    it "generates an updated LCM configuration script" do
      expect(lcm_with_config.lcm_configuration_script).to eq(updated_config_script)
    end

    it "returns updated config options" do
      expect(lcm_with_config.lcm_config).to eq(updated_config_settings)
    end
  end

  describe "With improper config" do
    let(:incorrect_lcm_config) { { :allow_module_overwrite => true, :debug_mode => "None" } }
    let(:lcm_with_incorrect_config) do
      DscLcmConfiguration::Factory.create("wmf4", incorrect_lcm_config)
    end
    let(:incorrect_config_settings) do
      {
        :allow_module_overwrite => true,
        :certificate_id => "$null",
        :configuration_mode => "ApplyAndAutoCorrect",
        :configuration_mode_frequency_mins => 30,
        :reboot_if_needed => false,
        :refresh_mode => "PUSH",
        :refresh_frequency_mins => 15,
      }
    end

    it "only has valid configuration keys" do
      expect(lcm_with_incorrect_config.lcm_config).to eq(incorrect_config_settings)
    end
  end
end
