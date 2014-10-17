#!/bin/bash
#by admlaercio

serv_nfs="172.25.55.55:/mnt/nfs-export"

do_erro() {
 echo ">>> Erro! $1"
 echo
 echo "Uso: $0 <nome-host> <nome-vm>"
 echo "--> Ex: $0 servidor1 ubuntu12"
 exit 0
}

test -z $1 && do_erro "Falta nome Host hospedeiro"
test -z $2 && do_erro "Falta nome VM"
time LIBGUESTFS_TRACE=1 LIBGUESTFS_DEBUG=1 virt-v2v -o rhev -ic qemu+ssh://root@$1/system -osd $serv_nfs $2  2>&1 | tee /tmp/virt-v2v-$2-`date +%d%m%y%H%M`.log

