# How to use UCI's HPC:

1. email jfarran@uci.edu with your UCINetID requesting an account
2. open a Terminal session (Mac: Terminal, Windows: putty, Linux: you know what's up)
3. ssh UCINetID@hpc.oit.uci.edu
4. your UCINetID password is your password
5. optional: google UCI HPC, find the page I'm reading from, and setup passwordless ssh
6. google UCI HPC and find the page I'm reading from
7. Welcome to your root directory on the HPC! You can create directories and files to your heart's content using any method you know from Linux (you knew you'd have to learn it someday)
8. You currently are on a login node, which is not meant for large computations (I think the suggestion is to stay for ~1 hour)
9. If you want to interactively work on the HPC (rather than start a program and walk away), enter: `qrsh` and plug away
10. Mostly, you'll want to login, move/edit some files, submit a job (i.e. request to start a program), and then logoff to wait for the program to finish. For this, you'll write a qsub script:

##############################################
#!/bin/bash

# the following are called flags and are optional. there are many and you should probably use some each time
#$ -q free64 # the queue you want to run your code. you can enter `q' to see a list of available queues
#$ -N myjobsname
#$ -m beas		# send me an email when my job (b)egins, (e)nds, (a)borts, and (s)uspends

#######################
# BASH CODE GOES HERE
#######################
##############################################




You'll need to play around a bit with exactly how the Bash code should look, but we'll provide an example for matlab code soon.


11. To make this qsub script, create a new file (you can type `nano qsub_ex.sh`) and copy paste the above code. If you don't have your own bash code to run, go ahead and use `echo Hello world!'
12. Save your file and exit out of the editor (ctrl-o to save and ctrl-x to exit using the nano editor on a Mac)
13. Submit your job by entering `qsub qsub_ex.sh`
14. See the status by entering `qstat -u $USER`
15. check the output file to see if the content is as expected



# How to use matlab on the HPC:

1. Successfully carry out the above steps.
2. Get your code on the HPC (write the file on the HPC or find some method of moving a file on your local machine to the HPC such a rsync)
3. `module load MATLAB' to load matlab on your current node
4. `mcc -m main.m' to compile your matlab code into a format that does not require the use of a matlab license to run. even if main.m calls other m-files, the compiler will figure that out and connect them all. ideally, main.m is a function and you call save at the end to save/savefig whatever data/figures you want
5. this will generate an executable file called main. Replace # BASH CODE GOES HERE with `./main $INPUTVARIABLE1 $INPUTVARIABLE2`
6. submit your qsub script (see 13 from above)
7. If your main.m has input variables, you probably got an error. This is because bash is dumb and passes your inputs in to matlab as strings, not numbers. the only way I know to deal with this is to change the beginning of your code:

##############################################
function y = main(x)

x = str2double(x);
y = x.^2;
##############################################



# Parallelization on the HPC:

1. If you want to run your program multiple, independent times (for checking different parameter values, or processing different-but-similar files) you can create a job array!
2. add the following flag to your qsub script: `#$ -t 1-10'
3. Now you can access the task id using `$SGE_TASK_ID' to index your parameter vector or file naming system or whatever.
4. For parameters, I like to let matlab handle all that (I'm more familiar with it than bash), so I make the task ID an input to my main.m function. this is then the last line of my qsub script: `./main $SGE_TASK_ID'
5. Submit a job array to find the sum of the first N integers.

