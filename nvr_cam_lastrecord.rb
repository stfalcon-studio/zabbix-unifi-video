#!/usr/bin/env ruby

class NvrCamLastRecord
  def initialize(nvr_url, api_key)
    require 'rest-client'
    require 'json'
    @nvr_url = nvr_url
    @api_key = api_key
  end

  def cam_last_record(cam_name)
    client = RestClient::Request.execute(url: "#{@nvr_url}/api/2.0/camera?apiKey=#{@api_key}", method: :get, verify_ssl: false)
    nvr_data = JSON.parse(client)
    nvr_data['data'].each do |cam|
      if cam['name'] == cam_name
        return ((Time.now - Time.strptime(cam['lastRecordingStartTime'].to_s, '%Q')) / 60 ).to_i
      end
    end
    return '0'
  end
end

nvr = NvrCamLastRecord.new('https://example.com:7443', 'your-api-key')
puts nvr.cam_last_record(ARGV[0])
