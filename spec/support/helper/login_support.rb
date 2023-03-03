# frozen_string_literal: true

module LoginSupport
  def login_as(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: user.id } }
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
