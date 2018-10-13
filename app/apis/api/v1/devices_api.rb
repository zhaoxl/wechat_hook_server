module API
  module V1
    class DevicesApi < Grape::API
      resources :devices do
        desc "获取账号"
        params do
          requires :unique_id, type: String, desc: "设备ID"
        end
        get "get_account" do
          begin
            if device = Device.find_by(unique_id: params[:unique_id])
              present({result: "OK", wx_account: device.wx_account, wx_pwd: device.wx_pwd})
            else
              present({result: "DEVICE_NOT_FOUND"})
            end
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end
        
      end
    end
  end
end