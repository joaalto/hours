#!/bin/bash

elm-make --yes test/TestRunner.elm --output test-output/raw-test.js
ELM_IO=elm-stuff/packages/laszlopandy/elm-console/1.1.0/elm-io.sh
chmod u+x $ELM_IO
$ELM_IO test-output/raw-test.js test-output/test.js
node test-output/test.js
