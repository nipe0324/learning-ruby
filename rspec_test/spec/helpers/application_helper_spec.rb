require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, :type => :helper do
  describe "active_if_current" do
    subject { helper.active_if_current("/any_path") }

    context "現在のページが引数のパスと等しい場合" do
      it do
        allow(helper).to receive(:current_page?).and_return(true)
        expect(subject).to eq "active"
      end
    end

    context "現在のページが引数のパスと等しくない場合" do
      it do
        allow(helper).to receive(:current_page?).and_return(false)
        expect(subject).to be_nil
      end
    end
  end
end
