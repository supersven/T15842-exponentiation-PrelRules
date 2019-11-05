all : run

build: clean
	nix-shell --pure --arg compiler \"ghcHEAD\" --command "cabal new-build && mv ghc_dumps ghc-\`ghc --numeric-version\`_dumps"
	nix-shell --pure --arg compiler \"ghc865\" --command "cabal new-build && mv ghc_dumps ghc-\`ghc --numeric-version\`_dumps"
	nix-shell --pure --arg compiler \"ghc881\" --command "cabal new-build && mv ghc_dumps ghc-\`ghc --numeric-version\`_dumps"
	nix-shell --pure --command "cabal new-build --with-compiler /home/sven/src/ghc/_build/stage1/bin/ghc && mv ghc_dumps ghc-with-rules_dumps"

run: build
	touch result.txt
	echo "new GHC with rules" >> result.txt
	echo "1. Run" >> result.txt
	nix-shell --pure --command "cabal new-exec --with-compiler /home/sven/src/ghc/_build/stage1/bin/ghc main >> result.txt"
	echo "2. Run" >> result.txt
	nix-shell --pure --command "cabal new-exec --with-compiler /home/sven/src/ghc/_build/stage1/bin/ghc main >> result.txt"
	nix-shell --pure --arg compiler \"ghcHEAD\" --command "echo ghc-\`ghc --numeric-version\`" >> result.txt
	echo "1. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghcHEAD\" --command "cabal new-exec main >> result.txt"
	echo "2. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghcHEAD\" --command "cabal new-exec main >> result.txt"
	nix-shell --pure --arg compiler \"ghc865\" --command "echo ghc-\`ghc --numeric-version\`" >> result.txt
	echo "1. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghc865\" --command "cabal new-exec main >> result.txt"
	echo "2. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghc865\" --command "cabal new-exec main >> result.txt"
	nix-shell --pure --arg compiler \"ghc881\" --command "echo ghc-\`ghc --numeric-version\`" >> result.txt
	echo "1. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghc881\" --command "cabal new-exec main >> result.txt"
	echo "2. Run" >> result.txt
	nix-shell --pure --arg compiler \"ghc881\" --command "cabal new-exec main >> result.txt"

clean: clean-cabal
	rm -rf *_dumps
	rm -f result.txt

clean-cabal:
	nix-shell --pure --command "cabal new-clean"

build-new-rules-ghc-only: clean-cabal
	nix-shell --pure --command "cabal new-build --with-compiler /home/sven/src/ghc/_build/stage1/bin/ghc &> build.log"
