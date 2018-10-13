class DevicesController < ApplicationController
  def index
    @datas = Device.where("").paginate(page: params["page"]).per_page(params["perpage"]||100)
  end
  
  def show
    @data = Device.find(params[:id])
  end
  
  
end
