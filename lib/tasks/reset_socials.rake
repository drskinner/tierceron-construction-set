# encoding: utf-8
require 'fileutils'

namespace :db do
  desc 'Reset socials table for testing'
  task :reset_socials => :environment do |t, args|
    ActiveRecord::Base.connection.execute('TRUNCATE TABLE socials RESTART IDENTITY CASCADE;')
    puts('Truncated `socials` table and reset primary key.')
  end
end
