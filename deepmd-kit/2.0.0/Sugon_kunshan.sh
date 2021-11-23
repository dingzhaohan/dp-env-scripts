# You need to prepare files below
cd $home/opt/lebesgue/Soft


# ============= Python 3.6.8 =============
cd $home/opt/lebesgue/Soft
tar -zxvf Python-3.6.8.tgz
cd $home/opt/lebesgue/Soft/Python-3.6.8

./configure --prefix=$home/opt/lebesgue/software/Python_3.6.8_cpu_dpt
make -j && make install

cat << EOF >> $home/opt/lebesgue/env/Python_3.6.8_cpu_dpt.env
export PATH=$home/opt/lebesgue/software/Python_3.6.8_cpu_dpt/bin:\$PATH
export PATH=$home/opt/lebesgue/software/Python_3.6.8_cpu_dpt/.local/bin:\$PATH
export LD_LIBRARY_PATH=$home/opt/lebesgue/software/Python_3.6.8_cpu_dpt/lib:\$LD_LIBRARY_PATH
EOF


# ============= cmake 3 =============
cd $home/opt/lebesgue/Soft
tar -zxvf cmake-3.17.0.tar.gz
cd cmake-3.17.0
./configure --prefix=$home/opt/lebesgue/software/cmake_3.17.0_cpu_dpt
make -j && make install

cat << EOF >> $home/opt/lebesgue/env/cmake_3.17.0_cpu_dpt.env
export PATH=$home/opt/lebesgue/software/cmake_3.17.0_cpu_dpt/bin:$PATH
EOF


# ============= deepmd-kit =============
cd $home/opt/lebesgue/Soft

source $home/opt/lebesgue/env/Python_3.6.8_cpu_dpt.env
pip3 install -t $home/opt/lebesgue/software/Python_3.6.8_cpu_dpt/.local/bin virtualenv
virtualenv $home/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt
source $home/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt/bin/activate

pip install $home/opt/lebesgue/Soft/tensorflow-*****.whl

cd $home/opt/lebesgue/Soft
tar -zxvf lammps-2Jul2021.tar.gz
cp -r lammps-2Jul2021 $home/opt/lebesgue/software

git clone https://gitee.com/deepmodeling/deepmd-kit.git
cd deepmd-kit
git checkout v2.0.0

deepmd_source_dir=`pwd`
deepmd_root=`pwd`
tensorflow_root=$home/opt/lebesgue/Soft/tensorflow1.14_root


cd $home/opt/lebesgue/Soft/deepmd-kit/source
mkdir build && cd build

source $home/opt/lebesgue/env/cmake_3.17.0_cpu_dpt.env
cmake -DTENSORFLOW_ROOT=$tensorflow_root -DCMAKE_INSTALL_PREFIX=$deepmd_root -DLAMMPS_VERSION_NUMBER=20210702 -DLAMMPS_SOURCE_ROOT=$home/opt/lebesgue/software/lammps-2Jul2021 ..

make lammps









