#!/usr/bin/env ruby

class NvrCamDiscovery
  def initialize(nvr_url, api_key)
    require 'rest-client'
    require 'json'
    @nvr_url = nvr_url
    @api_key = api_key
  end

  def ipcams
    client = RestClient.get("#{@nvr_url}/api/2.0/camera?apiKey=#{@api_key}")
    nvr_data = JSON.parse(client)
    cam_names = { 'data' => [] }
    nvr_data['data'].each { |cam| cam_names['data'] << { "{#CAMNAME}" => cam['name'] } }
    cam_names.to_json
  end

end

nvr = NvrCamDiscovery.new('https://example.com:7443', 'your-api-key')
puts nvr.ipcams
