module API
  module ApiHelpers
    def app_error tips, error, code=400, location=request.fullpath, error_message=nil
        error!({code: code, tips: tips, error: error, location: location, error_message: error_message}, 200)
    end


    def app_uuid_error location=request.fullpath, error_message=nil
        error!({code: 401, tips: "无效参数, 请检查后重试", error: "Invalid uuid", location: location, error_message: error_message}, 200)
    end


    def server_error tips, error, location=request.fullpath, error_message=nil
        error!({code: 500, tips: tips, error: error, location: location, error_message: error_message}, 200)
    end

    def clear_user_token_cache user_uuid
      $cache.del("api:user:token:#{user_uuid}")
    end

    def find_user_token user_uuid
        key = "api:user:token:#{user_uuid}"
        $cache.read(key) || (user = User.find_uuid(user_uuid); token = Token.where(user_id: user.id, available: true).order(id: :desc).first; $cache.write(key, [user, token], 1.years); [user, token])
    end

    def authenticate_user
      if !params[:user_uuid].nil? and !params[:token].nil?
        begin
          user_token = find_user_token(params[:user_uuid])
          @session_user = user_token[0]
          token = user_token[1]

          #clear user token cache if app accress record
          clear_user_token_cache(@session_user.uuid) if ::AppInfoHelper.app_access_record(request, @session_user)

          error!({code: 401, tips: "授权失效, 请重新登录!", error: "invalid token", location: "authenticate_user", error_message: ""}, 200) if token.nil? or token.content != params[:token]
        rescue ActiveRecord::RecordNotFound
          error!({code: 401, tips: "无效用户，请重新登录!", error: "failed to find the user", location: "authenticate_user", error_message: ""}, 200)
        end
      else
        error!({code: 404, tips: "无效用户，请重新登录!", error: "invalid user uuid", location: "authenticate_user", error_message: ""}, 200)
      end
    end

    def authenticate_user_if_signed_in
      unless params[:user_uuid].blank? or params[:token].blank?
        authenticate_user
      end
    end

  end
  module DOCFormatter
    def self.call object, env
      object.to_json
    end
  end
  module JSONFormatter
    def self.call object, env
      {code: 200, data: object}.to_json
    end

  end
  module ErrorFormatter
    def self.call message, backtrace, options, env, original_exception
     {code: message[:code], data: nil, tips: message[:tips], error: message[:error], location: message[:location], error_message: message[:error_message] || backtrace }.to_json
    end
  end
end