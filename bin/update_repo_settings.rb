#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __dir__)

require 'bundler/setup'
require 'manageiq/release'
require 'optimist'

opts = Optimist.options do
  MultiRepo.common_options(self)
end

MultiRepo.each_repo(opts) do |repo|
  MultiRepo::Operations::UpdateRepoSettings.new(repo.github_repo, opts).run
end
