apt-get install -y virtualenv nano
su argosopentech
cd ~/
./argos-train-init
source ~/env/bin/activate
cd ~/argos-train

screen -S argos-train
export CUDA_VISIBLE_DEVICES=0,1,2,3