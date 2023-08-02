#  Markdown Math

## Build

I'll assume the myscript version is 2.0.1.

Download [MyScriptInteractiveInk-Runtime-iOS](https://s3-us-west-2.amazonaws.com/iink/runtime/2.0.0/MyScriptInteractiveInk-Runtime-iOS-2.0.1.zip) and unzip at the project root.

Place `ingun.markdown-math.c` that is sent you by email under MyCertificate/ folder.

Run

```sh
./retrieve_recognition-assets.sh .
```

The version is fixed to 2.0.1 in the script.

## Linting

Use [SwiftLint](https://github.com/realm/SwiftLint).

```shell
# install
brew install swiftlint

# run
swiftlint --fix
```
