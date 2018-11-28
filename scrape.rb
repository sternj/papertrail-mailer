def post_params_to_event_hash(events)
    # Note-- current format in emails is dictated by 
    # github.com/papertrail-services/lib/papertrail_services/helpers/logs_helpers.rb
    # The following is line the body of each row
    # s << " #{h(message[:source_name])} #{h(message[:program])}: #{h(message[:message])}"

    # From the email, it seems that message[:message] is as follows:
    # [LOG_LEVEL] service_name instance_name error_text

    # Initially from reading Papertrail's code, I thought the message was truncated in email.
    # This doesn't seem to be the case, so I will make the initial assumption that 
    # The remainder of the message is a non-unique error


    # Full disclosure-- I did find this methodology on the internet, I 
    # was originally going to do a ton of "unless" blocks. I 
    # happen to like the idea of setting the default key not found value to an empty hash, though!
    # Yes, I CAN explain what's happening under the hood
    return_hash = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }

    events.each do |event|
        split_event = event["message"].split /\s+/
        # level, service, instance, error = split_event[0..2] + [split_event[3..-1].join(' ')]
        level, rest_of_message = split_event.first, split_event[1..-1].join(' ')
        number_of_events = return_hash[event["source_name"]][event["program"]][level][rest_of_message]
        number_of_events = number_of_events.is_a?(Integer) ? number_of_events : 0
        # I put this on a second line because the alternative is (I think) a ternary expression,
        # which would require a pair of lookups rather than just the one. 
        # I suspect that Ruby may have a more elegant way, 
        # but two lines isn't too much
        return_hash[event["source_name"]][event["program"]][level][rest_of_message] = number_of_events + 1
    end
    return_hash
end

# puts post_params_to_event_hash events