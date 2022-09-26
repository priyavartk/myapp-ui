set -e

echo "Sleeping for 20s"
sleep 20

export DEBIAN_FRONTEND=noninteractive

echo "Update apt"
sudo apt update

echo "Install pip3"
sudo apt install python3-pip -y

echo "Install ansible"
sudo apt install ansible -y

echo "Install boto3"
sudo pip3 install boto3
