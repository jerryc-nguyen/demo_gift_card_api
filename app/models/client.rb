class Client < ApplicationRecord
  validates :api_key, uniqueness: true

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
  end

end
