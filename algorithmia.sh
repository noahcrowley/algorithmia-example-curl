#!/bin/bash

printf "Calling demo/Hello\n"

curl https://api.algorithmia.com/v1/algo/demo/Hello \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '"HAL 9000"'

printf "\nCall nlp/LDA/1.0.0\n"

curl https://api.algorithmia.com/v1/algo/nlp/LDA/1.0.0 \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '{"docsList": ["It'\''s apple picking season","The apples are ready for picking"]}'
    
printf "\nCall demo/Hello with Request Options\n"

curl 'https://api.algorithmia.com/v1/algo/demo/Hello?timeout=60&stdout=false' \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '"HAL 9001"'

printf "\nCall wrong algo\n"

curl https://api.algorithmia.com/v1/algo/util/whoopsWrongAlgo \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '"Hello, world"'

printf "\nCreate Directory\n"

curl 'https://api.algorithmia.com/v1/data/.my' \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '{"name": "img_directory"}'

printf "\nSet Directory Permissions\n"

curl 'https://api.algorithmia.com/v1/connector/data/.my/img_directory' \
    -X PATCH \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '{"acl": {"read": ["user://*"]} }'

printf "\nUpload File\n"

curl 'https://api.algorithmia.com/v1/connector/data/.my/img_directory/friends.jpg' \
    -X PUT \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    --data-binary @friends.jpg

printf "\nCall dlib/Facedetection\n"

curl https://api.algorithmia.com/v1/algo/dlib/FaceDetection/0.2.1 \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1' \
    -d '{
    "images": [
        {
            "url": "data://.my/img_directory/friends.jpg",
            "output": "data://.algo/temp/detected_faces.png"
        }
    ]
}'

printf "\nDownload File\n"

curl -O https://api.algorithmia.com/v1/connector/data/.algo/dlib/FaceDetection/temp/detected_faces.png \
    -H 'Authorization: Simple simJsfTIRQXG0pwayRklahVH2sh1'

printf "\nFin\n"