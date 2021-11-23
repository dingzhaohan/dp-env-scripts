# You need to prepare files below
home_dir=`pwd`
cd $home_dir/opt/lebesgue/Soft


# ============= Python 3.6.8 =============
cd $home_dir/opt/lebesgue/Soft
tar -zxvf Python-3.6.8.tgz
cd $home_dir/opt/lebesgue/Soft/Python-3.6.8

./configure --prefix=$home_dir/opt/lebesgue/software/Python_3.6.8_cpu_dpt
make -j && make install

cat << EOF >> $home_dir/opt/lebesgue/env/Python_3.6.8_cpu_dpt.env
export PATH=~/opt/lebesgue/env/Python_3.6.8_cpu_dpt/bin:\$PATH
export LD_LIBRARY_PATH=~/opt/lebesgue/env/Python_3.6.8_cpu_dpt/lib:\$LD_LIBRARY_PATH
EOF


# ============= cmake 3 =============
cd $home_dir/opt/lebesgue/Soft
tar -zxvf cmake-3.17.0.tar.gz
cd cmake-3.17.0
./configure --prefix=$home_dir/opt/lebesgue/software/cmake_3.17.0_cpu_dpt
make -j && make install


# ============= deepmd-kit =============
cd $home_dir/opt/lebesgue/Soft

source $home_dir/opt/lebesgue/env/Python_3.6.8_cpu_dpt.env
pip install virtualenv
virtualenv $home_dir/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt
source $home_dir/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt/bin/activate

pip install $home_dir/opt/lebesgue/Soft/tensorflow-*****.whl


git clone https://gitee.com/deepmodeling/deepmd-kit.git
cd deepmd-kit
git checkout v2.0.0

deepmd_source_dir=`pwd`
deepmd_root=`pwd`
tensorflow_root=$home_dir/opt/lebesgue/Soft/....tf

cd source
mkdir build && cd build

# ============= lammps =============








