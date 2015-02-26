require "spec_helper"

module LanguageWorker
  describe Scss do
    describe "#run" do
      it "sends payload to Scss worker" do
        build_worker = create(:build_worker)
        commit_file = commit_file(status: "added")
        repo_config = double("RepoConfig")
        pull_request = double("PullRequest")
        scss_worker_url = ENV["WORKER_URL"]
        connection = double("Connection", post: true)
        allow(Faraday).to receive(:new).with(url: scss_worker_url).and_return(connection)
        worker = Scss.new(build_worker, commit_file, repo_config, pull_request)

        worker.run

        expect(Faraday).to have_received(:new).with(url: scss_worker_url)
        expect(connection).to have_received(:post).with(
          "/",
          {
            payload:
            {
              build_worker_id: build_worker.id,
              build_id: build_worker.build_id,
              config: nil,
              file: {
                name: "test.rb",
                content: "some content",
                patch: "",
              },
              hound_url: ENV["BUILD_WORKERS_URL"]
            }
          }
        )
      end
    end

    def commit_file(options = {})
      file = double("File", options.reverse_merge(patch: "", filename: "test.rb"))
      commit = double(
        :commit,
        repo_name: "test/test",
        sha: "abc",
        file_content: "some content"
      )
      CommitFile.new(file, commit)
    end
  end
end
