require "spec_helper"

describe "Raise errors" do
  it "should raise error" do
    expect {
      raise Digitalocean::Error, {message: "test", code: 500}
    }.to raise_error(Digitalocean::Error, "(500) test")
  end

  it "should raise client error" do
    expect {
      response = EmmyHttp::Response.new(
        status: 403,
        headers: {"Content-Type" => "application/json"},
        body: '{"id":"forbidden","message":"You do not have access for the attempted action."}'
      )
      raise Digitalocean::ClientError, response
    }.to raise_error Digitalocean::Error, "(403) You do not have access for the attempted action."
  end
end
