#!/usr/bin/env rake
# frozen_string_literal: true
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

TuftsElection::Application.load_tasks

require 'solr_wrapper/rake_task'

require 'solr_wrapper/rake_task' unless Rails.env.production?
