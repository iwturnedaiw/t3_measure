# t3_measure
This tool measures for cpu utilization of an interactive node on TSUBAME 3.0.

## Usage
### On login node
```
$ cd <workspace>
$ git clone https://github.com/iwturnedaiw/t3_measure.git
$ cd t3_measure
$ chmod +x .t3_measure/measure.sh
$ cp -r .t3_measure ${HOME}
```

### Start an interactive job
```
$ iqrsh -l h_rt=<time>
```

### On interactive node
```
$ screen
$ cd ${HOME}/.t3_measure
$ ./measure.sh
NODEID: r7i7n6
...
Measurement Started!
(To return the console, please push Ctrl + A + D)
```
Once you return, please continue to use the interactive node.
You don't have to finalize the measurement. (If the interactive job ends, measurements will also end. )

