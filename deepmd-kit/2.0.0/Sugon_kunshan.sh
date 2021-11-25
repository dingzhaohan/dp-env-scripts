# You need to prepare files below
cd $home/opt/lebesgue/Soft
ls
# cmake-3.17.0.tar.gz  lammps-2Jul2021.tar.gz  deepmd-kit(github)  Python-3.6.8.tgz  vasp.5.4.4.tar.gz  tf_root.zip(1.14:rocm)

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


# ============= deepmd-kit & lammps =============
cd $home/opt/lebesgue/Soft

source $home/opt/lebesgue/env/Python_3.6.8_cpu_dpt.env
pip3 install -t $home/opt/lebesgue/software/Python_3.6.8_cpu_dpt/.local/bin virtualenv
virtualenv $home/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt

cd $home/opt/lebesgue/Soft
tar -zxvf lammps-2Jul2021.tar.gz

git clone https://gitee.com/deepmodeling/deepmd-kit.git
cd deepmd-kit
git checkout v2.0.0

source $home/opt/lebesgue/software/deepmd-kit_2.0.0_dcu_dpt/bin/activate
pip install $home/opt/lebesgue/Soft/tensorflow-2.2.0rc2-cp36-cp36m-linux_x86_64.whl -i https://pypi.tuna.tsinghua.edu.cn/simple
module unload compiler/rocm/2.9
module load compiler/rocm/3.3
export DP_VARIANT=rocm
pip install . -i https://pypi.tuna.tsinghua.edu.cn/simple


deepmd_source_dir=`pwd`
deepmd_root=`pwd`
tensorflow_root=$home/opt/lebesgue/Soft/tensorflow1.14_root


cd $home/opt/lebesgue/Soft/deepmd-kit/source
mkdir build && cd build

module purge
module load compiler/intel/oneapi-2021.3
module load compiler/rocm/2.9
module laod compiler/cmake/3.17.2
# source $home/opt/lebesgue/env/cmake_3.17.0_cpu_dpt.env

# cmake -DTENSORFLOW_ROOT=$tensorflow_root -DCMAKE_INSTALL_PREFIX=$deepmd_root -DUSE_ROCM_TOOLKIT=TRUE ..
cmake -DTENSORFLOW_ROOT=$tensorflow_root -DCMAKE_INSTALL_PREFIX=$deepmd_root -DUSE_ROCM_TOOLKIT=TRUE -DLAMMPS_VERSION_NUMBER=20210702 -DLAMMPS_SOURCE_ROOT=$home/opt/lebesgue/Soft/lammps-2Jul2021 -DROCM_ROOT=/opt/rocm ..

make -j && make install -j
ls $deepmd_root/lib
# libdeepmd_cc_low.so  libdeepmd_cc.so  libdeepmd_lmp_low.so  libdeepmd_lmp.so
# libdeepmd_op_rocm.so  libdeepmd_op.so  libdeepmd.so


make lammps
cp -r USER-DEEPMD $home/opt/lebesgue/Soft/lammps-2Jul2021/src
cd $home/opt/lebesgue/Soft/lammps-2Jul2021/src
make yes-kspace
make yes-manybody
make yes-meam
make yes-user-deepmd
make serial -j
make mpi -j

mkdir $home/opt/lebesgue/software/lammps_20210702_dcu_dpt/bin -p
cp lmp_serial $home/opt/lebesgue/software/lammps_20210702_cpu_dpt/bin
cp lmp_mpi $home/opt/lebesgue/software/lammps_20210702_cpu_dpt/bin

cat << EOF >> $home/opt/lebesgue/env/lammps_20210702_dcu_dpt.env
module purge
module load compiler/intel/oneapi-2021.3
module load compiler/rocm/2.9
export PATH=$home/opt/lebesgue/software/lammps_20210702_dcu_dpt/bin:$PATH
EOF





