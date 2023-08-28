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

## How to run MyScript Examples on your iPad

- Change the sample's bundle identifier to `ingun.markdown-math`.
- Copy the contents of `/MyCertificate/ingun.markdown-math.c` and paste to `.../MyCertificate.c`

## Implement MyScript Demo

### Main.storyboard

Fix bottom tool bar.

### MainViewController

Add property `var myscriptSampleDelegate: MyScriptSampleDelegate?`

Call `myscriptSampleDelegate.done(tex: String)` from `@IBAction private func nextPart(_ sender: Any)` with exported latex as parameter.

```swift
let imageLoader = ImageLoader()
let imagePainter = ImagePainter(imageLoader: imageLoader)
if let editor = self.viewModel?.editor {
    let part = editor.part?.identifier ?? ""
    let type = editor.part?.type ?? ""
    editor.waitForIdle() // Waits until part modification operations are over.
    if let aaa = try? editor.export(selection: editor.rootBlock,
                                mimeType: IINKMimeType.laTeX
    ) {
        self.myscriptSampleDelegate?.done(tex:aaa)
    }
}
```

Call `myscriptSampleDelegate.cancel()` from `@IBAction private func previousPart(_ sender: Any)`.

### MainViewModel.swift

Set default value of `previousButtonEnabled` and `nextButtonEnabled` to true. It has to remain ture so search for all their changes and delete.

### MainCoordinator.swift

Add `myScriptSampleDelegate: MyScriptSampleDelegate` parameter to `init()` and pass it to `mainViewController`.