#!/bin/bash
# for: bulk merge bilibili UWP download file *.flv
# by: blog.502.li
# date: 2019-01-12
# 将该脚放到 UWP 客户端下载缓存主目录下执行，安装 ffmpeg、jq

set -xu
download_dir=$(pwd)
mp4_dir=${download_dir}/mp4
mkdir -p ${mp4_dir}

for video_dir in $(ls | sort -n | grep -E -v "\.|mp4")
do
  cd ${download_dir}/${video_dir}
  up_name=$(jq ".Uploader" *.dvi | tr -d "[:punct:]\040\011\012\015")
  mkdir -p ${mp4_dir}/${up_name}
  for p_dir in $(ls | sort -n | grep -v "\.")
  do
    cd ${download_dir}/${video_dir}/${p_dir}
    video_name=$(jq ".Title" *.info | tr -d "[:punct:]\040\011\012\015")
    part_name=$(jq ".PartName" *.info | tr -d "[:punct:]\040\011\012\015")
    upload_time=$(grep -Eo "20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" *.info)
    Uploader=$(jq ".Uploader" *.info | tr -d "[:punct:]\040\011\012\015")
    Format=$(jq ".Format" *.info | tr -d "[:punct:]\040\011\012\015")
    
    if [ "null" = "${part_name}" ];then
      mp4_file_name=${video_name}.mp4
    else
      mp4_file_name=${video_name}_${p_dir}_${part_name}.mp4
    fi

    if [ "1" = "${Format}" ];then
      ls *.flv | sort -n > ff.txt
      sed -i 's/^/file /g' ff.txt
      ffmpeg -f concat -i ff.txt -c copy ${mp4_dir}/${up_name}/"${mp4_file_name}";rm -rf ff.txt
    else
      ffmpeg  -i video.mp4 -i audio1.mp4 -c:v copy -c:a copy ${mp4_dir}/${up_name}/"${mp4_file_name}"
    fi
    cd ${download_dir}/${video_dir}
  cd ${download_dir}
  done
# 如果需要保留原视频请注释掉下面这一行
#rm -rf ${download_dir}/${video_dir}
done
