#!/bin/bash
set -xe
# Install gems
bundle install
# Install overcommit
overcommit --install
export GIT_TEMPLATE_DIR="$(overcommit --template-dir)"
# Setup solargraph
solargraph download-core # download core documentation
solargraph bundle
# Setup database
bin/rails db:drop:all --trace
bin/rails db:create:all --trace
bin/rails db:prepare --trace
bin/rails db:seed --trace
# Clear logs and temp files
bin/rails log:clear tmp:clear
# Install yarn
yarn install --check-files
exit