# Test application

Here is a simple test application for diploma project.

It consists of docker image (nginx with simple config), qbec/jsonnet driven K8s deployment resources? and CI/CD pipeline for it.

On each commit the latest image is builded and tested, and jsonnet resources are verified. On tag creation, 
testapp is also deployed into prod environment.

This project depends on infra project, whose artifacts are using for cluster access and application deployment. 

