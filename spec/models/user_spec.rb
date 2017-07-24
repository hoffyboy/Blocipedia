require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "attributes" do
    it "should have email attributes" do
      expect(user).to have_attributes(email: user.email)
    end
  end
end
