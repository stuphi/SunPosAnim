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
  -vcodec mpeg2video -crf 15 -t 7 -pix_fmt yuv420p caption.mpg -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/caption_text.png \
  -loop 1 -i frames/frame_001.png \
  -filter_complex "[1:v][0:v]blend=all_expr='A*(if(gte(T,2),1,T/2))+B*(1-(if(gte(T,2),1,T/2)))'" \
  -vcodec mpeg2video -crf 15 -t 3 -pix_fmt yuv420p caption-intro.mpg -y


ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_001.png \
  -vcodec mpeg2video -crf 15 -t 1 -pix_fmt yuv420p intro.mpg -y


ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/frame_%03d.png -vcodec mpeg2video \
  -crf 15 -pix_fmt yuv420p body.mpg -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_365.png \
  -vcodec mpeg2video -crf 15 -t 2 -pix_fmt yuv420p outro.mpg -y

ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_365.png \
  -loop 1 -i frames/endnote_text.png \
  -filter_complex "[1:v][0:v]blend=all_expr='A*(if(gte(T,2),1,T/2))+B*(1-(if(gte(T,2),1,T/2)))'" \
  -vcodec mpeg2video -crf 15 -t 3 -pix_fmt yuv420p outro-endnote.mpg -y


ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/endnote_text.png \
  -vcodec mpeg2video -crf 15 -t 12 -pix_fmt yuv420p endnote.mpg -y


ffmpeg -f concat -i fileList.txt -vcodec libx264 -preset medium -crf 18 \
  output.mp4 -y
