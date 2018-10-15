class WxAccountsController < ApplicationController
  def index
    @datas = WxAccount.where("").paginate(page: params["page"]).per_page(params["perpage"]||100)
  end
  
  def show
    @data = WxAccount.find(params[:id])
    @last_login_device = Device.find_by(wx_account_id: @data.id)
    @friends = @data.friends
  end
  
  
end
