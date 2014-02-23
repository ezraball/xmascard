# Christmas Postcards project

## Business
### research
* what are folks doing on etsy and ebay?

## Tech

### Todo

#### production
* load folder & push to remote

#### code
* tag based on original filename
* write tests!

#### design
* make tag labels and logged in info sans serif

### Done
* ~~re-do amazon bucket structure~~ 
* create fingerprint, a unique id based on filename and filesize that is shared between instances
* implement login
* push to remote feature
* a way to remove remotecards
* have original sized photo


### Development log
#### 22 Feb 2013
* Wanted to experiment with hosting @ Heroko. Since it is postgres-based, that led me to…
* Install postgres which was a lotta pain
* Created xmascard rails app
* Deployed xmascard rails app to Heroku, and it worked!
* created my first migration and send it to heroku
* fixed a bunch of crap with the asset pipeline and bootstrap in heroku
* **Next up: ** do some design
* **Next up: ** add paperclip attachments

#### 23 Feb 2013
* added paperclip attachments
* wrote load script from local directory
* verified that paperclip worked ok with heroku

#### 19 Feb 2014 
* resumed project
* have original sized photo
