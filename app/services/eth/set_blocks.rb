module Eth
  class SetBlocks

    extend LightService::Action
    promises :blocks

    executed do |c|
      c.blocks = PgCircuit.run_on_context(c) do
        Block.eth
      end
    end

  end
end
