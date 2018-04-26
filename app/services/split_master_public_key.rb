class SplitMasterPublicKey

  extend LightService::Action
  expects :master_public_key
  promises :master_public_key

  executed do |c|
    c.master_public_key = c.master_public_key.split(",").map(&:strip)
  end

end
