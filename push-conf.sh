scp esx01/welcome.* esx01:/vmfs/volumes/dsLocalESX01/.
scp esx01/wait.* esx01:/vmfs/volumes/dsLocalESX01/.
scp esx01/gen_welcome.sh esx01:/vmfs/volumes/dsLocalESX01/.
ssh esx01 "/vmfs/volumes/dsLocalESX01/gen_welcome.sh"

scp esx02/welcome.orig esx02:/vmfs/volumes/dsLocalESX02/welcome.orig
ssh esx02 "/vmfs/volumes/dsLocalESX02/gen_welcome.sh"
