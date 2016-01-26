module Mongoid
  module Document
    def as_good_json(options=nil)
      tmp_json = as_json(options)
      tmp_json['id'] = tmp_json['_id'].to_s if tmp_json['_id']
      tmp_json.delete '_id'
      tmp_json
    end

    def to_good_json(options=nil)
      as_good_json(options).to_json
    end
  end

  class Criteria
    def as_good_json(options = nil)
      entries.as_good_json(options)
    end

    def to_good_json(options = nil)
      entries.to_good_json(options)
    end
  end
end

class Array
  def as_good_json(options = nil) #:nodoc:
    map { |v| options ? v.as_good_json(options.dup) : v.as_good_json }
  end

  def to_good_json(options = nil) #:nodoc:
    map { |v| options ? v.to_good_json(options.dup) : v.to_good_json }
  end
end
