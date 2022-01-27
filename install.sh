sudo apt-get install net-tools -y
sudo apt-get install python3-pip -y
sudo apt-get install iotop -y
pip install python-dotenv
pip install PyYAML
read -p "What is the SMTP Relay Hostname? " smtprelay
echo SMTP_HOSTNAME=$smtprelay | sudo tee -a ./.env
read -p "What is the Admin email address? " adminemail
echo OPENCTI_ADMIN_EMAIL=$adminemail | sudo tee -a ./.env
python3 init.py
sudo apt-get purge docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo apt-get update
sudo apt-get install \
     ca-certificates \
     curl \
     gnupg \
     lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
echo 'vm.max_map_count=1048575' | sudo tee -a /etc/sysctl.conf
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker.service
sudo systemctl start containerd.service
sudo apt-get install docker-compose -y
newgrp docker
docker-compose up -d
