require 'erb'
require 'mail'

def html_email(messages_hash)
    ERB.new(File.read('./email_template.html.erb'), nil, '-').result(binding)
end

# a helper taken from github.com/appoptics/appoptics-services
def unindent(string)
    indentation = string[/\A\s*/]
    string.strip.gsub(/^#{indentation}/, "") + "\n"
end

# I roughly tried to structure the messages in the way I saw the email

# note that THIS IS AN EXAMPLE
# The information that is in the image is in webhook-test.rb
events = [
    { "source_name" => "mgmt-shovel",
        "program" => "app/worker.1",
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
]

# puts html_email post_params_to_event_hash events