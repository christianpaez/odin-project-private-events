class ApplicationController < ActionController::Base
    def current_user
        user_id = cookies[:user_id]
        if user_id
            begin
                @current_user = User.find(user_id)
            rescue ActiveRecord::RecordNotFound
                redirect_to new_user_path, flash: {alert: "Can`t find user, please create one!"}                
            end
        end
        
    end
    
end
