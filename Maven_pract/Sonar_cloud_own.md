### integration sonarqube with maven code analysis ###
 open sonar cloud.io  --> create account through bit account --> analyze your first project--> create project manually -->key (reddiproject)-->select free plan--->project key (prasad)--->setup
 choose analysis method---< select maven---> now this give some information like varialble name,value of env variable and update pom.xml and command run sonar scan

 update pom.xml 
    <sonar.organization>prasadreddi</sonar.organization>
                <sonar.host.url>https://sonarcloud.io</sonar.host.url>
 ## export sonar varible
   #export SONAR_TOKEN=ff5bce407a76957d4f0eb494b86a97cc731874cf
## run scnner cmnd
#/opt/maven/bin/mvn mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=Reddi
#/opt/maven/bin/mvn verify sonar:sonar -Dsonar.projectKey=Reddi
now ur report shown in ur sonar cloud go and check