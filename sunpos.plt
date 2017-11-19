#set terminal postscript eps enhanced color
set terminal pngcairo color enhanced font "IBM Plex Sans,24" dashed size 1920,1080
set size 1

myTitle="Sun Position at Latitude 51° North"

set angles degrees
#set polar
set grid xtics ytics lw 2
#set grid polar
#set size square
set border lw 3
set clip
set xlabel "Azimuth Angle"
set ylabel "Elevation Angle"
set zeroaxis

set xrange [-150:150]
set yrange [-0:90]
set xtics axis -120, 60 font ",20"
set ytics 0, 30 font ",20"

set nokey

# This is the seconds since epoc for 2016-12-31
secs=1483142400

tilt=23.43697
do for [N=1:365]{
  dsecs = secs + N * 24 * 60 * 60
  date = system("date -d@".dsecs." +'%B %e'")
  myTitle2 = myTitle."\n".date
  set title myTitle2
  filename = sprintf("frames/frame_%03d.png", N)
  set output filename
  lat=51
  sunDec = asin(sin(-tilt)*cos(360/365.24*(N+10)+360/pi*0.0167*sin(360/365.24*(N-2))))

  sunEl(x) = asin(sin(lat)*sin(sunDec) + cos(lat)*cos(sunDec)*cos(x))

  plot 	 sunEl(x) with lines lw 3
}
