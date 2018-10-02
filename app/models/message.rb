class Message < ApplicationRecord
  belongs_to  :device
  has_one_attached :voice
  
  mount_uploader :image, MessageImageUploader
  
  
end

=begin
#6.6.7版本 type
1         文本消息
34        语音消息
3         图片消息
436207665 红包消息
419430449 转账消息
=end