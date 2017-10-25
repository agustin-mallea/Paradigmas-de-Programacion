#
# Pure OCaml, no packages, no _tags, code in serveral directories
#

# bin-annot is required for Merlin and other IDE-like tools
# The -I flag introduces sub-directories to search for code

OCB_FLAGS = -tag bin_annot -I src
OCB = 		ocamlbuild $(OCB_FLAGS)

all: 		native	

clean:
			rm -r bin/*

native:
			$(OCB) composer.native
			rm -f -r bin
			mkdir -p bin;
			rm composer.native; 
			mv _build bin/_build;
			link bin/_build/src/composer.native bin/composer


test: 		native
			./composer.native "OCaml" "OCamlBuild" "users"
			

.PHONY: 	all clean byte native profile debug test


