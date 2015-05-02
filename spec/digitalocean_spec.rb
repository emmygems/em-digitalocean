require 'spec_helper'

unless ENV['TOKEN']
  puts "Set DigitalOcean API Token before. \nexport TOKEN=77e027c7447f468068a7d4fea41e7149a75a94088082c66fcf555de3977f69d3"
end

describe Digitalocean do
  using Fibre::Synchrony

  droplet_id = nil
  domain_name = nil
  domain_record_id = nil
  image_id = nil

  let(:api) do
    Digitalocean::API.new(token: ENV['TOKEN'])
  end

  around do |example|
    EmmyMachine.run_block &example
  end

  it 'has a version number' do
    expect(Digitalocean::VERSION).not_to be nil
  end

  it 'has api token' do
    expect(api.token).to_not be_nil
  end

  it 'does droplets list internal request' do
    req = Digitalocean::Droplets.all
    req.headers['Authorization'] = "Bearer #{ENV['TOKEN']}"
    res = req.sync

    expect(res.status).to be(200)
    expect(res.json["droplets"]).to be_a(Array)
  end

  it 'does droplets list full request' do
    res = api.droplets.all.sync

    expect(res[:droplets]).to be_a(Array)
    # set droplet_id
    droplet_id = res[:droplets].first[:id]
    expect(droplet_id).to be_a Fixnum
  end

  it 'does droplet show request' do
    skip unless droplet_id
    res = api.droplets.show(droplet_id).sync
    expect(res[:droplet][:id]).to be(droplet_id)
  end

  it "show account info" do
    res = api.account.info.sync
    expect(res[:account][:email_verified]).to be true
  end

  it "show account keys" do
    res = api.account_keys.all.sync
    expect(res[:ssh_keys].size).to be > 0
  end

  it "show actions" do
    res = api.actions.all.sync
    expect(res[:actions].size).to be > 0
  end

  it "show all domains" do
    res = api.domains.all.sync
    domain_name = res[:domains].first[:name]
    expect(domain_name).to_not be nil
    expect(res[:domains].size).to be > 0
  end

  it "show domain records" do
    skip unless domain_name
    res = api.domain_records.all(domain_name).sync
    domain_record_id = res[:domain_records].first[:id]
    expect(res[:domain_records].size).to be > 0
  end

  it "show all images" do
    res = api.images.all.sync
    image_id = res[:images].first[:id]
    expect(res[:images].size).to be > 0
  end

  it "show image actions" do
    skip unless image_id
    res = api.images.actions(image_id).sync
    expect(res[:actions]).to be_empty
  end

  it "show private images" do
    res = api.images.private_images.sync
    expect(res[:images].size).to be > 0
  end

  it "show all regions" do
    res = api.regions.all.sync
    expect(res[:regions]).to_not be_empty
  end

  it "show all sizes" do
    res = api.sizes.all.sync
    expect(res[:sizes]).to_not be_empty
  end

  it "raise client error" do
    expect {
      # get missing droplet
      api.droplets.show(0).sync
    }.to raise_error(Digitalocean::ClientError, "(404) The resource you were accessing could not be found.")
  end

  it "multiple requests" do
    regions, sizes = [api.regions.all, api.sizes.all].sync

    expect(regions[:regions]).to_not be_empty
    expect(sizes[:sizes]).to_not be_empty
  end

  #<<<
end
