#!/bin/bash

convert -background white -fill black -font Century-Gothic -size 1920x1080 \
  -gravity Center \
  caption:'The following animation shows the sun elevation and azimuth \
  for the latitude 51° North' \
  frames/caption_text.png

convert -background white -fill black -font Century-Gothic -size 1920x1080 \
  -gravity Center \
  caption:'For details on the calculations see the Wikipedia articals on sun \
  position such as\nhttps://en.wikipedia.org/wiki/Position_of_the_Sun\n
  For implimentation, see\nhttps://github.com/stuphi/SunPosAnim' \
  frames/endnote_text.png


ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/caption_text.png \
  -vcodec libx264 -crf 25 -t 7 -pix_fmt yuv420p caption.mp4 -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_001.png \
  -vcodec libx264 -crf 25 -t 2 -pix_fmt yuv420p intro.mp4 -y


ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/frame_%03d.png -vcodec libx264 \
  -crf 25 -pix_fmt yuv420p body.mp4 -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_365.png \
  -vcodec libx264 -crf 25 -t 2 -pix_fmt yuv420p outro.mp4 -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/endnote_text.png \
  -vcodec libx264 -crf 25 -t 14 -pix_fmt yuv420p endnote.mp4 -y


ffmpeg -f concat -i fileList.txt -c copy \
  output.mp4 -y
