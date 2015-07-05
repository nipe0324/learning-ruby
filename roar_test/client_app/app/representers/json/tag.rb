module Json
  class Tag < OpenStruct
    module Representer
      include Roar::JSON

      property :id
      property :name
    end

    module Client
      include Roar::JSON
      include Representer

      property :id, as: :remote_tag_id
    end
  end
end
