Run these commands:

    cp -R ~/.ssh .ssh
    cp  -R ~/.aws .aws
    rm .ssh/known_hosts

Then fill .env file with your email and name

Run:
    
    docker-compose build
    docker-compose up -d
    docker exec -it linux_docker_goldrush bash

___
Auto deploy commands:

    sh deploy_kohls.sh 3.149.0


    sh deploy_default_us_east_1.sh 3.149.0

    sh deploy_prod_eu_west_1.sh 3.149.0

    sh deploy_prod_us_east_1.sh 3.149.0
___
___
MANUAL deploy commands:

    cd goldrush
    git checkout 3.149.0

    time ./deployToFleet.sh -r us-east-1 -p default -g | tee ../release_3.149.0_us_default.log
    time ./deployToFleet.sh -r eu-west-1 -p prod -g | tee ../release_3.149.0_eu_prod.log
    time ./deployToFleet.sh -r us-east-1 -p prod -g | tee ../release_3.149.0_us_prod.log

Clean repository after deploy

    git restore --staged .
    git checkout -- .
    git clean -f
___
Finish
___
___
___

rebuild container without cache
    
    docker-compose build --no-cache