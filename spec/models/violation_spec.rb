require "spec_helper"

describe Violation do
  it { should belong_to(:build) }

  describe "validations" do
    it { should validate_presence_of(:build) }
    it { should validate_presence_of(:filename) }
  end

  describe "#add_messages" do
    it "adds the messages" do
      existing_message = "broken"
      new_message = "it's broken again"
      violation = build(:violation, messages: [existing_message])

      messages = violation.add_messages([new_message])

      expect(messages).to match_array([existing_message, new_message])
    end
  end

  describe "#messages" do
    it "returns unique messages" do
      message = "broken"
      all_messages = [message, message]
      violation = build(:violation, messages: all_messages)

      messages = violation.messages

      expect(messages).to match_array([message])
    end
  end
end
