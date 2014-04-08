EBDH
====

E-Business Database on Hadoop (demo)

====

E-Business demo website

Create rails project:
* # http://railsapps.github.io/rails-bootstrap/
* # database user and pw: ebdh
* CREATE USER ebdh IDENTIFIED BY 'ebdh'
* GRANT ALL PRIVILEGES ON *.* TO 'ebdh'@'%';
* rails generate scaffold Books title:string author:string publisher:string publish_date:date price:float amazon_link:string

How to install rails?
* # http://rvm.io/
* # http://ruby-china.org/wiki/rvm-guide
* \curl -sSL https://get.rvm.io | bash -s stable --rails
* cd EBusinessDemo
* bundle install
* rails s
