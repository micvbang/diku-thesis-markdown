
\setcounter{secnumdepth}{1}
\setcounter{tocdepth}{1}

\appendix

# This be appendix A {#sec:appendix:a}

## Single-machine experiments
### PostgreSQL
- `shared_buffers` 30GB
- `temp_buffers` 4GB
- `work_mem` 50GB
- `max_wal_size` 5GB
- `autovacuum` off

### Greenplum
- `max_wal_size` 5GB
- `gp_vmem_protect_limit` 6GB
- `autovacuum` off

We ensure that the data is evenly distributed by using hash-partitioning on the primary key.

### Simba
- `spark.driver.memory` 30g
- `spark.executor.memory` 80g
- `spark.python.worker.memory` 1g
- `spark.driver.maxResultSize` 0
- `SPARK_WORKER_INSTANCES=1`
- `SPARK_WORKER_CORES=16`

## Distributed experiments

### PostgreSQL
- `shared_buffers` 15GB
- `temp_buffers` 4GB
- `work_mem` 40GB
- `max_wal_size` 5GB
- `autovacuum` off

### Simba
- `spark.driver.memory` 15g
- `spark.executor.memory` 40g
- `spark.python.worker.memory` 1g
- `spark.driver.maxResultSize` 0
- `SPARK_WORKER_INSTANCES=1`
- `SPARK_WORKER_CORES=8`

# This be appendix B {#sec:appendix:b}

## Some section
### Some subsection
TEXT!!!
