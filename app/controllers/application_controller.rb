class ApplicationController < ActionController::Base
    def current_user
        user_id = cookies[:user_id]
        if user_id
            begin
                @current_user = User.find(user_id)
            rescue ActiveRecord::RecordNotFound
                redirect_to new_user_path, flash: {warning: "User not found, Create a user!"}                
            end
        else
            redirect_to sign_in_users_path, flash: {info: "Please Login!"}
        end
        
    end
    
end
