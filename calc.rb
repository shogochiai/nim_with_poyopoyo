require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'pp'

class Calc
  def self.calc_max num
    max = num.max
    max_hash = Hash.new
    num.each.with_index(1) do |value, i|
      if value == max
        max_hash[:id] = i - 1
        max_hash[:max] = max
      end
    end
    if max_hash.empty?
      max_hash[:id] = nil
      max_hash[:max] = nil
      max_hash
    else
      return max_hash
    end
  end
end
