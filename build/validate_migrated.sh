#!/bin/sh

if [ "${RAILS_ENV}" = 'production' ] || [ "${RAILS_ENV}" = 'staging' ]; then
  echo "Cannot auto-migrate ${RAILS_ENV} database, exiting"
  exit 1
fi

echo "Checking ${RAILS_ENV} database migration status and auto-migrating if necessary."
# If the migration status can't be read or is not fully migrated
# then update the database with latest migrations
if bundle exec rails db:migrate:status &> /dev/null; then
  bundle exec rails db:migrate
fi
echo "Done checking ${RAILS_ENV} database migration status"