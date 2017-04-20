module ManageIQ
  module Release
    class UpdateRepoSettings
      attr_reader :repo, :branch, :dry_run

      def initialize(repo, branch: nil, dry_run: false)
        @repo    = repo
        @branch  = branch
        @dry_run = dry_run
      end

      def run
        edit_repository
        protect_branch if branch
      end

      private

      def edit_repository
        puts "Editing #{repo}"

        settings = {
          :has_wiki           => false,
          :has_projects       => false,

          :accept             => "application/vnd.github.polaris-preview+json", # See https://developer.github.com/v3/repos/#pull-request-merge-configuration-settings-1)
          :allow_merge_commit => true,
          :allow_rebase_merge => false,
          :allow_squash_merge => false,
        }

        if dry_run
          puts "** dry-run: github.edit_repository(#{repo.inspect}, #{settings.inspect[1..-2]})"
        else
          github.edit_repository(repo, settings)
        end
      end

      def protect_branch
        puts "Protecting #{branch}"

        if dry_run
          puts "** dry-run: github.protect_branch(#{repo.inspect}, #{branch.inspect})"
        else
          github.protect_branch(repo, branch)
        end
      end

      def github
        ManageIQ::Release.github
      end
    end
  end
end
