FROM gradle:7-jdk11-jammy
ENV DEBIAN_FRONTEND=noninteractive

### Installing nodejs and react dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -
RUN apt update && \
    apt install -y nodejs && \
    rm -rf /var/lib/apt/lists/*
RUN npm add -g react-native-cli react-native

### Installing Android command line tools
RUN curl -O https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \
    mkdir -p /usr/lib/android-sdk/cmdline-tools && \
    unzip commandlinetools-linux-8512546_latest.zip -d /usr/lib/android-sdk/cmdline-tools && \
    rm commandlinetools-linux-8512546_latest.zip && \
    mv /usr/lib/android-sdk/cmdline-tools/cmdline-tools/ /usr/lib/android-sdk/cmdline-tools/latest/
RUN yes | /usr/lib/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses

ENV ANDROID_HOME /usr/lib/android-sdk
WORKDIR /workspace
ENTRYPOINT ["/bin/bash", "--login", "-c"]