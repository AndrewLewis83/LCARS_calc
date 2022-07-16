# LCARS_calc
Star Trek: TNG themed calculator for iOS and iPadOS. Also features a tip calculator for WatchOS.

This is an unauthorized Star Trek themed calculator. It is purely open source and not meant to be sold. Think of it as fan fiction. 

Supports iPod touch, and all iPhone and iPad sizes. Split screen on iPad is not currently supported. Apple Watch app fits the 40 mm through 45 mm screen sizes (meaning, not the series 3). The only physical device I was able to test it on the watch series 7, 45 mm.

*NOTE: please let me know at andy@andrewlewisdev.com if there are visual issues on the older iPad minis (they aren't offered in the simulator). This version fixes UI issues for the iPad Mini 6th Gen.*

To use: 
- Open the project in Xcode.
- In the signing and capabilities editor, add your team.

*Note: You will need CocoaPods installed before you can complete the following instructions. Please visit https://guides.cocoapods.org/using/getting-started.html if you haven't done this yet. Also, for instructions for installing a CocoaPod in your project, go to: https://guides.cocoapods.org/using/using-cocoapods.html**
- Add the following to your Podfile: 
```
    add 'AnotherCalc'
```
- In Terminal, run 
```
    pod install
```
- Once pods have installed, connect your iOS device (iPhone/iPad) and click the build/run button.
- After you've done all of this, you can install the tip calculator onto Apple Watch through the Apple Watch app on your iPhone.

NOTE: If you don't have an Apple Developer account, the project will need to be reloaded using Xcode every few days. With a developer account, it's once every few months. 
