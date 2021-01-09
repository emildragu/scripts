#!/bin/bash
#
#Script Name    :printscreen_to_text
#Description    :Converts screen area selection to be converted to text
#Author         :Emil Dragu
#Email          :emil.dragu@gmail.com
#
#Usage:
# ./printscreen_to_text.sh [NOREVERT]
#
#
# After running the script, the text is in your clipboard. By default, colors are reverted as majority
# of prinscreens are from dark background. If set NOREVERT will not invert the image.
#
# Installing tesseract: https://www.cloudsavvyit.com/8151/how-to-convert-images-to-text-on-the-linux-command-line-with-ocr/
# On Centos 8 PowerTools needs to be enabled
# Centos: sudo yum install tesseract-devel leptonica-devel
# Ubuntu: sudo apt install tesseract-ocr libtesseract-dev tesseract-ocr-eng

NOREVERT=$1

gnome-screenshot --area --file=/tmp/file.png

if [ "$NOREVERT" == "" ]; then
    echo "Reverting image"
    convert /tmp/file.png -channel RGB -negate /tmp/file.png
fi

tesseract -l eng /tmp/file.png - | xclip -selection c
