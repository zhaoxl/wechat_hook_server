class FriendsController < ApplicationController
  def show
    @account = WxAccount.find(params[:wx_account_id])
    @friend = Friend.find(params[:id])
    @messages = Message.where(friend_id: @friend.id)
  end
end
