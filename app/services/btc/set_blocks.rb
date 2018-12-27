module Btc
  class SetBlocks

    MAX_CONFS = 10
    extend LightService::Action
    promises :blocks

    executed do |c|
      c.blocks = Block.btc.with_confirmations_less_than(MAX_CONFS)
    end

  end
end
