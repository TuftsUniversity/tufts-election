# Setting up Tufts Election development environment:

This is a short guide to setting up New Nation Votes locally on your development machine.

##  Set up Mira
NNV depends on [Mira](https://github.com/TuftsUniversity/mira_on_hyrax) already existing on your computer because of shared assets.
Go to https://github.com/TuftsUniversity/mira_on_hyrax and follow the steps to set up Mira.

## Get Code:
Clone the code locally. Decide what folder you want the code to be in and run this at that level.
```
git clone https://github.com/TuftsUniversity/tdl_on_hyrax.git
```

## Run preinit script
`./preinit_new_environment.sh`

## Build the Docker Container
```
docker-compose build
```

## Bring up the Docker Container
```
docker-compose up server
```

# Check it out
Go to `http://localhost:4050` to see that NNV is working locally.

# Importing Fixtures
NNV ships with some fixtures that can be used for dev and test

## These can be imported running the following commands

```
docker exec -it tufts-election-server-1 /bin/bash
root@52c99bb737c4:/data# rake tufts:index_fixtures
root@52c99bb737c4:/data# script/import_candidates
```



# Running the specs

## Bring up the Docker Container
```
docker-compose up test
```

## import fixtures and run tests
```
root@52c99bb737c4:/data# rake tufts:index_fixtures
root@52c99bb737c4:/data# rspec
```

## Importing Office, Party, State authorities

There is an initializer script that will load the office, state and party authorities every time the server is restarted.  The initializer expects to find the authority files in the `tmp` directory under the rails root when the server starts. If you ran the pre-init script in your development enviroment these files have been put in place by that.

If you want to force it to re-load the party and office names, you can remove the temp file that the data is downloaded to:

```
    rm tmp/offices.xml
    rm tmp/party-authority.xml
    rm tmp/state-authority.xml
```

## Importing Candidate authorities

Candidate authorties are imported via a shell script, the script is located at:
    script/import_candidates.

Run that script if you need the candidate authorities.  The script expects to find the candidates authority file in the `tmp` directory under the rails root. If you ran the pre-init script in your development enviroment this file has been put in place by that script.


## Setting up Tufts Election search in production and stage:
### solrize objects
  <pre>INDEX_LIST=pids.csv RAILS_ENV=production rake solrizer:fedora:solrize_objects</pre>

What should be in the pids.csv?

Tufts' production fedora environment contains other objects besides what should be displayed in the New Nation Votes site.  The pids.csv should contain a list of all the PIDs that you want to index in solr for this front end.

## Adding objects in dockerized dev environment
Objects can be added to MIRA using the `VotingRecord` content model the displays_in set to: `elections`
