require "dsc_lcm_configuration/version"
require "dsc_lcm_configuration/lcm_base"
require "dsc_lcm_configuration/lcm_v4"
require "dsc_lcm_configuration/lcm_v5"

module DscLcmConfiguration
  class Factory
    def self.create(version = "wmf4", options = {})
      case version.to_s.downcase
      when "4", "wmf4_with_update"
        LcmV4.new(options)
      when "5", "wmf5"
        LcmV5.new(options)
      else
        LcmBase.new(options)
      end
    end
  end
end
