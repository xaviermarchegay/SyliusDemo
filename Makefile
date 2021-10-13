.PHONY: bash bash-root build ps rebuild start startd

NAME = sylius
VERSION = 1.0.0
TARGETS := $(MAKEFILE_LIST)
SHELL := /bin/bash

include ./make/Makefile.composer
include ./make/Makefile.database
include ./make/Makefile.docker
include ./make/Makefile.misc
include ./make/Makefile.php-fpm
include ./make/Makefile.yarn

update:
	git pull
	make composer-update
	make restart-php
	make yarn-compile

quick-update:
	git pull
	make composer-install-dev
	make restart-php
