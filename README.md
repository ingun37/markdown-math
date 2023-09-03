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

Download sample from [myscript/interactive-ink-examples-ios](https://github.com/myscript/interactive-ink-examples-ios).

Import [Demo](https://github.com/MyScript/interactive-ink-examples-ios/tree/master/Examples/Demo/Demo) and [Frameworks](https://github.com/MyScript/interactive-ink-examples-ios/tree/master/Examples/Frameworks/) to project. Choose *Create groups* when adding the folders.

Make some changes.

### Header search path

Add `${SRCROOT}/Frameworks` or wherever the `Frameworks` folder is to  Header Search Paths as non-recursive.

### Remuve conflicting project data

Remove `Demo/Supporting Files`

### Implement MyScriptSampleDelegate in MainViewController

Add property `var myscriptSampleDelegate: MyScriptSampleDelegate?` to `MainViewController`.

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

Add `myScriptSampleDelegate: MyScriptSampleDelegate` parameter to `MainCoordinator`'s `init()` and pass it to `mainViewController`.


### Remove redundant UI components

In `Main.storyboard`, remove

* Add button in the middle of bottom bar

### Change Prev and Next to Cancel and Done

In `Main.storyboard`, change the Prev and Next at the bottom toolbar to Cancel and Done.

In `MainViewModel`, set default value of `previousButtonEnabled` and `nextButtonEnabled` to true. It has to remain true and never change so search for all their usages and delete.

### Bundle Resources

Go to project setting > Build Phases > Copy Bundle Resources and add `.../recognition-assets` as folder.

### Frameworks

Copy and add `/interactive-ink-examples-ios/Examples/Frameworks` to somewhere.

If there are errors anywhere `CONTROL_GRAY_COLOR` or `WORD_GRAY_COLOR` is used then delete them.
