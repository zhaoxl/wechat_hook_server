class Device < ApplicationRecord
  belongs_to  :wx_account
  has_many  :messages
end
