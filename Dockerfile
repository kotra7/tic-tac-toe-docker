FROM maven AS buildstage
RUN mkdir /opt/chandu
WORKDIR /opt/chandu
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/chandu/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
