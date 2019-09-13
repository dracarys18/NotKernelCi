#!bin/bash
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
echo "Clone Toolchains"
git clone -q -j32 https://github.com/dracarys18/toolchain.git 
git clone -q -j32 https://github.com/dracarys18/toolchain32.git
echo "Done"
echo "Clone AnyKernel"
git clone -q -j32 https://github.com/Yasir-siddiqui/AnyKernel3 AnyKernel
echo "Done"
GCC="$(pwd)/toolchain/bin/aarch64-linux-android-"
GCC32="$(pwd)/toolchain32/bin/arm-linux-androideabi-"
tanggal=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
START=$(date +"%s")
export ARCH=arm64
export KBUILD_BUILD_USER=jaggu
export KBUILD_BUILD_HOST=NotKernel
# sticker plox
function sticker() {
        curl -s -X POST "https://api.telegram.org/bot$token/sendSticker" \
                        -d sticker="CAADBAADagEAAuhjxBRu9ugk5rkhTgI" \
                        -d chat_id=$chat_id
}
# Send info plox channel
function sendinfo() {
        curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
                        -d chat_id=$chat_id \
                        -d "parse_mode=html" \
                        -d text="<b>NotKernel </b> new build is up%0AStarted on <code>Drone CI</code>%0AFor device <b>MIDO</b> (Redmi Note 4)%0Abranch <code>$(git rev-parse --abbrev-ref HEAD)</code> (Android 9.0/Pie)%0AUnder commit <code>$(git log --pretty=format:'"%h : %s"' -1)</code>%0AUsing compiler: <code>$(${GCC}gcc --version | head -n 1)</code>%0AStarted on <code>$(TZ=Asia/India date)</code>%0A<b>DroneCI Status</b> <a href='https://cloud.drone.io/dracarys18/NotKernel'>here</a>%0A<b>Build Status:</b> #untested"
}
# Push kernel to channel
function push() {
        cd AnyKernel
	ZIP=$(echo Not*.zip)
	curl -F document=@$ZIP "https://api.telegram.org/bot$token/sendDocument" \
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
# Compile plox
function compile() {
        export CROSS_COMPILE=${GCC}
	export CROSS_COMPILE_ARM32=${GCC32}
        make O=out clean && make O=out mrproper && make O=out mido_defconfig
	make O=out -j$(nproc --all) 2>&1| tee build.log
            if ! [ -a $IMAGE ]; then
                finerr
                exit 1
            fi
        cp out/arch/arm64/boot/Image.gz-dtb AnyKernel/zImage
}
# Zipping
function zipping() {
        cd AnyKernel
        zip -r9 NotKernel*-${tanggal}.zip *
        cd ..
}
sendinfo
compile
zipping
END=$(date +"%s")
DIFF=$(($END - $START))
push
sticker
