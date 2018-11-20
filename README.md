# rappel-docker

Docker image for Rappel: A linux-based assembly REPL for x86, amd64, armv7, and armv8   

Run:  
`docker run -ti --cap-add=SYS_PTRACE --security-opt seccomp=unconfined alanvivona/rappel-docker`   

> This will disable security features but will allow rappel to run in interactive mode.
