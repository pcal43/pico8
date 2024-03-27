ROOT_DIR=.
BUILD_DIR=${ROOT_DIR}/build
PICO8_HOME=${ROOT_DIR}/pico8-home
PICO8_CARTS=${PICO8_HOME}/carts
PICO8_BIN=pico8
SHRINKO8=../shrinko8/shrinko8.py
VERSION=0.0.2
RELEASE_UNMINIFIED="${BUILD_DIR}/textorio-unminified-${VERSION}.p8.png"
RELEASE=${BUILD_DIR}/textorio-${VERSION}.p8.png

.PHONY: run
run:
	"${PICO8_BIN}" -home "${PICO8_HOME}"  -root_path  "${PICO8_CARTS}" -run "${PICO8_HOME}/carts/anagrams.p8"

clean:
	rm -rf ./build

version:
	echo "VERSION = \"${VERSION}\"" > ${PICO8_HOME}/carts/anagrams/version.lua

release: clean version
	mkdir -p ./build
	"${PICO8_BIN}" -home "${PICO8_HOME}"  -root_path  "${PICO8_CARTS}" -run "${PICO8_HOME}/carts/anagrams.p8" -export "${RELEASE_UNMINIFIED}"
	${SHRINKO8} "${RELEASE_UNMINIFIED}" "${RELEASE}" --minify-safe-only

run-release: release
	${PICO8_BIN} -run ${RELEASE}

