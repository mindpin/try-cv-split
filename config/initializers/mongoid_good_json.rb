module Mongoid
  module Document
    def good_as_json(options=nil)
      tmp_json = as_json(options)
      tmp_json['_id'] = tmp_json['_id'].to_s
      tmp_json
    end

    def good_to_json(options=nil)
      good_as_json(options).to_json
    end
  end
end
