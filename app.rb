# app.rb
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/content_for'
require 'hue'
require 'json'
require 'slim'
require 'rack/session/redis'
require 'rack/flash'

require './services/hue_configurator'

class HueStation < Sinatra::Base
  register Sinatra::ConfigFile
  helpers Sinatra::ContentFor
  use Rack::Session::Redis, :redis_server => ENV['REDIS_URL']
  use Rack::Flash

  configure do
    config_file './config/westeros.yml'

    enable :logging
#    enable :sessions

    set :asset_version, Time.now.to_i
    set :public_folder, File.join(File.dirname(__FILE__), './public')
  end

  before do
    @asset_version = settings.asset_version
    @lighting_scenes = settings.scenes
  end

  get '/' do
    slim :index
  end

  get '/elm' do
    @user = "XKH4OkdMgXubydMRoiXyqEwwSmiy3RqBx74Hs-8L"
    @bridge = "10.0.1.2"
    slim :elm
  end

  post '/register_bridge' do
    session[:lights] = HueConfigurator.new(settings.lights).lights

    flash[:notice] = "Successfully registered with your Hue base station."
    redirect '/'
  end

  post '/select_scene' do
    settings = nil
    
    # select the stored settings
    @lighting_scenes.each do |item|
      if item[:name] == params['scene']
        settings = item[:settings]
      end
    end

    # set light from corresponding stored setting
    session[:lights].each do |light|
      setting = nil

      settings.select do |item|
        if item[:name] == light.name
          setting = item
        end
      end

      puts "setting scene: #{light.name} with: #{setting}"
      light.set_state(setting, setting[:transitionTime].to_int)
    end

    if not request.xhr?
      flash[:notice] = "Triggered #{params['scene']}"
      redirect '/'
    end
  end

  post '/create_scene' do
    @lighting_scenes.append({
      name: params['name'],
      settings: params['lights'].each do |light|
        {
          name: light['name'],
          hue: light['hue'],
          saturation: light['sat'],
          brightness: light['bri'],
          transition_time: light['transitiontime']
        }
      end
    })

    flash[:notice] = "Added new scene: #{params['name']}"
    redirect '/'
  end

  get '/party_time' do
    session[:lights].each do |light|
      light.hue = rand(Hue::Light::HUE_RANGE)
      light.brightness = rand(Hue::Light::BRIGHTNESS_RANGE)
    end

    redirect '/'
  end
end
