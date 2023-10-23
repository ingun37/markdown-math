#!/bin/sh
echo "I am here"
pwd
curl -O "https://s3-us-west-2.amazonaws.com/iink/runtime/2.0.0/MyScriptInteractiveInk-Runtime-iOS-2.0.1.zip" -s
echo "after download"
ls
unzip -q "MyScriptInteractiveInk-Runtime-iOS-2.0.1.zip" -d "../MyScriptInteractiveInk-Runtime-iOS-2"
echo "after unzip"
ls
#  ci_post_clone.sh
#  markdown-math
#
#  Created by Ingun Jon on 10/23/23.
#  
