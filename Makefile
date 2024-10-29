all: build test
	
build:
	bundle exec jekyll build
	
deps:
	@hash linklint || (sudo apt-get update && sudo apt-get install linklint)

test: linklint

linklint: deps build
	@mkdir -p tmp/
	@linklint -net -redirect -root _site/ /@ -error -warn > tmp/linklint.log 2>&1
	@if cat tmp/linklint.log | grep -e ^ERROR -e ^WARN | grep -v -e 'missing named anchors' | grep -q .; then \
		cat tmp/linklint.log; \
		echo "ERROR: linklint found errors" >&2; \
		exit 1; \
	else \
		echo "OK: linklint found no errors"; \
		exit 0; \
	fi