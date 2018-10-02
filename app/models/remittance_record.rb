class RemittanceRecord < ApplicationRecord
  belongs_to    :device
  belongs_to    :message
end


=begin
#6.6.7版本 state
1         新转账
3         已接收
4         手动退回
=end