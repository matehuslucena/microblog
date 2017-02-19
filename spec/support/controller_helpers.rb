module ControllerHelpers
  def sign_in
    # if user.nil?
    #   allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    #   allow(controller).to receive(:current_user).and_return(nil)
    # else
    #   allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    #   allow(controller).to receive(:current_user).and_return(user)
    # end
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:user)
    end
  end
end
