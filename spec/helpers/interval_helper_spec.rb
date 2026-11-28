require "rails_helper"

describe IntervalHelper do
  describe "#time_interval" do
    let(:placeholder) { IntervalHelper::PLACEHOLDER }

    it "replaces empty input with placeholder" do
      expect(helper.time_interval("")).to eq(placeholder)
      expect(helper.time_interval(nil)).to eq(placeholder)
    end

    # concerned with xss and sql injection
    it "replaces invalid input with placeholder" do
      expect(helper.time_interval("0h")).to eq(placeholder)
      expect(helper.time_interval("1'h")).to eq(placeholder)
      expect(helper.time_interval("1h'")).to eq(placeholder)
      expect(helper.time_interval("-1w")).to eq(placeholder)
      expect(helper.time_interval("2")).to eq(placeholder)
      expect(helper.time_interval("m")).to eq(placeholder)
    end

    it "[QP-SMRAILS-5-1] Resolves a 1w period to a 7-day look-back on the top stories page" do
      result = helper.time_interval("1w")
      expect(result[:dur]).to eq(7)
      expect(result[:intv]).to eq("Day")
    end

    it "[QP-SMRAILS-5-2] Resolves a 2w period to a 14-day look-back, not 12, on the top stories page" do
      result = helper.time_interval("2w")
      expect(result[:dur]).to eq(14)
      expect(result[:intv]).to eq("Day")
    end
  end
end
