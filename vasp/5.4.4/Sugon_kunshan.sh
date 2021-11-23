home_dir=`pwd`
cd $home_dir/opt/lebesgue/Soft



tar -zxvf vasp.5.4.4.tar.gz
cd vasp.5.4.4
cp arch/makefile.include.linux_intel makefile.include

module purge
module load compiler/intel/oneapi-2021.3
make all

mkdir $home_dir/opt/lebesgue/software/vasp_5.4.4_amd_dpt
cp -r bin $home_dir/opt/lebesgue/software/vasp_5.4.4_amd_dpt/bin


cat << EOF >> $home_dir/opt/lebesgue/env/vasp_5.4.4_amd_dpt.env
module purge
module load compiler/intel/oneapi-2021.3
export PATH=~/opt/lebesgue/env/vasp_5.4.4_amd_dpt/bin:\$PATH
EOF


