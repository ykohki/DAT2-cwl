#!/bin/sh
set -eux
cd .

#wget https://raw.githubusercontent.com/bonohu/denovoTA/master/for_trinity.pl
docker image build -t dat2-cwl/sleuth .

#コンテナを起動
docker container run --name sleuth -itd dat2-cwl/sleuth

#docker container cp target2gene:target2gene.txt .
