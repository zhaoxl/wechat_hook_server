class Message < ApplicationRecord
  extend Enumerize

  enumerize :msg_type, in: [:text, :voice, :image, :red, :transfer]
    
    
  belongs_to  :device
  has_one_attached :voice
  
  mount_uploader :image, MessageImageUploader
  
  def self.convert_msg_type(msg_type_id)
    case msg_type_id
    when 1 then :text
    when 34 then :voice
    when 3 then :image
    when 436207665 then :red
    when 419430449 then :transfer
    end
  end
end


=begin
#6.6.7版本 type
1         文本消息
34        语音消息
3         图片消息
436207665 红包消息
419430449 转账消息
=end