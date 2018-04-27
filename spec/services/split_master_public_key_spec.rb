require 'rails_helper'

RSpec.describe SplitMasterPublicKey do

  let(:resulting_ctx) { described_class.execute(master_public_key: mpk) }

  context "given a single mpk" do
    let(:mpk) { "mpk1" }
    subject { resulting_ctx.master_public_key }
    it { is_expected.to match_array(%w(mpk1)) }
  end

  context "given multiple single mpks" do
    let(:mpk) { "mpk1 , mpk2,mpk3,  mpk4 " }
    subject { resulting_ctx.master_public_key }
    it { is_expected.to match_array(%w(mpk1 mpk2 mpk3 mpk4)) }
  end

end
