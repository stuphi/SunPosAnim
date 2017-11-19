IMAGES=frames/caption_text.png frames/endnote_text.png frames/frame_001.png frames/blend1-001.png frames/blend2-001.png

VIDS=caption.mp4 endnote.mp4 body.mp4 blend1.mp4 blend2.mp4 intro.mp4 outro.mp4

all: output.mp4

output.mp4: $(IMAGES) $(VIDS) fileList.txt
	ffmpeg -f concat -i fileList.txt -vcodec copy output.mp4 -y

frames/caption_text.png: caption_text.txt
	convert -background white -fill black -font IBM-Plex-Sans -size 1920x1080 \
	  -gravity Center caption:"`cat caption_text.txt`" frames/caption_text.png

frames/endnote_text.png: endnote_text.txt
	convert -background white -fill black -font IBM-Plex-Sans -size 1920x1080 \
	  -gravity Center caption:"`cat endnote_text.txt`" frames/endnote_text.png

frames/frame_001.png: sunpos.plt
	gnuplot sunpos.plt

frames/blend1-001.png: frames/caption_text.png frames/frame_001.png
	bash blend1.sh

frames/blend2-001.png: frames/endnote_text.png frames/frame_001.png
	bash blend2.sh

caption.mp4: frames/caption_text.png
	ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/caption_text.png \
	  -vcodec libx264 -preset medium -crf 15 -t 7 -pix_fmt yuv420p caption.mp4 -y

endnote.mp4: frames/endnote_text.png
	ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/endnote_text.png \
		-vcodec libx264 -preset medium -crf 15 -t 7 -pix_fmt yuv420p endnote.mp4 -y

body.mp4: frames/frame_001.png
	ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/frame_%03d.png -vcodec libx264 \
		-preset medium -crf 15 -pix_fmt yuv420p body.mp4 -y

blend1.mp4: frames/blend1-001.png
	ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/blend1-%03d.png -vcodec libx264 \
		-crf 15 -pix_fmt yuv420p blend1.mp4 -y

blend2.mp4: frames/blend2-001.png
	ffmpeg -r 30 -f image2 -s 1920x1080 -i frames/blend2-%03d.png -vcodec libx264 \
		-crf 15 -pix_fmt yuv420p blend2.mp4 -y

intro.mp4: frames/frame_001.png
	ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_001.png \
		-vcodec libx264 -preset medium -crf 15 -t 1 -pix_fmt yuv420p intro.mp4 -y

outro.mp4: frames/frame_001.png
	ffmpeg -r 30 -loop 1 -f image2 -s 1920x1080 -i frames/frame_365.png \
		-vcodec libx264 -preset medium -crf 15 -t 2 -pix_fmt yuv420p outro.mp4 -y

clean:
	rm *.mp4 frames/*.png
