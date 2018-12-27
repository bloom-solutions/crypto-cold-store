module Eth
  class SetBlocks

    MAX_CONFS = 150
    extend LightService::Action
    promises :blocks

    executed do |c|
      c.blocks = Block.eth.with_confirmations_less_than(MAX_CONFS)
    end

  end
end
