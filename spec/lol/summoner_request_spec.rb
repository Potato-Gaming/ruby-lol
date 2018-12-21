require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  subject { SummonerRequest.new "api_key", "euw" }

  it "inherits from Request" do
    expect(SummonerRequest).to be < Request
  end

  describe "#find" do
    it "returns a DynamicModel" do
      stub_request subject, "summoner", "summoners/ABHN9fr3fI3SPCvaULnhnSKUF4gwJz5CgJiwz1oGl1u-nYU"
      expect(subject.find "ABHN9fr3fI3SPCvaULnhnSKUF4gwJz5CgJiwz1oGl1u-nYU").to be_a DynamicModel
    end
  end

  describe "#find_by_puuid" do
    it "returns a DynamicModel" do
      stub_request(
        subject,
        "summoner-by-puuid",
        "summoners/by-puuid/48wR9dQbrgXhMZrR8Hoeg4m-fOE5TU7vl3MDdkuTut4-gpiLJ5626F4W6IXvZPZ86fLTs5ZOSwS5DQ"
      )
      expect(
        subject.find_by_puuid(
          "48wR9dQbrgXhMZrR8Hoeg4m-fOE5TU7vl3MDdkuTut4-gpiLJ5626F4W6IXvZPZ86fLTs5ZOSwS5DQ"
        )
      ).to be_a DynamicModel
    end
  end

  describe "#find_by_name" do
    it "returns a DynamicModel" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/foo'
      expect(subject.find_by_name 'foo').to be_a DynamicModel
    end

    it "escapes the given name" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/f%C3%B2%C3%A5'
      subject.find_by_name 'fòå'
    end

    it "downcases the given name" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/arg'
      subject.find_by_name 'ARG'
    end

    it 'strips spaces from names' do
      stub_request(subject, 'summoner-by-name', 'summoners/by-name/foo')
      subject.find_by_name('fo o')
    end
  end
end
