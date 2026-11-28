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

    it "[QP-SMRAILS-7-1] Two-week period resolves to a 14-day interval" do
      interval = helper.time_interval("2w")
      expect(interval[:dur]).to eq(14)
      expect(interval[:intv]).to eq("Day")
    end

    it "[QP-SMRAILS-7-2] One-week period resolves to a 7-day interval" do
      interval = helper.time_interval("1w")
      expect(interval[:dur]).to eq(7)
      expect(interval[:intv]).to eq("Day")
    end
  end
end
