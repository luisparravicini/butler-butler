#!/bin/sh

#
# This script creates builds for several platforms for a Unity project.
# It assumes this directory hierarchy:
# base_dir/
#     UnityProjectName/
#     dist/
#     dist/files/
#
# dist/ is where this script must be located
# dist/files/ is where extra files included in the build must be located (for example: README files)
# UnityProjectName/ is where the project files are. The name of this folder is located in config_data

dir=`dirname "$0"`
source "$dir"/unity_config
project_path="$dir/../$name/"

function build_player () {
  echo
  echo building for $platform

  platform_dir="$dir"/$platform
  rm -rf "$platform_dir"
  mkdir -p "$platform_dir"

  cp "$dir"/files/* "$platform_dir"/

  version=$(grep bundleVersion: "$project_path"/ProjectSettings/ProjectSettings.asset | sed -e 's/[[:blank:]]*bundleVersion:[[:blank:]]*//')
  echo version: $version
  date=$(date +%Y-%m-%d)
  echo "release: $date-r$version" > "$platform_dir"/release.txt

  $unity_path -quit -batchmode -projectpath "$project_path" $platform_arg ../dist/$platform/$binary_name
}


echo using unity from $unity_path
echo
if [ ! -x "$unity_path" ]; then
  echo Unity not found at $unity_path
  exit 1
fi

platform=macOS
platform_arg=-buildOSXUniversalPlayer
binary_name=$name.app
build_player

platform=windows
platform_arg=-buildWindows64Player
binary_name=$name/$name.exe
build_player
