require 'erb'
require 'mail'
require './scrape'

def html_email(messages_hash)
    ERB.new(unindent(<<-EOF), nil, '-').result(binding)
    <%# Just a note-- I got this header block from https://github.com/papertrail/papertrail-services/blob/master/services/mail.rb %>
    <html>
    <head>
      <title>Papertrail</title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <style type="text/css">
        @media only screen and (max-device-width: 480px) {
          .body {
            padding: 0 10px 5px 10px !important;
          }
          .hdr {
            padding: 10px !important;
          }
        }
      </style>
    </head>
    <body>
        <% messages_hash.each do |source, events| -%>
            <dl>
            <dt> <%= source %> </dt>
            <% events.each do |program, issues| -%>
                <dd>
                <%= program %><br />
                <% issues.each do |level, messages| -%>
                    <span style='font-weight: bold;'> <%= level %> </span>
                    <ul>
                    <% messages.each do |message, count| -%>
                        <li> <%= message %> : <%= count %> </li>
                    <% end -%>
                    </ul>
                <% end -%>
                </dd>
            <% end -%>
        <% end -%>

    </body>
</html>
EOF

end

def unindent(string)
    indentation = string[/\A\s*/]
    string.strip.gsub(/^#{indentation}/, "") + "\n"
end
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

puts html_email post_params_to_event_hash events