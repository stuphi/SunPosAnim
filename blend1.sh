#!/bin/bash

for i in {1..30}
do
  outFile=`printf "frames/blend1-%03d.png" $i`
  blend=`echo "scale=3;($i/30)*100" | bc`
  echo $outFile
  composite -blend $blend frames/frame_001.png frames/caption_text.png $outFile
done
