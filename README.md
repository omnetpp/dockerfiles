# dockerfiles
Source files for building OMNeT++ related docker images

 - travis-base -> an image containing Linux, Windows and macOS compiled versions of OMNeT++ (for continuous integration)
   - travis-inet -> an image used to run continuous integration test for INET (contains NSC, ffmpeg and other optional INET dependnecies)
 - omnetpp-base -> ubuntu based image containing all required packages to build and use OMNeT++ (compiler, Qt libs, java etc.)
   - omnetpp -> contains a pre-build OMNeT++ distribution (for easy evaluation)
 - swarm-base -> tools and packages required to run OMNeT++ simulations in a docker swarm (distcc, compler, OMNeT++ - core)
