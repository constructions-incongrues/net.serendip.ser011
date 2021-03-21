.PHONY: data dist

data:
	tree --noreport -F -J ./dist/html/data/ | jq '.[] | {data: .contents}' > dist/html/app/data.json

html: data
	j2 \
		-f json \
		./src/templates/about.j2 \
		./dist/html/app/data.json \
		> dist/html/app/about.html
	j2 \
		-f json \
		./src/templates/compilation.j2 \
		./dist/html/app/data.json \
		> dist/html/app/compilation.html
	j2 \
		-f json \
		./src/templates/videos.j2 \
		./dist/html/app/data.json \
		> dist/html/app/videos.html
	j2 \
		-f json \
		./src/templates/images.j2 \
		./dist/html/app/data.json \
		> dist/html/app/images.html

usb: html
	rsync -az --progress --delete-after --stats --human-readable ./dist/html/ /media/tristan/SER011/
