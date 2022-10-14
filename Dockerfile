FROM bitnami/minideb
SHELL ["/bin/bash", "--login", "-c"]
RUN install_packages curl unzip openjdk-11-jre git

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN nvm install lts/gallium
RUN npm add -g react-native-cli react-native

RUN curl -O https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip
RUN mkdir -p /usr/lib/android-sdk/cmdline-tools
RUN unzip commandlinetools-linux-8512546_latest.zip -d /usr/lib/android-sdk/cmdline-tools
RUN rm commandlinetools-linux-8512546_latest.zip
RUN mv /usr/lib/android-sdk/cmdline-tools/cmdline-tools/ /usr/lib/android-sdk/cmdline-tools/latest/
RUN yes | /usr/lib/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses

ENV ANDROID_HOME /usr/lib/android-sdk
WORKDIR /workspace

ENTRYPOINT ["/bin/bash", "--login", "-c"]