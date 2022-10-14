# docker-react-native-apk-build

Pushed to Docker Hub: https://hub.docker.com/r/mmedin/react-native-apk-build

## Intro

This image is primarily oriented to help with the creation of a debug APK for Android. It is based on the minimalist Debian-based image [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb). It tries to be a lighter option than other similar efforts, and therefore more suitable for CI.

## Some of the components included

- glibc
- openjdk-11-jre
- nvm
- nodejs lts/gallium
- npm
- react-native and react-native-cli
- command line tools from the android sdk

## Usage examples

With this image you could create a React Native app skeleton:

```
docker run --rm -v $(pwd):/workspace mmedin/react-native-apk-build "react-native init HelloReact"
```

And then you could generate an Android debug APK to manually install in your phone:

```
cd HelloReact
docker run --rm -v $(pwd):/workspace mmedin/react-native-apk-build "cd android && ./gradlew assembleDebug"
```

This is assuming that you have the proper configuration in `android/app/build.gradle`:

```
project.ext.react = [
    ...
    bundleInDebug: true,
    devDisabledInDebug: true,
    ...
]
```

Otherwise, you could need to bundle before creating the APK:

```
docker run --rm -v $(pwd):/workspace mmedin/react-native-apk-build \
    "react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res"
```

(folders may differ)
