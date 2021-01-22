#!/bin/sh
set -e

/app/bin/consultant_board eval "ConsultantBoard.Release.Repo.migrate"
/app/bin/consultant_board start
