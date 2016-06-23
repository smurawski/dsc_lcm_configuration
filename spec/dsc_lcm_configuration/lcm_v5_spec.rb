# -*- encoding: utf-8 -*-

require "spec_helper"

describe DscLcmConfiguration::LcmV5 do

  let(:base_config_settings) do
    {
      :action_after_reboot => "StopConfiguration",
      :allow_module_overwrite => false,
      :certificate_id => "$null",
      :configuration_mode => "ApplyAndAutoCorrect",
      :configuration_mode_frequency_mins => 15,
      :debug_mode => "All",
      :reboot_if_needed => false,
      :refresh_mode => "PUSH",
      :refresh_frequency_mins => 30
    }
  end

  describe "Default LCM Properties" do
    let(:lcm) { DscLcmConfiguration::Factory.create("wmf5") }

    it "action_after_reboot defaults to false" do
      expect(lcm.action_after_reboot).to eq(base_config_settings[:action_after_reboot])
    end

    it "allow_module_overwrite defaults to false" do
      expect(lcm.allow_module_overwrite).to eq(base_config_settings[:allow_module_overwrite])
    end

    it "certificate_id defaults to $null" do
      expect(lcm.certificate_id).to eq(base_config_settings[:certificate_id])
    end

    it "configuration_mode defaults to ApplyAndAutoCorrect" do
      expect(lcm.configuration_mode).to eq(base_config_settings[:configuration_mode])
    end

    it "configuration_mode_frequency_mins defaults to 15" do
      expect(lcm.configuration_mode_frequency_mins).to eq(base_config_settings[:configuration_mode_frequency_mins])
    end

    it "debug_mode defaults to All" do
      expect(lcm.debug_mode).to eq(base_config_settings[:debug_mode])
    end

    it "reboot_if_needed defaults to false" do
      expect(lcm.reboot_if_needed).to eq(base_config_settings[:reboot_if_needed])
    end

    it "refresh_mode defaults to PUSH" do
      expect(lcm.refresh_mode).to eq(base_config_settings[:refresh_mode])
    end

    it "refresh_frequency_mins defaults to 30" do
      expect(lcm.refresh_frequency_mins).to eq(base_config_settings[:refresh_frequency_mins])
    end
  end

  describe "Base LCM Script" do
    let(:lcm) { DscLcmConfiguration::Factory.create("wmf5") }
    let(:base_config_script) {
      <<-EOH
        [DSCLocalConfigurationManager()]
        configuration SetupLCM
        {
          Settings
          {
            ActionAfterReboot = 'StopConfiguration'
            AllowModuleOverwrite = [bool]::Parse('false')
            CertificateID = $null
            ConfigurationMode = 'ApplyAndAutoCorrect'
            ConfigurationModeFrequencyMins = 15
            DebugMode = 'All'
            RebootNodeIfNeeded = [bool]::Parse('false')
            RefreshFrequencyMins = 30
            RefreshMode = 'PUSH'
          }
        }
      EOH
    }

    it "generates a default LCM configuration script" do
      expect(lcm.lcm_configuration_script).to eq(base_config_script)
    end

    it "returns standard config options" do
      expect(lcm.lcm_config).to eq(base_config_settings)
    end
  end

  describe "With config" do
    let(:lcm_config) { { :allow_module_overwrite => true, :configuration_mode => "ApplyOnly" } }
    let(:lcm_with_config) { DscLcmConfiguration::Factory.create("wmf5", lcm_config) }
    let(:updated_config_script) do
      <<-EOH
        [DSCLocalConfigurationManager()]
        configuration SetupLCM
        {
          Settings
          {
            ActionAfterReboot = 'StopConfiguration'
            AllowModuleOverwrite = [bool]::Parse('true')
            CertificateID = $null
            ConfigurationMode = 'ApplyOnly'
            ConfigurationModeFrequencyMins = 15
            DebugMode = 'All'
            RebootNodeIfNeeded = [bool]::Parse('false')
            RefreshFrequencyMins = 30
            RefreshMode = 'PUSH'
          }
        }
      EOH
    end
    let(:updated_config_settings) do
      {
        :action_after_reboot => "StopConfiguration",
        :allow_module_overwrite => true,
        :certificate_id => "$null",
        :configuration_mode => "ApplyOnly",
        :configuration_mode_frequency_mins => 15,
        :debug_mode => "All",
        :reboot_if_needed => false,
        :refresh_mode => "PUSH",
        :refresh_frequency_mins => 30
      }
    end

    it "generates an updated LCM configuration script" do
      expect(lcm_with_config.lcm_configuration_script).to eq(updated_config_script)
    end

    it "returns updated config options" do
      expect(lcm_with_config.lcm_config).to eq(updated_config_settings)
    end
  end
end
