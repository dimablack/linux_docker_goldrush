SHELL := /bin/bash

OK      := "\033[32;1m [Ok]\033[0m"

help:
	@printf 'Available commands\n\n'
	@IFS=$$'\n' ; \
		help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
		for help_line in $${help_lines[@]}; do \
			IFS=$$'#' ; \
			help_split=($$help_line) ; \
			help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			printf "%-30s %s\n" $$help_command $$help_info ; \
		done

start: ##Start local container and exit to it
	docker-compose up -d && docker exec -it linux_docker_goldrush bash

rebuild-start: ##Rebuild and start local container and exit to it
	docker-compose up -d --build && docker exec -it linux_docker_goldrush bash

build: ##Rebuil local container without cache
	docker-compose build --no-cache