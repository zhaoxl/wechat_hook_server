class WxAccount < ApplicationRecord
  has_many  :friends
  
  include AASM

  aasm column: :state do
    state :lock
    state :offline, :initial => true
    state :online
  end
end
