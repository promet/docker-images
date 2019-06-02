# Promet Source php images
This directory contains Dockefiles and build scripts for the following php-fpm images:

* prometsource/php
* prometsource/php7.1
* prometsource/php7.2
* prometsource/php7.3

All images above are the "latest", with images also tagged with Ubuntu16.04 and minor Ubuntu version updates, and pushed to Docker Hub.

These images are build based on the prometsource/base image, which is an Ubuntu 16.04 image.  These images are designed to be used with either NginX or Apache2, running PHP as a service.

These images are automatically built daily, and pushed up to Docker Hub with updates.  As Ubuntu 16.04 releases minor versions, updates to the prometsource/base image as well as the prometsource/php{version} images are automatically tagged appropriately and pushed up to Docker Hub.  This preserves the previously built image versions so that images can be pinned in a docker-compose.yml file for a specific project if needed.

To utilize a specific PHP version built on a specific minor version image, use an image tag in your docker-compose.yml file as follows:
* prometsource/php7.3:ubuntu-16.04.6

If you tag an image as follows:

* prometsource/php7.3:ubuntu-16.04

You will be using the latest Ubuntu-16.04 build.

Tagging an image as follows:

* prometsource/php7.3

Will get you the latest php7.3 image build.  Currently this is the same as using:

* prometsource/php7.3:ubuntu-16.04
