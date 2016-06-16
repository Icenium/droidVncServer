#!/usr/bin/env bash

echo "Installing System Tools..."
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install -y curl >/dev/null 2>&1
sudo apt-get install -y unzip >/dev/null 2>&1
sudo apt-get install -y libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 >/dev/null 2>&1
sudo apt-get update >/dev/null 2>&1
sudo apt-get install apt-file && apt-file update
sudo apt-get install -y python-software-properties >/dev/null 2>&1

#  http://askubuntu.com/questions/147400/problems-with-eclipse-and-android-sdk
sudo apt-get install -y ia32-libs >/dev/null 2>&1

echo "Installing Android ADT Bundle with SDK and Eclipse..."
cd /tmp
sudo curl -O http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20130729.zip
sudo unzip /tmp/adt-bundle-linux-x86_64-20130729.zip >/dev/null 2>&1
sudo mv /tmp/adt-bundle-linux-x86_64-20130729 /usr/local/android/
sudo rm -rf /tmp/adt-bundle-linux-x86_64-20130729.zip

echo "Installing Android NDK..."
cd /tmp
sudo curl -O http://dl.google.com/android/ndk/android-ndk-r9-linux-x86_64.tar.bz2
sudo tar -jxf /tmp/android-ndk-r9-linux-x86_64.tar.bz2 >/dev/null 2>&1
sudo mv /tmp/android-ndk-r9 /usr/local/android/ndk
sudo rm -rf /tmp/android-ndk-r9-linux-x86_64.tar.bz2

sudo mkdir /usr/local/android/sdk/add-ons

sudo chmod -R 755 /usr/local/android

sudo ln -s /usr/local/android/sdk/tools/android /usr/bin/android
sudo ln -s /usr/local/android/sdk/platform-tools/adb /usr/bin/adb

echo "Updating ANDROID_HOME..."
cd ~/
cat << End >> .profile
export ANDROID_HOME="/usr/local/android/sdk"
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/usr/local/android/ndk:$PATH
End


echo "Adding USB device driver information..."
echo "For more detail see http://developer.android.com/tools/device.html"

sudo cp /vagrant/51-android.rules /etc/udev/rules.d
sudo chmod a+r /etc/udev/rules.d/51-android.rules

sudo service udev restart

sudo android update adb
sudo adb kill-server
sudo adb start-server

cd ~/
sudo git clone https://github.com/Icenium/droidVncServer.git
echo "Cloned droidVncServer to ~/droidVncServer. To build it, use $ sudo ndk-build"