class ApplicationCircuit

  def self.run_on_context(ctx, &block)
    response = self.().run(&block)
    if response.nil?
      ctx.fail_and_return!("#{self}: call failed or circuit open")
    end
    response
  end

end
