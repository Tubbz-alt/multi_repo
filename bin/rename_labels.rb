#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __dir__)

require 'bundler/setup'
require 'multi_repo'
require 'pp'

opts = MultiRepo::CLI.options do
  opt :old, "The old label names.", :type => :strings, :required => true
  opt :new, "The new label names.", :type => :strings, :required => true
end

rename_hash = opts[:old].zip(opts[:new]).to_h
puts "Renaming: #{rename_hash.pretty_inspect}"
puts

MultiRepo.each_repo(opts) do |repo|
  MultiRepo::Operations::RenameLabels.new(repo.github_repo, rename_hash, opts).run
end
