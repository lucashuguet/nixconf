#!/usr/bin/env nix-shell
#!nix-shell -i bash -p calibre poppler poppler_utils

css=$(cat <<'EOF'
body {
    background-color: #000000;
    color: #FFFFFF;
}

p, h1, h2, h3, h4, h5, h6, li, span {
    color: #FFFFFF;
    margin: 0 25px 0;
}

a {
    color: #00FFFF;
}
EOF
)

# --paper-size a5 \
ebook-convert $1 "$TMPDIR/output.pdf" \
              --embed-all-fonts --extra-css "$css" \
              --custom-size 5.8x10.4 \
              --preserve-cover-aspect-ratio \
              --pdf-default-font-size 32 --pdf-mono-font-size 24 \
              --pdf-page-margin-bottom 0 --pdf-page-margin-left 0 --pdf-page-margin-right 0 --pdf-page-margin-top 0 \
              --margin-bottom 0 --margin-left 0 --margin-right 0 --margin-top 0

pdftoppm -jpeg "$TMPDIR/output.pdf" "$TMPDIR/"
images=$(find "$TMPDIR" -name "*.jpg" | sort)
counter=1

for img in $images; do
    mv "$img" "$TMPDIR/$(printf '%06d.jpg' $counter)"
    ((counter++))
done

7z a -tzip -m0=Copy "$(basename $1 | sed 's/epub/cbz/g')" "$TMPDIR/*.jpg"

rm -r $TMPDIR
