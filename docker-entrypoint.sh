#!/bin/bash

cp -r /dai_book_viewer/build/* /build
nginx -g 'daemon off;'