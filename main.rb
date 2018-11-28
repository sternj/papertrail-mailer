require 'sinatra/base'
require_relative 'email'
require 'yajl'
require_relative 'scrape'

class PapertrailMailer < Sinatra::Base
    get '/' do
        puts params
        "ok"
    end

    post '/give-events' do 
        payload = Yajl::Parser.parse(params["payload"])["events"]
        email = html_email(post_params_to_event_hash(payload))
        Mail.deliver do
            from     'sternj@cs.brandeis.edu'
            to       'sternj@cs.brandeis.edu'
            subject  'papertrail logs'
            html_part do
                content_type 'text/html; charset=UTF-8'
                body email
            end
        end
        'ok'
    end
end

PapertrailMailer.run!