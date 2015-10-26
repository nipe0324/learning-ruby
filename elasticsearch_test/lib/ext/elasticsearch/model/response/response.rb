module Elasticsearch
  module Model
    module Response
      class Response
        def suggest
          response['suggest'] ? Hashie::Mash.new(response['suggest']) : nil
        end
      end
    end
  end
end
