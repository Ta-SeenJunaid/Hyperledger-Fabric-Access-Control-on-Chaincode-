export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx
export VERBOSE=false

function printHelp(){
    echo "Usage: "
}

function clearContainers(){
    CONTAINER_IDS=$(docker ps -a | awk '($2 ~ /dev-peer.*/) {print $1}')
    if [ -z "$CONTAINER_IDS" -o "$CONTAINER_IDS" == " " ]; then
        echo "--------- No containers available for deletion ------------"
    else
        docker rm -f $CONTAINER_IDS
    fi
}

function removeUnwantedImages() {
    DOCKER_IMAGE_IDS=$(docker images |  awk '($1 ~ /dev-peer.*/) {print $3}')
    if [-z "$DOCKER_IMAGE_IDS" -o "DOCKER_IMAGE_IDS" == " "]; then
        echo "---------- No images available for deletion ------------"
    else
        docker rmi -f $DOCKER_IMAGE_IDS
    fi
}

BLACKLISTED_VERSIONS="^1\.0\. ^1\.1\. ^1\.2\. ^1\.3\. ^1\.4\."
