while true
do
if [ ! -f /home/argosopentech/argostrain-dev/run/openmt.model_step_20000.pt ]
then
    echo "File does not exist in Bash  SLEEP 1S"
else
    echo "File found openmt.model_step_20000.pt"
    mv /home/argosopentech/argostrain-dev/run/openmt.model_step_20000.pt /home/argosopentech/argostrain-dev/run/openmt.model_step_10000.pt
    echo "mOVED TO /home/argosopentech/argostrain-dev/run/openmt.model_step_10000.pt"
    break

fi
sleep 1
done

python -m http.server 131.226.210.190:8000
C:\Users\Administrator\Documents\Models
onmt_train -config config.yml --num_threads 90

/home/argosopentech/argostrain-dev/run/translate-en_es-1_2.argosmodel

-rw-rw-r--  1 argosopentech argosopentech 2.3G May 30 06:31 openmt.model_step_10000.pt
-rw-rw-r--  1 argosopentech argosopentech 2.3G May 30 02:40 openmt.model_step_9000.pt




b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain-dev/run/translate-en_es-1_2.argosmodel v1/translate-en_es-1_2.argosmodel
b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain-dev/run/openmt.model_step_9000.pt v1/checkpoints/openmt.model_step_9000.pt
b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain-dev/run/openmt.model_step_10000.pt v1/checkpoints/openmt.model_step_10000.pt



b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain/run/translate-en_es-1_2.argosmodel v2/translate-en_es-1_2.argosmodel
b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain/run/openmt.model_step_29000.pt v2/checkpoints/openmt.model_step_29000.pt
b2 upload-file --info model=1.2 --threads 2 AIMODELS /home/argosopentech/argostrain/run/openmt.model_step_30000.pt v2/checkpoints/openmt.model_step_30000.pt




keyID:
003529bf1cc5ba10000000003
keyName:
aimodes
applicationKey:
K003WGKEp1sdm5Gno/dZCm1QytzPhRA