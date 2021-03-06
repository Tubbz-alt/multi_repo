#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __dir__)

require 'bundler/setup'
require 'multi_repo'
require 'more_core_extensions/core_ext/array/tableize'
require 'travis'
require 'travis/pro/auto_login'

opts = MultiRepo::CLI.options(:except => :dry_run) do
  opt :ref, "The branch or release tag to check status for.", :type => :string, :required => true
end
opts[:repo_set] = opts[:ref].split("-").first unless opts[:repo] || opts[:repo_set]

travis_repos = MultiRepo::CLI.repos_for(opts).collect do |repo|
  next if repo.options.has_real_releases

  repo = Travis::Pro::Repository.find(repo.github_repo)
  begin
    last_build = repo.last_on_branch(opts[:ref])
  rescue Travis::Client::NotFound
    # Ignore repo which doesn't have Travis enabled for that branch
    next
  end
  {"Repo" => repo.name, "Status" => last_build.state, "Build ID" => last_build.number, "Date" => last_build.finished_at}
end.compact

travis_repos.sort_by! { |v| [ v["Status"], v["Date"] ] }
puts travis_repos.tableize(:columns => ["Repo", "Status", "Build ID", "Date"])
