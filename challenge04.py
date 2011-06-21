# Challenge 4: Task Duration - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: python2 challenge04.py or python3 challenge04.py (much faster with python2)
# Comments: Iterative implementation.

import sys
import marshal
import os.path

taskduration={}
taskdependencies={}

# returns a valid line (ignores empty lines and comments)
def read_next_line(f):
    line=f.readline()
    if not line:
        return line
    elif (len(line)==1) or (line[0]=='#'):
        return read_next_line(f)
    else:
        return line.strip()

# loads the task file
def read_task_file(name):
    f=open(name)
    # read number of tasks
    n=int(read_next_line(f))
    # read task duration in a dictionary
    for i in range(0, n):
        arrayline=read_next_line(f).split(',')
        taskduration[arrayline[0]] = int(arrayline[1])
    # read task dependencies in a dictionary
    line=read_next_line(f)
    while line:
        arrayline=line.split(',')
        taskdependencies[arrayline[0]] = arrayline[1:]
        line=read_next_line(f)
    f.close()

# serialization function
def retrieve_tasks():
    global taskduration, taskdependencies
    infile="in"
    sfile="serialized-in"
    if os.path.exists(sfile):
        try:
            f=open(sfile, "rb")
            (taskduration, taskdependencies) = marshal.load(f) # load
        except:
            read_task_file(infile) # read from plain text file
    else:    
        read_task_file(infile) # read from plain text file
        f=open(sfile, "wb")
        marshal.dump((taskduration, taskdependencies), f) # dump
    f.close()

# returns the minimal computation time for resolving the task
def task_computation_time(task):
    tasks=[task] # the tasks we are still processing (with deps)
    times=[0] # the partial time for each of those tasks
    maxtime=0 # the time needed counting only task processed
    while tasks:
        i=0 
        b=0
        end=len(tasks)
        while i<end: # for each task
            t=tasks[i]
            times[i]+=taskduration[t] # sum their duration
            j=i+b
            if t in taskdependencies: # if it have dependencies
                tasks = tasks[:j] + taskdependencies[t] + tasks[j+1:] # remove task, add their deps
                times = times[:j] + times[j:j+1]*len(taskdependencies[t]) + times[j+1:] # and copy the time
                b+=len(taskdependencies[t])-1
                i+=1
            else:
                maxtime=max(maxtime, times[j]) # is this task the longest until now?
                tasks = tasks[:j] + tasks[j+1:] # remove task
                times = times[:j] + times[j+1:] # and time of the task
                end-=1
    return maxtime

# input & output
retrieve_tasks()
for line in sys.stdin:
    for number in line.strip().split(','):
        if number:
            print(number + " " + str(task_computation_time(number)))

