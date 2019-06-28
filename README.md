# dockerfiles
Source files for building OMNeT++ related docker images

 - omnetpp-base -> ubuntu based image containing all required packages to build and use OMNeT++ on the command line (clang compiler, make etc.)
   - omnetpp -> contains a pre-built OMNeT++ distribution for quickly compiling and running a model in Cmdenv (No IDE or Qtenv support!)
   - omnetpp-gui-base -> contains additional packages required to build all GUI tools (Qt, JRE, OSG libraries etc.)
     - omnetpp-gui -> contains a pre-built OMNeT++ with all GUI tools, that can be access using X from the host
 - swarm-base -> tools and packages required to run OMNeT++ simulations in a docker swarm (distcc, compiler, OMNeT++ core)
 - travis-base -> an image containing Linux, Windows and macOS compiled versions of OMNeT++ (for continuous integration)
   - travis-inet -> an image used to run continuous integration test for INET (contains NSC, ffmpeg and other optional INET dependnecies)
