#!/bin/bash

for i in {1..30}
do
  outFile=`printf "frames/blend1-%03d.png" $i`
  blend=`echo "scale=3;($i/30)*100" | bc`
  echo $outFile
  composite -blend $blend frames/frame_001.png frames/caption_text.png $outFile
done

ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/blend1-%03d.png -vcodec libx264 \
  -crf 15 -pix_fmt yuv420p blend1.mp4 -y