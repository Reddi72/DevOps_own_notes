all the containers run in single os.one container connect to another container by docker networking spaces.
#docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
255d57918e76   bridge    bridge    local
2d5442774961   host      host      local
cebb53b00737   none      null      local

docker networks are 4 types
1. Bridge network: is default network..Bridge networks are usually used when your applications run in standalone containers that need to communicate. connect the contianers thorugh private ips and both apps are same port no problem here we done port mapping..

2. host network:when ur deploy the containers in host os that treats the both applications running in same host os. a continer connected to b continer through local host.port mappig not require and private ip not configured.
        here u can't maintian the container in same port

3. null network: deploy a container and maybe that container running in a application.that application very indepedent ..that application no need to connect with other containers then use null network

4. overlay network: communicate multiple containers in different os/servers through overlay network.This strategy removes the need to do OS-level routing between these containers.

#docker run -n bridge --name web2 -d prasad/amxntmct run