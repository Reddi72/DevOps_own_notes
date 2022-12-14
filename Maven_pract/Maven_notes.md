## Maven ##
Maven is a code build tool which used to convert your code to artifact. this is widely used plugin to build in continuous integration
## What does the build tool?	
• Generates source code (if the auto-generated code is used)
• Generates documentation from source code
• Compiles source code
• Packages compiled code into a JAR or ZIP file
• Installs the packaged code in the local repository, server repository, or central repository
## What is POM?
POM stands for Project Object Model this file contains the project information and configuration details for Maven to build the project. It contains information such as dependencies, source directory, a build directory, plugins, goals, etc.Maven reads the pom.xml file and executes the desired goal .older version of Maven 2 this file was named as project.xml, for the latest version since Maven 2 this file was renamed as POM.XML.
## What all is included in the POM?
The following elements are necessary for creating a pom.xml file:
•	project- The root element of the pom.xml file is the project.
•	modelVersion- It identifies which version of the POM model you're working with. For Maven 2 and Maven 3, use version 4.0.0.
•	groupId- groupId is the project group's identifier. It is unique, and you will most likely use a group ID that is similar to the project's root Java package name.
•	artifactId- It is used for naming the project you're working on.
•	version- The version number of the project is contained in the version element. If your project has been released in multiple versions, it is helpful to list the versions.
Other Pom.xml File Elements
•	dependencies- This element is used to establish a project's dependency list.
•	dependency- dependency is used inside the dependencies tag to define a dependency. The groupId, artifactId, and version of each dependency are listed.
•	name- This element is used to give our Maven project a name.
•	scope- This element is used to specify the scope of this maven project, which can include compile, runtime, test, among other things.
•	packaging- The packaging element is used to package our project into a JAR, WAR, and other output formats.
## What are the different phases in the Maven Build Lifecycle?
Build Lifecycle has different build phases or stages, which are below:
•	Validate: Make sure the project is correct and that you have ll of the necessary information.
•	Test: Test the compiled source code using an appropriate unit testing framework. instead, take the compiled code and package it in a manner that can be distributed, such as a JAR.
•	Compile: Compile the project's source code.
•	Verify: Perform any necessary checks on integration test findings to ensure that quality criteria are met.
•	Install: Adds the package to the local repository, allowing it to be used as a dependency in other projects.
•	Deploy: Copies the entire package to the remote repository for sharing with other developers and organizations, and is done in the build environment
#mvn package:Creates JAR or WAR file for the project to
 convert it into a distributable format.

