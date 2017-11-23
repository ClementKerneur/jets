require "spec_helper"

describe Jets::Process do

  describe "jets process" do
    it "controller [event] [context] [handler]" do
      args = %Q|'{"we":"love","using":"Lambda"}' '{"test":"1"}' handlers/controllers/posts_controller.new|
      out = execute("bin/jets process controller #{args}")
      # pp out # uncomment to debug
      data = JSON.parse(out)
      expect(data["statusCode"]).to eq 200
      expect(data["body"]).to eq('{"action":"new"}') # body is JSON encoded String
    end

    it "job [event] [context] [handler]" do
      args = %Q|'{"we":"love","using":"Lambda"}' '{"test":"1"}' handlers/jobs/hard_job.dig|
      out = execute("bin/jets process job #{args}")
      # pp out # uncomment to debug
      data = JSON.parse(out)
      expect(data).to eq("done"=>"digging") # data returned is Hash
    end
  end
end
