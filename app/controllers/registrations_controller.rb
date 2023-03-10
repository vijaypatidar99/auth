class RegistrationsController < ApplicationController

    def new
        @user = User.new
      end

      
      def create
        @user = User.new(user_params)
        if @user.save
        # stores saved user id in a session
        WelcomeMailer.with(user: @user).welcome_email.deliver_now
          session[:user_id] = @user.id
          render 'welcome/userlogin'
        else
          redirect_to sign_in_path, alert: 'You must be signed up with different account or try login'
        end
      end
      
      private
      def user_params
        # strong parameters
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
end
