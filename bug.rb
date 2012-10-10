#!/usr/bin/env ruby

require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install bundler` to install Bundler."
  exit e.status_code
end

begin
  Bundler.setup
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'dm-core'
require 'dm-validations'
require 'dm-migrations'
#require 'dm-types'
#require 'dm-constraints'
#require 'dm-aggregates'
require 'pp'
require 'rspec'

class Meeting
  include DataMapper::Resource
  property :id, Serial

  property :begin, Time, :required => true
  property :end,   Time, :required => true
end

DataMapper::Logger.new(STDERR,:debug) if ENV['DEBUG']
DataMapper.setup(:default, 'sqlite:bug.db')
DataMapper.finalize.auto_migrate!

# ****************************** BUGGY CODE ******************************
describe "Meeting class" do


  it "always returns values in server's localtime" do
    t = Time.now.utc

    t.utc?.should be_true

    a = Meeting.create(:begin => t, :end => t+5)

    b = Meeting.all(:begin => t, :end => t+5).first

    b.begin.utc?.should be_false

    a.begin.utc?.should be_true

  end

  it "stores the same data regardless of utc_offset value" do
    t = Time.now.utc

    t.utc?.should be_true
    a = Meeting.create(:begin => t, :end => t+5)

    t = t.getlocal("+09:00")
    t.utc?.should be_false
    b = Meeting.create(:begin => t, :end => t+6)

    a.saved?.should be_true
    b.saved?.should be_true

    appts = Meeting.all(:begin.gte => t.utc)
    appts.count.should == 2

    appts = Meeting.all(:begin => t.utc)
    appts.count.should == 2

    appts[0].begin.should == appts[1].begin

  end

end


# ****************************** BUGGY CODE ******************************
