class WxAccountsController < ApplicationController
  def index
    @datas = WxAccount.where("").paginate(page: params["page"]).per_page(params["perpage"]||100)
  end
  
  def show
    @data = WxAccount.find(params[:id])
  end
  
  
end
