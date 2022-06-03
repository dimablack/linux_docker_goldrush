___
## PREPARE
___
Run these commands(once):

    cp -R ~/.ssh .ssh
    cp  -R ~/.aws .aws
    rm .ssh/known_hosts

Then fill .env file with your email and name

Add the next line to .ssh/config file after 'Host *' in line 2:

    IgnoreUnknown AddKeysToAgent,UseKeychain

Run(once), if you changed Dockerfile, run this command again:
    
    docker-compose build --no-cache
___
___
## USAGE
___
**Everytime when you want to deploy:**

    docker-compose up -d && docker exec -it linux_docker_goldrush bash

___
Auto deploy commands:

    sh deploy_kohls.sh 3.149.0


    sh deploy_default_us_east_1.sh 3.149.0

    sh deploy_prod_eu_west_1.sh 3.149.0

    sh deploy_prod_us_east_1.sh 3.149.0

___
___
___
## ADDITIONAL
___
Remove repository and git clone the last one

    sh clean_new_repository.sh
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
Thanks)))
___
