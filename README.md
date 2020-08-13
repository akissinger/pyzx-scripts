# PyZX Scripts

This is code I use for doing experiments and benchmarking based on the quantum circuit optimisation library [PyZX](https://github.com/Quantomatic/pyzx).

Since it is designed to run on a multi-user compute server, long computations are set up to run via [PBS](https://en.wikipedia.org/wiki/Portable_Batch_System).

This code is designed to run "next door" to the latest git version of PyZX in your home directory. This works fine for me, and I probably won't change that without a good reason. To run do this:

    cd
    git clone https://github.com/Quantomatic/pyzx.git
    git clone https://github.com/akissinger/pyzx-scripts.git
    cd pyzx-scripts
    make -j8         # to run on 8 cores
    make pbs         # to run with PBS (also on 8 cores)

