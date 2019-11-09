#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc,char **argv)
{
  long root = argv[1] ? atol(argv[1]) : 0;
  int rank = 0;
  int commsize = 0;
  int len = 0;
  int i = 0;
  char procname[MPI_MAX_PROCESSOR_NAME];
  char *recvbuf, *sendbuf;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &commsize);
  MPI_Get_processor_name(procname, &len);

  double localtime = 0;
  double remotetime = 0;
  double offset = 0;
  if (rank == root) {
    for (i = 0; i < commsize; ++i) {
      if (i == root) continue;
      MPI_Recv(&remotetime, 1, MPI_DOUBLE, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      localtime = MPI_Wtime();
      MPI_Send(&localtime, 1, MPI_DOUBLE, i, 0, MPI_COMM_WORLD);
    }
  } else {
    localtime = MPI_Wtime();
    MPI_Send(&localtime, 1, MPI_DOUBLE, root, 0, MPI_COMM_WORLD);
    MPI_Recv(&remotetime, 1, MPI_DOUBLE, root, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    offset
    printf("Process %d of %d on %s(%d) received time %lf (%lf) from %d. Offset = %lf\n",rank, commsize, procname, remotetime, localtime, root);
  }
  MPI_Finalize();

  return 0;
}
