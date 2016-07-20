#!/bin/sh
xcodebuild -project XcodebuildHangs.xcodeproj -scheme XcodebuildHangs -destination "platform=iOS Simulator,name=iPad Air 2,OS=10.0" test | tee xcodebuild.log
