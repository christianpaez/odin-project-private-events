class ApplicationController < ActionController::Base
    def current_user
        user_id = cookies[:user_id]
        if user_id
            @current_user = User.find(user_id)
        end
        
    end
    
end
