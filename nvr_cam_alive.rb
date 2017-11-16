#!/usr/bin/env ruby

class NvrCamAlive
  def initialize(nvr_url, api_key)
    require 'rest-client'
    require 'json'
    @nvr_url = nvr_url
    @api_key = api_key
  end

  def cam_alive(cam_uid)
    client = RestClient::Request.execute(url: "#{@nvr_url}/api/2.0/camera?apiKey=#{@api_key}", method: :get, verify_ssl: false)
    nvr_data = JSON.parse(client)
    nvr_data['data'].each do |cam|
      if cam['uuid'] == cam_uid
        if cam['state'] == 'CONNECTED'
          return '1'
        else
          return '0'
        end
      end
    end
    return '0'
  end
end

nvr = NvrCamAlive.new('https://example.com:7443', 'your-api-key')
puts nvr.cam_alive(ARGV[0])
