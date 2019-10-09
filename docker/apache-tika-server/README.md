# docker-tika-jaxrs-server

Dockerfile to create a docker image that contains the latest Ubuntu running the Apache Tika 1.22 Server on Port 9998 using Java 11.

Out-of-the-box the container also includes dependencies for the GDAL and Tesseract OCR parsers. The following language packs are currently installed:
* English
* Spanish

To install more languages simply update the apt-get command to include the package containing the language you require, or include your own custom packs using an ADD command.

## Add custom tika-config.xml

Modify configuration in `conf/tika-config.xml` and rebuild the image.

## Author

  * Oksana Cyrwus (<connect@oksanac.com>)

  [Original image](https://github.com/oksana-c/docker-tika-jaxrs-server) w/ extended README.

## Licence

Copyright 2019 Oksana Cyrwus

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.