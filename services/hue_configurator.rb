require 'hue'

class HueConfigurator
  attr_accessor :lights

  def initialize(config_lights)
    hue_client = Hue::Client.new

    # clean up old groups
    hue_client.groups.select do |g|
      g.name == "Lord of Light"
    end.map { |g| g.destroy! }

    # create new group
    hue_group = hue_client.group
    hue_group.name = "Lord of Light"
    hue_group.lights = hue_client.lights.select do |light|
      config_lights.map { |light| light['name'] }.include?(light.name)
    end
    hue_group.create!

    @lights = hue_group.lights
  end

  def party_time
    @lights.each do |light|
      light.hue = rand(Hue::Light::HUE_RANGE)
      light.brightness = rand(Hue::Light::BRIGHTNESS_RANGE)
    end
  end
end
