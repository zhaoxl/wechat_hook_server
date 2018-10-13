require 'grape'
require 'grape-entity'


class ApiBase < Grape::API
  mount API::V1::Base
    
  namespace :doc do
    formatter :json, ::API::DOCFormatter
    add_swagger_documentation api_version: 'v1', mount_path: "swagger_doc", tags: [
      { name: 'messages', description: '消息'},
      { name: 'devices', description: '设备'}
    ], info: {
      title: "API接口"
    }
    before do
      header "Cache-control", "maxage=0"
    end
  end
end