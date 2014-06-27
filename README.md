## Take Home Challenge

  You can view this working app on heroku http://take-home-challenge.herokuapp.com

## Setup
  To get started clone this repo and fun the following commands:

    gem install foreman
    bundle install
    rake db:setup (you will have to change username,password in database.yml)
    rake db:seed
    foreman start

## Testing
  I added rspec tests for the models and did manual testing with attached csv files spreadsheet.csv and the example_csv.csv provided.


##Behaviors to note

	If spreadsheet is uploaded and no id's match sellable items then no report is created.  


##Scaling

	Depending on the sizes of the spreadsheets uploaded and amount of users that were going to use this app concurrently, I would probably use resque to process spreadsheet and then generate and upload pdf to s3.  Reports would then contain links to s3 reports.

