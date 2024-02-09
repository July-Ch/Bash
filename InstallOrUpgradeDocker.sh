function installDocker()
{
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

if ! command -v docker &> /dev/null
then echo "Docker not found. Install it now? (yes/no)"
	read qw
	if [[ $qw == "yes" ]]
	then installDocker
	echo "Docker is installed"
	break
	else echo "Docker is not installed"
	fi
else echo "Docker exists"
fi

floatHave=$(docker version --format '{{.Server.Version}}')
echo "Your version $floatHave"
echo "You need more than 23.0.1"
el2=$( echo ${floatHave:1:1} )
#echo "$el2"
if [[ el2 -lt 3 ]]
then echo "You need update Docker. Do it now? (yes/no)"
	read q
	if [[ $q == "yes" ]]
	then sudo apt-get upgrade docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	echo "Docker is updated"
	else echo "Don't forget to do it later"
	fi
else echo "You don't need to update"
fi
