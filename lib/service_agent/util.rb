module ServiceAgent
  module Util
    def self.minute(unit)
      unit * 60
    end

    def self.minutes(*units)
      units.map { |unit| minute(unit) }
    end
  end
end
