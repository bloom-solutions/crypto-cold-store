require 'rails_helper'

RSpec.describe ApplicationJob do

  it { is_expected.to be_retryable(0) }

end
