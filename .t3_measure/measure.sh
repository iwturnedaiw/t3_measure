#! /bin/bash

OUTPUT_MPSTAT_INTERVAL=5
OUTPUT_PROC_INTERVAL=20
MEASURE_DIR="${HOME}/.t3_measure"
MEASURE_CMD="mpstat -P ALL ${OUTPUT_MPSTAT_INTERVAL}"
LOG_DIR=${MEASURE_DIR}/log

DATE=`date +%Y%m%d%H%M%S`
LOG=${LOG_DIR}/interactive_job_${DATE}.log
OUTPUT_MPSTAT=mpstat_file_${DATE}.txt
OUTPUT_TASKS_INFO=tasks_${DATE}.txt

function out_my_task_ids () {
  while :
  do
    ctime=`date +%Y%m%d%H%M%S`
    task_ids=`pgrep -u ${USER}`
    task_ids=(${task_ids//, / })
    echo "CURRENT_TIME: ${ctime}, JID: ${JOB_ID}, CPUSET: ${SGE_BINDING}, #TASKS: ${#task_ids[@]}, TASKS: ${task_ids[@]}"
    sleep ${OUTPUT_PROC_INTERVAL} 
  done
}
 

function measure () {
  echo "NODEID: ${HOST}"
  echo "JOB_ID: ${JOB_ID}"
  echo "CPUSET: ${SGE_BINDING}"
  echo "intreq: ${SGE_HGR_TASK_interq}"

  mkdir -p ${MEASURE_DIR}/${JOB_ID}
  cd ${MEASURE_DIR}/${JOB_ID}

  ${MEASURE_CMD} >> ${OUTPUT_MPSTAT} &
  out_my_task_ids >> ${OUTPUT_TASKS_INFO} &
  echo "Measurement Started!"
  
  wait
  echo "Measurement DONE"
}

measure | tee -a ${LOG} 
