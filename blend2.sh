#!/bin/bash

for i in {1..30}
do
  outFile=`printf "frames/blend2-%03d.png" $i`
  blend=`echo "scale=3;($i/30)*100" | bc`
  echo $outFile
  composite -blend $blend frames/endnote_text.png frames/frame_365.png $outFile
done
