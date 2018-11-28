# Using this as a testbed-- 
# papertrail webhooks sample app
# Source: https://gist.github.com/troy/1111839


require 'yajl'
require 'faraday'

class PapertrailWebhookRequest
  def self.connection
    Faraday::Connection.new
  end

  def self.run
    results = {
      "payload" => {
        "saved_search" => {
          :id   => 42,
          :name => "Test search",
          :html_search_url => "https://papertrailapp.com/searches/42",
          :html_edit_url => "https://papertrailapp.com/searches/42/edit"
        },

        # I modified this part to look a little like the emails 
        # I tried to structure this relatively like what I saw in the image you sent me
        "events" => [
            { "source_name" => "mgmt-shovel",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: silver-asdf que Net::Something" },
           { "source_name" => "mgmt-shovel",
                "program" => "app/worker.2",
                "message" => "[ERROR] CloudAMQP: silver-asdf que Net::Something" },
            { "source_name" => "mgmt-shovel",
            "program" => "app/worker.1",
            "message" => "[WARN] CloudAMQP: silver-goose queues Net:: Something" },
            { "source_name" => "mgmt-shovel",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: silver-asdf que Net::Something" },
            { "source_name" => "mgmt-shovel",
            "program" => "app/worker.1",
            "message" => "[WARN] CloudAMQP: silver-goose queues Net:: Something" },
            { "source_name" => "mgmt-shovel",
            "program" => "app/worker.1",
            "message" => "[WARN] CloudAMQP: silver-goose queues Net:: Something" },
            { "source_name" => "mgmt-shovel",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: silver-asdf que Net::Something" },
            { "source_name" => "mgmt-shovel",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: silver-asdf que Net::Something" },
            { "source_name" => "mgmt-shovel",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: gold-asdf queueue Net::Something" },
        { "source_name" => "mgmt-spade",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: gold-asdf queueue Net::Something" },
            { "source_name" => "mgmt-spade",
                "program" => "app/worker.1",
                "message" => "[ERROR] CloudAMQP: gold-asdf queueue Net::Something" },
        ],
        "max_id" => 3241602919300000,
        "min_id" => 3241602919310000
      }
    }

    r = connection.post do |req|
      req.url 'http://localhost:4567/give-events'
      req.body = {
        :payload  => Yajl::Encoder.encode(results['payload'])
      }
    end
  end
end

r = PapertrailWebhookRequest.run

puts "Response:\n#{r.body}"