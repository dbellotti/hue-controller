# app.rb
require 'sinatra/base'
require 'sinatra/config_file'
require 'rack/flash'
require 'hue'
require 'json'
require 'slim'
require 'pry'


class HueStation < Sinatra::Base
  register Sinatra::ConfigFile
  use Rack::Flash

  configure do
    config_file './config/westeros.yml'

    enable :logging
    enable :sessions

    hue_client = Hue::Client.new
    group = hue_client.group
    # clean up old groups
    hue_client.groups.select { |g| g.name == "Lord of Light" }.map { |g| g.destroy! }
    group.name = "Lord of Light"
    group.lights = hue_client.lights.first(3)
    group.create!

    set :hue_client, hue_client
    set :hue_group, group
    set :asset_version, Time.now.to_i
    set :public_folder, File.join(File.dirname(__FILE__), './public')
  end

  before do
    @hue_client = settings.hue_client
    @hue_group = settings.hue_group
    @asset_version = settings.asset_version
    @lighting_scenes = settings.scenes
  end

  get '/' do
    slim :index
  end

  post '/select_scene' do
    settings = nil
    
    # select the stored settings
    @lighting_scenes.each do |item|
      if item[:name] == params['scene']
        settings = item[:settings]
      end
    end

    puts settings.inspect

    # set light from corresponding stored setting
    @hue_group.lights.each do |light|
      setting = nil

      settings.select do |item|
        if item[:name] == light.name
          setting = item
        end
      end

      puts "setting scene: #{light.name} with: #{setting}"
      light.set_state(setting, setting[:transition_time].to_int)
    end

    flash[:notice] = "Triggered #{params['scene']}"
    redirect '/'
  end

  post '/create_scene' do
    @lighting_scenes.append({
      name: params['name'],
      settings: params['lights'].each do |light|
        {
          name: light['name'],
          hue: light['hue'],
          saturation: light['saturation'],
          brightness: light['brightness'],
          transition_time: light['transition_time']
        }
      end
    })

    flash[:notice] = "Added new scene: #{params['name']}"
    redirect '/'
  end

  get '/party_time' do
    @hue_group.lights.each do |light|
      light.hue = rand(Hue::Light::HUE_RANGE)
      light.brightness = rand(Hue::Light::BRIGHTNESS_RANGE)
    end

    redirect '/'
  end
end
