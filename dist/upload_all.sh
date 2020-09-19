#!/bin/sh

#
# This script uploads the binaries create by build_all.sh
# to itchio, using butler.
#
# It assumes this directory hierarchy:
# base_dir/
#     dist/
#     dist/$platform/
#
# dist/ is where this script must be located
# dist/$platform/ is the directory of each build contents for platform $platform

dir=`dirname "$0"`
source "$dir"/itchio_config

function upload () {
  echo uploading $platform

  platform_dir="$dir"/$platform

  butler push "$platform_dir" $user/$itchio_project:$platform
}


platform=macOS
upload

platform=windows
upload
