#!/bin/sh

VERSION=0.0.18

# Update all Kubernetes Deployments to use latest tag
sed -ir "s/\(miclip\/[A-Za-z]*-service:\)\(.*\)/\1${VERSION}/g" ./spring-cloud-gateway/*/manifest.yml

SERVICE_NAME=discovery-service
pushd ./spring-cloud-gateway/$SERVICE_NAME > /dev/null
    JAR_NAME=./target/$SERVICE_NAME-0.0.1-SNAPSHOT.jar
    IMAGE_NAME=miclip/$SERVICE_NAME:$VERSION
    $MAVEN_HOME/bin/mvn -Dmaven.test.failure.ignore=true clean install
    docker build -t $IMAGE_NAME . --build-arg JAR_FILE=$JAR_NAME
    docker push $IMAGE_NAME
    kubectl apply -f ./manifest.yml
popd > /dev/null

SERVICE_NAME=first-service
pushd ./spring-cloud-gateway/$SERVICE_NAME > /dev/null
    JAR_NAME=./target/$SERVICE_NAME-0.0.1-SNAPSHOT.jar
    IMAGE_NAME=miclip/$SERVICE_NAME:$VERSION
    $MAVEN_HOME/bin/mvn -Dmaven.test.failure.ignore=true clean install
    docker build -t $IMAGE_NAME . --build-arg JAR_FILE=$JAR_NAME
    docker push $IMAGE_NAME
    kubectl apply -f ./manifest.yml
popd > /dev/null

SERVICE_NAME=second-service
pushd ./spring-cloud-gateway/$SERVICE_NAME > /dev/null
    JAR_NAME=./target/$SERVICE_NAME-0.0.1-SNAPSHOT.jar
    IMAGE_NAME=miclip/$SERVICE_NAME:$VERSION
    $MAVEN_HOME/bin/mvn -Dmaven.test.failure.ignore=true clean install
    docker build -t $IMAGE_NAME . --build-arg JAR_FILE=$JAR_NAME
    docker push $IMAGE_NAME
    kubectl apply -f ./manifest.yml
popd > /dev/null

SERVICE_NAME=gateway-service
pushd ./spring-cloud-gateway/$SERVICE_NAME > /dev/null
    JAR_NAME=./target/$SERVICE_NAME-0.0.1-SNAPSHOT.jar
    IMAGE_NAME=miclip/$SERVICE_NAME:$VERSION
    $MAVEN_HOME/bin/mvn -Dmaven.test.failure.ignore=true clean install
    docker build -t $IMAGE_NAME . --build-arg JAR_FILE=$JAR_NAME
    docker push $IMAGE_NAME
    kubectl apply -f ./manifest.yml
popd > /dev/null

SERVICE_NAME=hystrix-dashboard
pushd ./spring-cloud-gateway/$SERVICE_NAME > /dev/null
    JAR_NAME=./target/$SERVICE_NAME-0.0.1-SNAPSHOT.jar
    IMAGE_NAME=miclip/$SERVICE_NAME:$VERSION
    $MAVEN_HOME/bin/mvn -Dmaven.test.failure.ignore=true clean install
    docker build -t $IMAGE_NAME . --build-arg JAR_FILE=$JAR_NAME
    docker push $IMAGE_NAME
    kubectl apply -f ./manifest.yml
popd > /dev/null
