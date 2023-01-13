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

h3. Importing authorities

There is an initializer script that will load the candidate names authorities every time the server is restarted.  The initializer downloads the names authority into a temp file, and then reads the temp file to index the data in solr.  This takes a long time to run, so it is disabled in development mode.  If the script detects that the data has already been downloaded, it will skip the indexing.

If you want to force it to re-load the candidate names, you can remove the temp file that the data is downloaded to:
<pre> rm tmp/candidates.xml </pre>

There are similar initializer scripts for the offices, parties, and states authority files.

*Note:*  If you see office IDs appear in the facet list instead of the office names, that means that the office authorities aren't loaded.  This might happen frequently in development mode if you are editing files, because Rails might re-load the Office class without re-running the initializer scripts, which will clear out the in-memory cache.

The names will re-appear if you restart your Rails server.  Or, if you need to temporarily disable the class re-loading, you can set config.cache_classes in your config/environments/development.rb.

h1. Setting up Tufts Election search:
# solrize objects
  <pre>INDEX_LIST=pids.csv RAILS_ENV=production rake solrizer:fedora:solrize_objects</pre>

What should be in the pids.csv?

Tufts' production fedora environment contains other objects besides what should be displayed in the New Nation Votes site.  The pids.csv should contain a list of all the PIDs that you want to index in solr for this front end.  For a development environment, it's probably just a list of all the pids in your fedora.

