require 'hue'

class HueConfigurator
  attr_accessor :hue_client
  attr_accessor :hue_group

  def initialize(config)
    @hue_client = Hue::Client.new

    # clean up old groups
    @hue_client.groups.select do |g|
      g.name == "Lord of Light"
    end.map { |g| g.destroy! }

    # create new group
    @hue_group = @hue_client.group
    @hue_group.name = "Lord of Light"
    @hue_group.lights = @hue_client.lights.select do |light|
      config.lights.map { |light| light['name'] }.include?(light.name)
    end
    @hue_group.create!
  end

  def party_time
    @hue_group.lights.each do |light|
      light.hue = rand(Hue::Light::HUE_RANGE)
      light.brightness = rand(Hue::Light::BRIGHTNESS_RANGE)
    end
  end
end
