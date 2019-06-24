git config --global user.name "Yasir-siddiqui"
git config --global user.email "www.mohammad.yasir.s@gmail.com"
git config --global color.ui false
apt update && apt upgrade && apt-get install git-core && git clone https://github.com/akhilnarang/scripts && cd scripts && bash setup/android_build_env.sh && mkdir -p ~/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
echo "export PATH=~/bin:$PATH"
apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk python ccache libtinfo5 repo rsync
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
repo sync
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/ prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone https://github.com/Yasir-siddiqui/android_device_yu_lettuce-twrp device/yu/lettuce
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch omni_lettuce-eng; mka recoveryimage
cd out/target/product/lettuce
curl -F'file=@recovery.img' https://0x0.st

