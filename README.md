`butler-butler` simplifies the process of building Unity builds and uploading them to itchio.

## Requirements

This project uses shell scripts. They run on macOS and Linux. For windows, maybe installing *cygwin* can help in running them. *I think there's something in windows 10 that allows you to run shell scripts?* IDK.

## How to use it?

Assuming you have a directory hierarchy similar to his:

`base/dir/project` is the base of your project

`base/dir/project/unity-project` is where your Unity project located

### Installation

- Install [itchio's butler](https://itch.io/docs/butler/)
- Copy `dist/` to `base/dir/project`
- Edit `dist/itchio_config` with your username and project name
- Edit `dist/unity_config` with your Unity Editor path and the name of the Unity project folder

### Edit platforms

For each platform you will be creating builds you have to:

- At the end of `dist/build_all.sh` there's a block of code for each enabled platform:
```shell
platform=windows
platform_arg=-buildWindows64Player
binary_name=$name/$name.exe
build_player
```

You have to edit this file to add/remove platforms as you wish.
Unity's command line arguments can be found at [docs.unity3d.com/Manual/CommandLineArguments](https://docs.unity3d.com/Manual/CommandLineArguments.html)

- At the end of `dist/upload_all.sh`, there's a block of code for each enabled platform:
```shell
platform=windows
upload
```

You have to edit this file to add/remove platforms as you wish.


### Building

Running `dist/build_all.sh` will create for each platform a directory inside `dist` containing:

- The result of Unity's building process
- A copy of all the files inside `dist/files`
- A txt file named `release.txt` containing the current date and the release number obtained from the Unity project

### Uploading

Running `dist/upload_all.sh` will upload the the releases in `dist` to your project in itchio.
