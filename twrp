#!bin/bash
sudo apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk python ccache libtinfo5 repo
echo ";_;"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
ls
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
echo "Done"
repo sync
echo "Kek Done"
echo "Clone Toolchains"
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/ prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
GCC="$(pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
echo "Done"
git clone https://github.com/Yasir-siddiqui/android_device_yu_lettuce-twrp
echo "kek"
tanggal=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
echo "Starting Build"
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch omni_lettuce-eng; mka recoveryimage

# Push 
function push() {
        cd out/target/product/lettuce
	curl -F document=@recovery.img "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" \
			-F caption="haha yash"
}
END=$(date +"%s")
DIFF=$(($END - $START))
push
sticker
