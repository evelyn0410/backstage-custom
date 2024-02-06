yarn install

yarn build:backend --config ../../app-config.yaml

docker login docker.openmsa.monster -u admin -p osckorea!

docker build . -t docker.openmsa.monster/backstage

docker push docker.openmsa.monster/backstage