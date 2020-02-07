#       Copyright 2017-2020 IBM Corp All Rights Reserved

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM openliberty/open-liberty:kernel-java8-openj9-ubi
USER root
COPY src/main/liberty/config /opt/ol/wlp/usr/servers/defaultServer/
COPY target/trader-1.0-SNAPSHOT.war /opt/ol/wlp/usr/servers/defaultServer/apps/TraderUI.war
RUN chown -R 1001:0 config/
USER 1001
RUN if [ -f certificate.pem ]; then keytool -import -v -trustcacerts -alias keycloak -file certificate.pem -keystore /opt/ol/wlp/usr/servers/defaultServer/resources/security/key.jks --noprompt --storepass passw0rd ; fi
RUN configure.sh
