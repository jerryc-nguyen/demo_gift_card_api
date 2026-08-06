module Clients
  class Base
    attr_reader :client, :options

    def initialize(client:, options: {})
      @client = client
      @options = options
    end
  end
end
