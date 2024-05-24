#!/bin/bash

##########################################################################
#
# Platform: USyd Artemis HPC and Pawsey Nimbus cloud
# Usage: qsub rds_2_nimbus.sh (from Artemis) OR sh rds_2_nimbus.sh (from Nimbus)
# Version: 1.0.0
#
# For more details see: https://github.com/Sydney-Informatics-Hub/Bio-toolkit
#
# If you use this script towards a publication, please acknowledge the
# Sydney Informatics Hub.
#
# Suggested acknowledgement:
# The authors acknowledge the support provided by the Sydney Informatics Hub,
# a Core Research Facility of the University of Sydney. This research
# was undertaken with the assistance of resources and services from the Pawsey
# Supercomputing Centre, which is supported by the Australian Government, and 
# the Australian BioCommons which is enabled by NCRIS via Bioplatforms Australia.
#
##########################################################################

# BEFORE RUNNING 
## Replace <PROJECT> with your DashR project code 
## Replace <PATH_TO_PEM_KEY> with your project code 
## Fill in rds_path/rds_dir/rds_file, nimbusIP and nimbus_path variables 
## Ensure your .pem file is stored both at nimbus and artemis $home directories
## Unhash the transfer command you want to use, depending on the direction of data movement

#PBS -P <PROJECT>
#PBS -N transfer
#PBS -l walltime=48:00:00
#PBS -l ncpus=1
#PBS -l mem=8GB
#PBS -W umask=022
#PBS -q dtq
#PBS -e ./transfer.e
#PBS -o ./transfer.o

# RDS credientials
rds_path=
rds_dir=
rds_file=

# nimbus vm credentials
nimbususer=ubuntu 
nimbusIP= #IP address of your Nimbus instance 
nimbus_path=

# transfer a file rds to nimbus
#rsync -tPvz --append-verify -e "ssh -i <PATH_TO_PEM_KEY>" \
#       ${rds_path}/${rds_file} ${nimbususer}@${nimbusIP}:${nimbus_path}

# transfer a directory rds to nimbus
#rsync -rtlPvz --append-verify -e "ssh -i <PATH_TO_PEM_KEY>" \
#        ${rds_path}/${rds_dir} ${nimbususer}@${nimbusIP}:${nimbus_path}

# transfer a file from nimbus
#rsync -tPvz --append-verify -e "ssh -i <PATH_TO_PEM_KEY>" \
#       ${nimbususer}@${nimbusIP}:${nimbus_path} ${rds_path}

# transfer a directory from nimbus
#rsync -rtPvz --append-verify -e "ssh -i <PATH_TO_PEM_KEY>" \
#        ${nimbususer}@${nimbusIP}:${nimbus_path} ${rds_path}