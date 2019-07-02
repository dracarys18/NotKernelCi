#!bin/bash
git config --global user.name "Yasir-siddiqui"
git config --global user.email "www.mohammad.yasir.s@gmail.com"
git config --global color.ui false
apt update && apt upgrade && apt-get install git-core && git clone https://github.com/akhilnarang/scripts && cd scripts && bash setup/android_build_env.sh && mkdir -p ~/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
echo "export PATH=~/bin:$PATH"
apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk python ccache libtinfo5 repo rsync
tanggal=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
START=$(date +"%s")
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
repo sync
git clone https://github.com/Yasir-siddiqui/twrp_device_xiaomi_tiare device/xiaomi/tiare
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_tiare-eng
mka recoveryimage
echo "kek"
cd out/target/product/tiare
curl -F'file=@recovery.img' https://0x0.st

function push() {
	curl -F document=@recovery.img "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" \
			-F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s). | #NotKernel | <b>GCC 4.9</b>"
}
# Fin Error
function finerr() {
        curl -s -X POST "https://api.telegram.org/bot$token/sendSticker" \
                        -d sticker="CAADBQADVAADaEQ4KS3kDsr-OWAUAg" \
                        -d chat_id=$chat_id
        exit 1
}

END=$(date +"%s")
DIFF=$(($END - $START))
push
