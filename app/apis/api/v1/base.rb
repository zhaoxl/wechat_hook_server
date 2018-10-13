module API
  module V1

    class Base < Grape::API

      version 'v1', :path

      helpers ::API::ApiHelpers

      formatter :json, ::API::JSONFormatter
      error_formatter :json, ::API::ErrorFormatter

      content_type :json, "application/json; charset=utf8"
      content_type :xml, "text/xml"
      content_type :txt, "text/plain"

      default_format :json
      rescue_from :all, backtrace: true do |e|
        puts e.backtrace.join("\n\t")
        {code: 503, tips: "服务器不给力，请重试!", error: e.message, location: e.backtrace.join("\n")}
      end

      mount MessagesApi
      mount DevicesApi
      
    end
  end
end