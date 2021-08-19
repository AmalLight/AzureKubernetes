
echo
docker ps -a
echo

read -p 'input ps -a rm: ' lista ; echo $lista

if (( ${#lista} == 0 ));
then
    docker rm -f $(docker ps -a -q)
else
    for inside in $lista;
    do
        docker rm -f $inside
    done
fi

docker network rm $(docker network ls -q)

# -------------------------------------------------------

echo
docker image list
echo

read -p 'input image rm: ' lista ; echo $lista

for inside in $lista;
do
    docker image rm $inside
done

# -------------------------------------------------------

read -p 'build image tomcat.dist [yes/..]: ' todo ;

if [[ $todo == "yes" ]];
then
    docker build -f ./Dockerfile -t tomcat.dist:latest ./
fi

read -p 'build image nginx.config [yes/..]: ' todo ;

if [[ $todo == "yes" ]];
then
    docker build -f ./Dockerfile2 -t nginx.config:latest ./
fi

# -------------------------------------------------------

echo
docker volume list
echo

read -p 'input volume rm: ' lista ; echo $lista

if (( ${#lista} == 0 ));
then
    docker volume rm $(docker volume list -q)
else
    for inside in $lista;
    do
        docker volume rm $inside
    done
fi

# -------------------------------------------------------

echo
docker volume list
echo

read -p 'input volume create: ' lista ; echo $lista

if (( ${#lista} == 0 ));
then
    docker volume create --opt o=size=10G --opt device=/var/lib --opt type=aufs mongodbdata
    docker volume create --opt o=size=10G --opt device=/var/lib --opt type=aufs  tomcatdata
    docker volume create --opt o=size=10G --opt device=/var/lib --opt type=aufs   nginxdata
    docker volume create --opt o=size=10G --opt device=/var/lib --opt type=aufs   mysqldata
else
    for inside in $lista;
    do
        docker volume create --opt o=size=10G --opt device=/var/lib --opt type=aufs $inside
    done
fi

# -------------------------------------------------------

echo
ls *yml
echo

noout='' ; if [[ $1 == '0' ]]; then noout='nohup' ; fi

read -p 'input ymls compose: ' lista ; echo $lista

if (( ${#lista} == 0 ));
then
    if (( ${#noout} > 0 ));
    then
        $noout docker-compose -f services.yml up &
    else
        docker-compose -f services.yml up
    fi
else
    for inside in $lista;
    do
        if (( ${#noout} > 0 ));
        then
            $noout docker-compose -f $inside.yml up &
        else
            docker-compose -f $inside.yml up
        fi
    done
fi

# -------------------------------------------------------

echo
echo 'sleep and ps -a check' 
echo
sleep 5

# -------------------------------------------------------

echo
docker ps -a
echo

read -p 'logs for docker ps -a id: ' lista ; echo $lista
for inside in $lista;
do
    docker logs $inside
done

# test for mongodb
#   mongo "mongodb://127.0.0.1:27017" -u root -p example
