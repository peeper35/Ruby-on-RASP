# Ruby on RASP

This is a simple project that I created for fun and learning, it is a [RASP](https://en.wikipedia.org/wiki/Runtime_application_self-protection) implementation that I've created from scratch. Basically I wanted to understand how the RASP thing works and how it can be implemented in any project, here it is implemented in a dummy Web Application that is using RASP, and usually RASP is implemented in Web Apps as an alternative for WAF, because WAF's are dumb sometimes.

I was there at [nullcon Conference](https://nullcon.net/website/about-nullcon.php) in 2017, and there was this session named **Injecting Security Into Web Apps With Runtime Patching And Context Learning** by [Ajin Abraham](https://twitter.com/ajinabraham) there I came to know anout RASP. 

Later on, one friend of mine [Kaushal Parikh](https://github.com/kp625544) created a RASP implementation using Python, that motivated me to also try and research about RASP. So I created the same prototype of RASP implementation using ruby.


## Installation 

1. Install `ruby 2.4.5`, preferably use [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) for installing ruby. 
2. `gem install bundler`
3. `bundle install`
4. `ruby db_setup.rb`

If any error shows up while `bundle install` then install these packages: `sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libsqlite3-dev`


## Usage

1. `rackup va.ru` <- This will launch the vulnerable application on `http://localhost:9292/`, this app is completely vulnerable to all the web app vulnerability classes, i.e SQLi, LFI, Command Injection etc.
2. `rackup pa.ru` <-  This will launch the patched application here `http://localhost:9292/`, this one has the patch for all the vulnerabilities that are present in the vulnerable app.

## Inportant Files

* `controller.rb` This file is used by both patched app for user authentication and vulnerable app for user authentication as well as reading file and performing ping function.

* `lexer.rb` This file has stored all the lex tokens, and using these lex rules the user input will be checked. This file is used by patched app.

* `pa.ru` Patched app rackup config.

* `va.ru` Vulnerable app rackup config.

* `patch.rb` Contains patches for the vulnerabilities. This file requires `lexer.rb` and `controller.rb`.

* `db_setup.rb` This file contains setup for database which will create a databse of lex rules that will be checked with the lexed user input (which will be generated using `lexer.rb`). This will also setup database for username and password.

* `patched_app.rb` Sinatra patched app, which will require `patch.rb`

* `vulnerable_app.rb` Sinatra vulnerable app, which will require `controller.rb`


**In the patched app, I've mainly focused on the lexical analysis part, which is enforced on the patches for RCE and SQLi. So you might be able to bypass patches for LFI, XSS or File Upload bugs.**

I might also need to improve the Lex Rules for preventing SQLi and RCE.

This RASP implementation is currently only working in Protection mode, it is not currently doing any type of Runtime Patching or Context Learning. I will try to implement these two components in the app.


## References 

1. Great talk by Ajin Abraham, check out his [Github](https://github.com/ajinabraham) and [Twitter](https://twitter.com/ajinabraham). You should check his [blogs](https://ajinabraham.com/blog/) if you're into security. References to the talk: [Video](https://www.youtube.com/watch?v=WN_qof7X_pk), [Paper](https://www.slideshare.net/ajin25/injecting-security-into-web-apps-at-runtime-whitepaper), [Slide](https://www.slideshare.net/ajin25/injecting-security-into-vulnerable-web-apps-at-runtime)


**I would like to Thanks Kaushal for the idea and his help, you should definately follow him on [Twitter](https://twitter.com/kp625544) and check his projects of [Github](https://github.com/kp625544). Here is the RASP implementation that Kaushal made in python [runtime_secure](https://github.com/kp625544/runtime_secure).**
