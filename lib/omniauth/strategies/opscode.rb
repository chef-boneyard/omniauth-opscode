require "omniauth/opscode/version"
require 'faraday'
require 'faraday-cookie_jar'

module OmniAuth
  module Strategies
    class Opscode
      include OmniAuth::Strategy

      args [:chef_webui_url]
      option :fields, [:username,:password]
      option :uid_field, :username
      option :chef_webui_url, nil

      def request_phase
        form = OmniAuth::Form.new(:title => "Login to Deliverance", :url => callback_path)
        form.text_field 'Username', 'username'
        form.password_field 'Password', 'password'
        form.button "Login"
        form.to_response
      end

      def callback_phase
        return fail!(:invalid_credentials) unless identity
        super
      end

      def uid
        @identity[:username]
      end

      def info
        @identity
      end

      def identity
        @identity ||= nil

        return @identity if @identity

        conn = Faraday.new(:url => options.chef_webui_url, :ssl => {:verify => false}) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
          faraday.use :cookie_jar
        end

        conn.get("/login")
        response = conn.post('/login', {:username=>request['username'], :password=>request['password']})
        if response.status == 302 && response.headers['location'] == options.chef_webui_url
          @identity = {
            :username => request['username']
          }
        else
          nil
        end
      end
    end
  end
end
