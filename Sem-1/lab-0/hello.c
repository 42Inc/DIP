#include <unistd.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
  int rank, commsize;
  int len;
  char procname[MPI_MAX_PROCESSOR_NAME];

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &commsize);
  MPI_Get_processor_name(procname, &len);

  printf("Hello from %d of %d from %s\n", rank + 1, commsize, procname);

  MPI_Finalize();
  return 0;
}
