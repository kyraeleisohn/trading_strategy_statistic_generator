module StrategyTester
  class JSONConvertible
    def to_hash
      hash = {}
      self.instance_variables.each do |var|
        value = self.instance_variable_get(var)
        hash[var.to_s.delete("@")] = (value.class.method_defined? :to_hash) ? value.to_hash : value
      end

      hash
    end
  end
end