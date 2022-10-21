# docker-react-native-apk-build

Pushed to Docker Hub: https://hub.docker.com/r/mmedin/react-native-apk-build

## Intro

This image is primarily oriented to help with the creation of a debug APK for Android. Version [1.0.0](https://github.com/mmedin/docker-react-native-apk-build/releases/tag/1.0.0) is based on the minimalist Debian-based image [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb). Version [2.0.0](https://github.com/mmedin/docker-react-native-apk-build/releases/tag/2.0.0) is based on the official [gradle](https://hub.docker.com/_/gradle) image.

It tries to be a lighter option than other similar efforts, and therefore more suitable for CI.

## Some of the components included

- glibc
- openjdk-11
- nvm
- nodejs 16.x
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
docker run --rm -v $(pwd):/workspace mmedin/react-native-apk-build "cd android; gradle assembleDebug"
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
