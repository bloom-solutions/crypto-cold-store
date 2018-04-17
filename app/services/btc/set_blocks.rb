module Btc
  class SetBlocks

    extend LightService::Action
    promises :blocks

    executed do |c|
      c.blocks = Block.btc
    end

  end
end
