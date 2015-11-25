scp esx01/welcome.orig esx01:/vmfs/volumes/dsLocalESX01/welcome.orig
ssh esx01 "/vmfs/volumes/dsLocalESX01/gen_welcome.sh"

scp esx02/welcome.orig esx02:/vmfs/volumes/dsLocalESX02/welcome.orig
ssh esx02 "/vmfs/volumes/dsLocalESX02/gen_welcome.sh"
