#!/bin/sh

set -euo pipefail

bundle exec rails db:migrate
