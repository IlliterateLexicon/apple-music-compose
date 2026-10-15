from alpine:latest as build
run apk add --no-cache cmd:unzip cmd:curl cmd:ffmpeg gcompat 
workdir /app
add https://nightly.link/WorldObservationLog/wrapper/workflows/build-lite/lite/wrapper-lite-linux-x86_64.zip /app/wrapper.zip
add https://github.com/zhaarey/apple-music-downloader/releases/latest/download/amdl_linux_amd64 /app/amdl
run unzip ./wrapper.zip; chmod +x ./amdl

# if login is cached start wrapper otherwise login
entrypoint [ "sh", "-c", "\
[ -d /cache/mpl_db ] && (\
cp -r /cache/* /app/rootfs;\
./wrapper-lite-rootless --base-dir ./ & \
sleep 5; \ 
while read url; do ./amdl -c /config.yaml $url; done < /urls.txt; \
) || (\
([ -z $USERNAME ] || [ -z $PASSWORD ] ) && echo -e \"\\033[91m ERROR:\\033[0m LOGIN REQUIRED BUT USERNAME AND PASSWORD NOT SET!\" && exit 1; \
./wrapper-lite-rootless --base-dir ./ --login \"$USERNAME:$PASSWORD\" --code-from-file; \
cp -r /app/rootfs/mpl_db /cache; \
)\
"]
