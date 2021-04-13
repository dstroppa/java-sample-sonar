# Build the artifact
FROM public.ecr.aws/hotmart/pipeline-maven:3.6-jdk-8 AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

# Run the artifact
FROM public.ecr.aws/bitnami/tomcat:8.5  
COPY --from=build /usr/src/app/target/ROOT.war /usr/local/tomcat/webapps/
