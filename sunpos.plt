#set terminal postscript eps enhanced color
set terminal pngcairo color enhanced font "Century Gothic,16" dashed size 1920,1080
set output "frames/frame_001.png"
set size 1

myTitle="Sun Position at Latitude 51° North"

set angles degrees
#set polar
set grid xtics ytics
#set grid polar
#set size square
set border
set clip
set xlabel "Azimuth Angle"
set ylabel "Elevation Angle"
set zeroaxis

set xrange [-180:180]
set yrange [-0:90]
set xtics axis -180, 60 font ",11"
set ytics 0, 30 font ",11"
#set lmargin 6.0
#set rmargin 4.0
#set bmargin 3
#set tmargin 3

#unset xlabel
#unset ylabel
set nokey

#limit=2.0

#set size 0.5,0.2
#set origin 0,0

set title myTitle
#set multiplot layout 5,2 title thisTitle

tilt=23.43697
#do for [N=1:365]{
N=365/2
  lat=51
  sunDec = asin(sin(-tilt)*cos(360/365.24*(N+10)+360/pi*0.0167*sin(360/365.24*(N-2))))

  sunEl(x) = asin(sin(lat)*sin(sunDec) + cos(lat)*cos(sunDec)*cos(x))

  plot 	 sunEl(x) with lines lw 1
#}
