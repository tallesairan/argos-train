apt-get install virtualenv nano
su argosopentech
cd ~/
./argos-train-init
source ~/env/bin/activate
export CUDA_VISIBLE_DEVICES=0,1
cd ~/argos-train