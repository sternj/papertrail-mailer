require 'mail'

# This is just me trying to make the gem work. 
# Left it in here to show my process
mail = Mail.new do
    from     'sternj@cs.brandeis.edu'
    to       'sternj@cs.brandeis.edu'
    subject  'Here is the image you wanted'
    body     'aaaaaaaaa'
  end
  
#   mail.delivery_method :postfix
  
mail.deliver