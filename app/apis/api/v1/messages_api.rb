module API
  module V1
    class MessagesApi < Grape::API
      resources :messages do
        desc "保存消息"
        params do
          requires :unique_id, type: String, desc: "设备ID"
          requires :msg_id, type: String, desc: "消息ID"
          requires :talker, type: String, desc: "发送人"
          requires :msg_type, type: Integer, desc: "消息类型"
          requires :content, type: String, desc: "内容"
          requires :create_time, type: Integer, desc: "创建时间戳"
          requires :is_send, type: Integer, desc: "是否是发送消息"
          optional :md5, type: String, desc: "MD5"
        end
        post "save" do
          begin
            p "msg_id:"+params[:msg_id]
            p "unique_id:"+params[:unique_id]
            p "talker:"+params[:talker]
            p "msg_type:"+params[:msg_type].to_s
            p "raw:"+params[:raw]
            p "content:"+params[:content]
            p "create_time:"+params[:create_time].to_s
            p "is_send:"+params[:is_send].to_s
            
            
            if device = Device.find_by(unique_id: params[:unique_id])
              #如果是资源则获取MD5
              case params[:msg_type].to_i
                when 3 then #图片
                  md5 = params[:content].match(/md5="(.+)"/)[1] rescue nil
                  Message.create!(msg_id: params[:msg_id], device_id: device.id, talker: params[:talker], msg_type: Message.convert_msg_type(params[:msg_type].to_i), raw: params[:raw], content: params[:content], create_time: params[:create_time].to_i, is_send: params[:is_send]==1, md5: md5)
                else
                  msg = Message.create!(msg_id: params[:msg_id], device_id: device.id, talker: params[:talker], msg_type: Message.convert_msg_type(params[:msg_type].to_i), raw: params[:raw], content: params[:content], create_time: params[:create_time].to_i, is_send: params[:is_send]==1, md5: md5)
              end
              
            end
            
            present({result: "OK"})
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end

        desc "上传图片"
        params do
          requires :unique_id, type: String, desc: "设备ID"
          requires :md5, type: String, desc: "MD5"
          requires :file, type: File, desc: "文件"
        end
        post "upload_image" do
          begin
            p "unique_id:"+params[:unique_id]
            p "md5:"+params[:md5]
            p "file:"+params[:file].to_s
            
            if device = Device.find_by(unique_id: params[:unique_id])
              if message = Message.find_by(device_id: device.id, md5: params[:md5])
                message.image = params[:file]
                message.save
              end
            end
            
            present({result: "OK"})
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end
        
        desc "上传音频"
        params do
          requires :unique_id, type: String, desc: "设备ID"
          requires :msg_id, type: String, desc: "msg_id"
          requires :file, type: File, desc: "文件"
        end
        post "upload_voice" do
          begin
            p "unique_id:"+params[:unique_id]
            p "msg_id:"+params[:msg_id]
            p "file:"+params[:file].to_s
            
            if device = Device.find_by(unique_id: params[:unique_id])
              if message = Message.find_by(device_id: device.id, msg_id: params[:msg_id])
                message.voice.attach(io: File.open(params[:file][:tempfile]), filename: params[:file][:filename])
              end
            end
            
            present({result: "OK"})
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end
        
        desc "更新转账状态"
        params do
          requires :unique_id, type: String, desc: "设备ID"
          requires :msg_id, type: String, desc: "msg_id"
          requires :state, type: String, desc: "状态"
          requires :is_send, type: String, desc: "是否是发送消息"
        end
        post "add_remittance_record" do
          begin
            p "unique_id:"+params[:unique_id]
            p "msg_id:"+params[:msg_id]
            p "state:"+params[:state].to_s
            p "is_send:"+params[:is_send].to_s
            
            
            if device = Device.find_by(unique_id: params[:unique_id])
              if message = Message.find_by(device_id: device.id, msg_id: params[:msg_id])
                feedesc = message.content.match(/\<feedesc\><\!\[CDATA\[￥([\d\.]+)\]\]>\<\/feedesc\>/)[1]
                RemittanceRecord.create(device: device, message: message, talker: message.talker, msg_id: params[:msg_id], is_send: params[:is_send]=="true", state: params[:state], feedesc: feedesc)
              end
            end
            
            present({result: "OK"})
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end
        
        desc "记录红包状态"
        params do
          requires :unique_id, type: String, desc: "设备ID"
          requires :hb_status, type: String, desc: "红包状态"
          requires :hb_type, type: String, desc: "红包类型"
          requires :receive_status, type: String, desc: "领取状态"
          requires :receive_time, type: Integer, desc: "时间戳"
          requires :receive_amount, type: Integer, desc: "收到金额(分)"
          optional :content, type: String, desc: "详细内容"
          optional :sendusername, type: String, desc: "发送人"
        end
        post "add_wallet_lucky_money_record" do
          begin
            if device = Device.find_by(unique_id: params[:unique_id])
              talker = params[:sendusername]
              WalletLuckyMoney.create(device: device, talker: talker, hb_status: params[:hb_status], hb_type: params[:hb_type], receive_status: params[:receive_status], receive_time: params[:receive_time], receive_amount: params[:receive_amount], content: params[:content])
            end
            
            present({result: "OK"})
          rescue ActiveRecord::RecordNotFound => ex
            app_uuid_error("#{__FILE__}:#{__LINE__}")
          end
        end
        
      end
    end
  end
end