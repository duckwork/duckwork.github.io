# Blog makefile.  Run after doing a post.
# by Case Duckworth.
# vim: fdm=marker

htmlOptions := --template=p/_template.html
htmlOptions += --normalize

reverse = $(if $(wordlist 2,2,$(1)),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)), $(1))

outputs := $(patsubst p/%.txt,p/%.htm,$(wildcard p/*.txt))

all : $(outputs) index.html

clean :
	rm $(outputs)
	rm index.html

again : clean all

p/%.htm : p/%.txt
	pandoc $< -t html5 $(htmlOptions) -o $@

index.html : $(outputs)
	cat _ante-index.html $(call reverse,$^) _post-index.html > $@
