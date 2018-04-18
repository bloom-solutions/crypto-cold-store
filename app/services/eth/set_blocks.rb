module Eth
  class SetBlocks

    extend LightService::Action
    promises :blocks

    executed do |c|
      c.blocks = Block.eth
    end

  end
end
